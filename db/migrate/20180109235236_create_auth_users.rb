class CreateAuthUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_users do |t|
      t.string :username

      t.timestamps
    end
  end
end
