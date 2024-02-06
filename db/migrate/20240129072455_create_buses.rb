class CreateBuses < ActiveRecord::Migration[7.1]
  def change
    create_table :buses do |t|
      t.string :busname
      t.integer :bus_no
      t.string :source_route
      t.string :destination_route
      t.integer :noofseat
      t.datetime :arrival_time
      t.integer :owner_id

      t.timestamps
    end

    add_foreign_key :buses, :users, column: :owner_id

  end
end
