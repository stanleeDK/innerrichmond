

require 'csv'



namespace :db do 
	desc "Grab stuff from a raw trulia file"
	task :match_trulia_to_official => :environment do

		puts "scrape trulia and put into a csv file"
		# csv format 
		# value;size;address;streetname;streetnum;zipcode;streettype;apartment;unitnum;sold_at;city;source;property_page_url
		
		count = 1
		IngestedTruliaProperty.all.each do |prop|
			
			
			matches = OfficialAddress.where(street_name: prop.street_name,street_type: prop.street_type, address_number: prop.address_number)

			if matches.length > 1 
				puts "#{count} #{prop.address} #{matches.length} more than one"
			elsif matches.length == 0 
				puts "#{count} #{prop.address} no match" 
			else
				# puts "#{count} #{prop.address} #{matches[0].address} " 
				puts "#{count}" 
			end 

			count = count + 1
		end 


	end 
end 



namespace :db do 
	desc "Grab stuff from a raw trulia file"
	task :ingest_raw_trulia_csv => :environment do
		counter = 1
		CSV.foreach("#{Dir.home}/Dropbox/Your Code/Ruby/innerrichmond/db/trulia_94118.csv",headers:true,col_sep:";") do |row|
		
			property 	= row.to_hash
			
			# puts "#{property} #{counter}"

			property["value"] 	= property["value"].delete("$");
			property["value"] 	= property["value"].delete(",");
			property["address"] = property["address"].split(",")[0]
			property["size"] 	= property["size"].delete(" sqft")
			property["city"]	= property["city"].delete(",CA/")
			property["unitnum"]	= property["unitnum"].delete("#")

			puts "---------------"
			# puts property

			trulia 					= IngestedTruliaProperty.new 
			trulia.address 			= property["address"]
			trulia.address_number 	= property["streetnum"]
			trulia.street_name		= property["streetname"]
			trulia.street_type		= property["streettype"]
			trulia.unit_number		= property["unitnum"]
			trulia.zipcode			= property["zipcode"]
			trulia.square_feet		= property["size"]
			trulia.value 			= property["value"]
			trulia.sold_at 			= property["sold_at"]
			trulia.property_page 	= property["property_page_url"]

			# puts "formated #{trulia.inspect}" 
			if trulia.save 
				puts "#{counter} saved"
			else 
				puts "#{counter} not saved"
			end
			counter 	= counter + 1 

			# if counter == 2 then exit end 

		end
	end 
end 