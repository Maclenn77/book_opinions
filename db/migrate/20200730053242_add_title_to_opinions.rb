class AddTitleToOpinions < ActiveRecord::Migration[6.0]
  def change
    add_column :opinions, :title, :string
  end
end
