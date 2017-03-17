class UsersController < ApplicationController 
	def show 
		@user = User.find(params[:id])
		@tools = @user.tools
	end

end 