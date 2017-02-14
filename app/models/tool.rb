class Tool < ApplicationRecord
  belongs_to :user
  has_many :photos 
  has_many :reservations
  has_many :reviews
  accepts_nested_attributes_for :photos

  geocoded_by :address
  after_validation :geocode, if: :address_changed? 


  validates :tool_type, presence: true 
  validates :model_type, presence: true 
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true 

  def average_rating 
    reviews.count == 0 ? 0 :reviews.average(:star).round(2)
  end 
 
end
