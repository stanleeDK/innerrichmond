class NeighborhoodsController < ApplicationController

	def index
	end 

	def show_old_neighborhood_abstraction
		nb = Neighborhood.find(params[:id])
		# nb = Neighborhood.find_by(neighborhood_name: params[:name])
		@ngb_name = nb.neighborhood_name
		@dcps = nb.daycareproviders		
	end 

	def show 
		@daycareproviders 	= Neighborhood.where(slug: params[:id]).first.realdaycareproviders
		 @ngb_name 			= Neighborhood.where(slug: params[:id]).first.neighborhood_name
		render template: "daycareprovider/neighborhood_show"
	end 


end
