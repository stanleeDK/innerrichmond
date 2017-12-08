class NeighborhoodsController < ApplicationController

	def index
	end 

	def show
		nb = Neighborhood.find(params[:id])
		# nb = Neighborhood.find_by(neighborhood_name: params[:name])
		@ngb_name = nb.neighborhood_name
		@dcps = nb.daycareproviders		
	end 


end
