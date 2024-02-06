class AddDateOfJourneyToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :dateofjourney, :date
  end
end
