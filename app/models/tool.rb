class Tool < ApplicationRecord
  belongs_to :user

  validates :type, presence: true 
  validates :model_type, presence: true 
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true 
 
end
