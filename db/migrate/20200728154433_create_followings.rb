class CreateFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :followings do |t|
      t.references :follower, index:true, foreign_key: true
      t.references :followee,

      t.timestamps
    end
    add_foreign_key :followings, :users, column: :followee_id
  end
end
