class Seat < ApplicationRecord
  # validates :status ,presence: true 
  validate :check_status_value
  belongs_to :bus
  has_one :reservation



  private 

    def check_status_value
      if (status != true && status != false)
        errors.add(:status,"must be either true or false")
      end
    end

end