class CreateTravellers < ActiveRecord::Migration[7.1]
  def change
    create_table :travellers do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
