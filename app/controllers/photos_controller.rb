class PhotosController < ApplicationController 

	def destroy 
		@photo = Photo.find(params[:id])
		tool = @photo.tool

		@photo.destroy
		@photos = Photo.where(tool_id: tool.id)

		respond_to :js
	end 

end 