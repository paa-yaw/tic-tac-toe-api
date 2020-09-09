class AddPointSystemToGameModel < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :points, :integer
    add_column :games, :points, :integer, default: 1
    add_reference :games, :winner, foreign_key: { to_table: :users }
  end
end
