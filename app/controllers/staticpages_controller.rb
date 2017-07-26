class StaticpagesController < ApplicationController

	def home_page
		@neighborhoods = Neighborhood.all

	end 

	def officialaddresses #api endpoint for the crappy jquery autocomplete
		# if params[:searchterm]
			@officialaddresses = OfficialAddress.search_official_addresses(params[:searchterm])
			render json: @officialaddresses
		# else
			# @officialaddresses = OfficialAddress.first(5)
		# end 		
	end



end
