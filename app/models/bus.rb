class Bus < ApplicationRecord
    validates :busname ,presence:true 
    validates :bus_no, presence: true, numericality: { only_integer: true },uniqueness: true
    validates :source_route ,presence:true 
    validates :destination_route ,presence:true 
    validates :noofseat ,presence:true,numericality: { only_integer: true }  
    #validates :arrival_time, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/, message: "should be in the format YYYY-MM-DD HH:MM:SS" }
    #validates :departuretime, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/, message: "should be in the format YYYY-MM-DD HH:MM:SS" }
    
    belongs_to :owner ,class_name: "User"
    has_many :seats ,dependent: :destroy
    has_many :reservations ,dependent: :destroy



    def journey_time_in_hours
        journey_duration = (departuretime - arrival_time).to_f  # Get the difference between departure and arrival times in seconds
        journey_duration_in_hours = journey_duration / 3600  # Convert seconds to hours
        journey_duration_in_hours.round(2)  # Round the result to two decimal places
    end
end
