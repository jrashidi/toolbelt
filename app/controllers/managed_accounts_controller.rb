class ManagedAccountsController < ApplicationController
	before_action :authenticate_user!

	def new 
		@user = current_user 
	end 

	def create
		Stripe.api_key = PLATFORM_SECRET_KEY
		Stripe::Account.create(
		  {
		    :country => "US",
		    :managed => true
		    :
		  }
		)

	end 

	def show

	end 

	def update 

	end 

	def destroy 

	end
	
end
