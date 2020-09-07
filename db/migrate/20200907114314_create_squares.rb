class CreateSquares < ActiveRecord::Migration[6.0]
  def change
    create_table :squares do |t|
      t.integer :position
      t.string :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
