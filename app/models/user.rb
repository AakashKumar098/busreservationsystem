class User < ApplicationRecord
  validates :name ,presence:true 
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "is not a valid email address" }
  validates :password ,presence:true 
  has_many :buses ,foreign_key: "owner_id" ,dependent: :destroy
  has_many :reservations,dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_type: { busowner: 'busowner', customer: 'customer' }
  
end
