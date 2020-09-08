class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :duration, default: 0
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
