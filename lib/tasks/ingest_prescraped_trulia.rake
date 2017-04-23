require 'csv'

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