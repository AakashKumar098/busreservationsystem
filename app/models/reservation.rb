class Reservation < ApplicationRecord

  validates :dateofjourney ,presence:true 
  validate :validate_future_date
  belongs_to :user
  belongs_to :bus
  has_many :travellers ,dependent: :destroy


  private 

  def validate_future_date
    if dateofjourney.present?  && dateofjourney < Date.today
      errors.add(:dateofjourney,"should be future date ")
    end
  end

end