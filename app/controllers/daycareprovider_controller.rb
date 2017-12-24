class DaycareproviderController < ApplicationController


	def show
		@daycareproviders = Realdaycareprovider.all.limit(50).order("RANDOM()")
		@neighborhood_link_content = Neighborhood.all.limit(16).order("RANDOM()")
	end 

	def search 
		user_input 				= params[:searchinput]
		@daycareproviders 		= Realdaycareprovider.where(zip_code: user_input)
		@u_input 				= user_input
	end 


end
