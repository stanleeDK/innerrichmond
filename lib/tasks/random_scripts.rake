namespace :random do 
	desc "populate neighborhoods"
	task :populate_neighborhoods => :environment do
		puts "starting"

		ActiveRecord::Base.connection.reset_pk_sequence!('neighborhoods')

		nbs = Realdaycareprovider.select(:neighborhood).distinct
		nbs.each_with_index do |n,i|

			if !n.neighborhood.nil?
				puts n.neighborhood
				kvarter 					= Neighborhood.new 
				kvarter.neighborhood_name 	= n.neighborhood
				kvarter.slug 				= n.neighborhood.to_s.downcase.gsub(" ", "-")
				kvarter.save 
			end 
		end 

	end 
end 


namespace :random do 
	desc "populate neighborhoods ids into Realdaycareprovider"
	task :populate_neighborhoods => :environment do
		puts "starting"

		realdcp = Realdaycareprovider.all
		realdcp.each_with_index do |n,i|

			if !n.neighborhood.nil?
				

			end 
		end 

	end 
end 













