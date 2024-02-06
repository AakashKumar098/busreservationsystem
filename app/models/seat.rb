class Seat < ApplicationRecord
  # validates :status ,presence: true 
  validate :checkstatusvalue
  belongs_to :bus
  has_one :reservation



  private 

    def checkstatusvalue
      if (status != true && status != false)
        errors.add(:status,"must be either true or false")
      end
    end

end