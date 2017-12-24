require 'net/http'
require 'erb'
include ERB::Util
require 'json'

namespace :geocode do 
	desc "test "
	task :test_rails_associations => :environment do

		ActiveRecord::Base.connection.reset_pk_sequence!('neighborhoods')
		
		#show how you can access all the daycares in a hood
		n = Neighborhood.first
		puts n.realdaycareproviders.first.name

		# find any daycares hood
		daycares = Realdaycareprovider.find(3)
		puts daycares.neighborhood.neighborhood_name


	end 
end 

namespace :geocode do 
	desc "geocode realdaycareproviders"
	task :geocode_realdaycareproviders => :environment do
		puts "starting to geocode"

		daycares = Realdaycareprovider.where(neighborhood: nil).where.not(address: "Unavailable")

		daycares.each_with_index do |realdc, i| 
			puts "#{realdc.address} #{realdc.zip_code}"
			encoded_address = url_encode("#{realdc.address},San Francisco,CA,#{realdc.zip_code}")

			# puts url_encode("2355 Anza St,San Francisco,CA,94118")
			# uri  = URI.parse('https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=AIzaSyCnmgExygLuo6BD7yq7-Rfu40BXAo2oUd4')
			uri  = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?address=#{encoded_address}&key=AIzaSyCnmgExygLuo6BD7yq7-Rfu40BXAo2oUd4")
			http 				= Net::HTTP.new(uri.host, uri.port)
			http.use_ssl 		= true
			http.verify_mode 	= OpenSSL::SSL::VERIFY_NONE
			
			res 	= http.get(uri)
			payload = JSON.parse(res.body)

			if res.code == "200" 
				if payload['status'] = "OK" && payload['results'].count > 0
			
					puts "#{realdc.address} #{realdc.zip_code} #{payload['results'][0]['address_components'][2]['long_name']} #{payload['status']}"

					the_hood 	= payload['results'][0]['address_components'][2]['long_name']
					hoodexists 	= Neighborhood.where(neighborhood_name: the_hood)
					if hoodexists.count == 0
						newhood 					= Neighborhood.new 
						newhood.neighborhood_name 	= the_hood
						newhood.slug 				= the_hood.to_s.downcase.gsub(" ", "-")
						newhood.save 
						
						realdc.neighborhood_id = newhood.id
						realdc.save 
					else 
						puts hoodexists.inspect
						realdc.neighborhood_id = hoodexists.first.id
						realdc.save 						
					end 
				end 
			else 
				puts "Didn't work #{realdc.address} #{realdc.zip_code}, #{payload['status']}"
			end 

		end 
	end 
end 
