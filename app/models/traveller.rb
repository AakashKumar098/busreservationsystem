class Traveller < ApplicationRecord
  belongs_to :reservation
  belongs_to :seat
end
