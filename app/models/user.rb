class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :firstname, presence: true, length: {maximum: 50}
  validates :lastname, presence: false, length: {maximum: 50}

  has_many :tools 
  has_many :reservations
  has_many :reviews

  def self.from_omniauth(auth)
  	user = User.where(:email => auth.info.email).first

  	if user 
  		return user 
  	else 
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.proivder 
        user.firstname = auth.info.first_name
        user.lastname = auth.info.last_name
  			user.uid = auth.uid 
  			user.email = auth.info.email 
  			user.image = auth.info.image 
  			user.password = Devise.friendly_token[0,20]
      end 
  	end 
  end 
end
