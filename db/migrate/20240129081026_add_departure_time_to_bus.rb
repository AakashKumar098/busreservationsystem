class AddDepartureTimeToBus < ActiveRecord::Migration[7.1]
  def change
    add_column :buses, :departuretime, :datetime
  end
end
