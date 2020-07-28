class CreateOpinions < ActiveRecord::Migration[6.0]
  def change
    create_table :opinions do |t|
      t.user :belongs_to
      t.text :body

      t.timestamps
    end
  end
end
