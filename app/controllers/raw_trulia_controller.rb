class RawTruliaController < ApplicationController

	def show
		@trulia_properties = IngestedTruliaProperty.all
		@temp = "helloasdfads"
		render "raw_trulia/trulia_raw"
	end 
end
