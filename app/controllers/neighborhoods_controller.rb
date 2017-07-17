class NeighborhoodsController < ApplicationController

	def index
	end 

	def show
		nb = Neighborhood.find(params[:id])
		@ngb_name = nb.neighborhood_name
		@dcps = nb.daycareproviders		
	end 

end
