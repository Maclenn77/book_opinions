class DropUsersTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :users

    create_table :users do |t|
      t.string :name
      t.string :fullname
      t.string :token

      t.timestamps
    end
  end
end
