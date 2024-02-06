class CreateSeats < ActiveRecord::Migration[7.1]
  def change
    create_table :seats do |t|
      t.integer :seat_id
      t.references :bus, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
