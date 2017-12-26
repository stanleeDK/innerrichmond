class NeighborhoodsController < ApplicationController

	def show 
		@daycareproviders 	= Neighborhood.where(slug: params[:id]).first.realdaycareproviders
		@ngb_name 			= Neighborhood.where(slug: params[:id]).first.neighborhood_name
		@neighborhood_link_content = Neighborhood.all.limit(60).order("RANDOM()")
		render template: "daycareprovider/neighborhood_show"
	end 


end
