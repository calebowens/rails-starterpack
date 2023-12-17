class CreateDbUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :db_users do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
