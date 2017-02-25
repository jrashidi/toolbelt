class ReservationsController < ApplicationController 
	before_action :authenticate_user!

	require "rubygems"
	require "braintree"

	Braintree::Configuration.environment = :sandbox
	Braintree::Configuration.merchant_id = ENV['MERCHANT_ID']
	Braintree::Configuration.public_key = ENV['PUBLIC_KEY']
	Braintree::Configuration.private_key = ENV['PRIVATE_KEY']

	def preload 
		tool = Tool.find(params[:tool_id])
		today = Date.today 
		reservations = tool.reservations.where("start_date >= ? OR end_date >= ?", today, today)

		render json: reservations
	end 

	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create 
		@reservation = current_user.reservations.create(reservations_params)

		redirect_to @reservation.tool, notice: "Your Rental Is Pending Approval"
	end 

	def update
		@reservations = Reservation.find(params[:id])
		@reservations.update_attributes(confirmation: true)

		redirect_to your_reservations_path, notice: "Reservation Confirmed"

	end 

	def destroy 
		@reservation = Reservation.find(params[:id])
		@reservation.destroy 

		redirect_to your_rentals_path, notice: "This Reservation Was Canceled"
	end 

	def your_rentals 
		@rentals = current_user.reservations
	end 


	def your_reservations
		@tools = current_user.tools
	end 

	def pending_reservations
		@tools = current_user.tools		
	end 


	private 
		def is_conflict(start_date, end_date)
			tool = Tool.find(params[:tool_id])

			check = tool.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
			check.size > 0? true : false
		end

		def reservations_params 
			params.require(:reservation).permit(:start_date, :end_date, :price, :total, :tool_id, :confirmation)
		end 
end 