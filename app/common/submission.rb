class Submission < SimpleDelegator
  class Errors < Phlex::HTML
    def initialize(errors)
      @errors = errors
    end

    def template
      if @errors.present?
        div(class: "submission-errors") do
          @errors.each do |error|
            p { error }
          end
        end
      end
    end
  end

  def self.blank
    Submission.new({})
  end

  def initialize(hash)
    @errors = hash.transform_values { [] }

    super
  end

  def valid?
    errors.values.all? { _1.blank? }
  end

  def ensures_present(attribute, message: nil)
    if self[attribute].blank?
      message ||= "#{attribute} must be provided".humanize

      errors[attribute] << message
    end
  end

  def ensures_valid_email(attribute, message: nil)
    message ||= "#{attribute} does not appear to be valid".humanize

    email_validation_errors = ValidatesEmailFormatOf.validate_email_format(self[attribute], message:)

    errors[attribute].push(*email_validation_errors) if email_validation_errors.present?
  end

  def ensure(attribute, message:, &block)
    errors[attribute] << message unless block.call(self[attribute])
  end

  def errors_for(attribute)
    Errors.new(errors[attribute])
  end

  # We at first are just going to define several private methods that perform the validation
  # Do they even need to be private?
  #
  # submission.ensures_present(:attribute) <- is this something I'd like to do?
  # submission.ensures_valid_email(:email)
  # submisison.ensures_truthy(-> {}, message: "Foo bar baz") # This is a special case
  # submisison.ensures(:email, message: "Foo bar baz") { User.exists_with_email?(_1) }

  private

  attr_reader :errors
end
