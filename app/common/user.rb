class User
  class UserCreationError < StandardError
  end

  delegate :email, to: :@db_user

  def initialize(db_user:)
    @db_user = db_user
  end

  def self.create!(email:, password:)
    db_user = DbUser.new(email:, password:)
    if db_user.save
      User.new(db_user:)
    else
      raise UserCreationError, "Failed to create a user #{db_user.errors.full_messages.join(", ")}"
    end
  end

  def self.exists_with_email?(email)
    DbUser.exists?(email:)
  end

  def self.from_login_details(email:, password:)
    db_user = DbUser.authenticate_by(email:, password:)

    if db_user
      User.new(db_user:)
    end
  end

  def self.from_session(session)
    db_user = DbUser.find_by(id: session[:user_id])

    if db_user
      User.new(db_user:)
    end
  end

  def add_to_session(session)
    session[:user_id] = @db_user.id
  end

  def remove_from_session(session)
    session.delete(:user_id)
  end
end
