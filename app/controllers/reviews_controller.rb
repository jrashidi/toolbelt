class ReviewsControler < ApplicationController 
	def create 
		@review = current_user.reviews.create(review_params)
		redirect_to @review.tool
	end 

	def destroy 
		@review = Review.find(param[:id])
		tool = @review.tool 
		@review.destroy 

		redirect_to tool
	end 

	private 
		def review_params 
			params.require(:review).permit(:comment, :star, :tool_id)
		end 
end 