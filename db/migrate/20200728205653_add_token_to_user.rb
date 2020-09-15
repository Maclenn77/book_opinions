# frozen_string_literal: true

# This add a token
class AddTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :token, :string
  end
end
