class ReservationsController < ApplicationController 
	before_action :authenticate_user!

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

	def destroy 

	end 

	def your_rentals 
		@rentals = current_user.reservations
	end 

	def your_reservations
		@tools = current_user.tools
	end 

	private 

	def is_conflict(start_date, end_date)
		tool = Tool.find(params[:tool_id])

		check = tool.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
		check.size > 0? true : false
	end

	def reservations_params 
		params.require(:reservation).permit(:start_date, :end_date, :price, :total, :tool_id)
	end 
end 