class CreateFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :followings do |t|
      t.bigint :follower_id, foreign_key: true
      t.bigint :followee_id,

      t.timestamps
    end
    add_foreign_key :followings, :users, column: :followee_id
    add_index :followings, :id, name: :index_on_followee_id
    add_index :followings, :id, name: :index_on_follower_id
  end
end
