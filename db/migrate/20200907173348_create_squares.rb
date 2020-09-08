class CreateSquares < ActiveRecord::Migration[6.0]
  def change
    create_table :squares do |t|
      t.integer :position, null: false
      t.string :value
      t.integer :user_id
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
