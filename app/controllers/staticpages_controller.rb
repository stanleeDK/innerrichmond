class StaticpagesController < ApplicationController

	def home_page
	end 

	def officialaddresses
		# if params[:searchterm]
			@officialaddresses = OfficialAddress.search_official_addresses(params[:searchterm])
			render json: @officialaddresses
		# else
			# @officialaddresses = OfficialAddress.first(5)
		# end 		
	end

end
