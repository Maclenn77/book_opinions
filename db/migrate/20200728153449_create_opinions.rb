class CreateOpinions < ActiveRecord::Migration[6.0]
  def change
    create_table :opinions do |t|
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
