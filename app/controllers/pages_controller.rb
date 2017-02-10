class PagesController < ApplicationController

  def home
  	@tools = Tool.all
  end

  def search

  		if params[:search].present?  && params[:search].strip != ""
  			session[:loc_search] = params[:search]
  		end 

  		arrResult = Array.new 

  		if session[:loc_search] && session[:loc_search] != ""
  			@tools_address = Tool.where(active: true).near(session[:loc_search], 10, order: 'distance')
  		else
  			@tools_address = Tool.where(active: true).all  
  		end 

  		@search = @tools_address.ransack(params[:q])
  		@tools = @search.result

  		@arrTools = @tools.to_a

  		if (params[:start_date] && params[:end_date] && !params[:start_date].empty? && !params[:end_date].empty?)

			start_date = Date.parse(params[:start_date])
			end_date = Date.parse(params[:end_date])

			@tools.each do |tool|
				not_available = tool.reservations.where(
					"(? <= start_date AND start_date <= ?)
					OR (? <+ end_date AND end_date <= ?)
					OR (start_date < ? AND ? < end_date)",
					start_date, end_date,
					start_date, end_date,
					start_date, end_date).limit(1)

				if not_available.length > 0 
					@arrTools.delete(tool)
				end 
			end 

		end 
	end
end
