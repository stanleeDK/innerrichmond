class RawTruliaController < ApplicationController

	def show
		@trulia_properties = IngestedTruliaProperty.all
		@temp = "helloasdfads"
		render "raw_trulia/show_raw_trulia_data"
	end 
end
