class DaycareproviderController < ApplicationController


	def show
		@daycareproviders = Realdaycareprovider.all.order("LENGTH(name) DESC")
	end 

	def search 
		user_input 				= params[:searchinput]
		@daycareproviders 		= Realdaycareprovider.where(zip_code: user_input)
		@u_input 				= user_input
	end 


end
