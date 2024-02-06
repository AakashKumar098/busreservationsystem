class RemoveSeatIdFromReservations < ActiveRecord::Migration[7.1]
  def change
    # removed foreign key 
    remove_foreign_key :reservations, :seats

    # Remove the seat_id column
    remove_column :reservations, :seat_id
  end
end
