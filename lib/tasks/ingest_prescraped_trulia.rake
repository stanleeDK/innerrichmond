require 'csv'
require 'open-uri'
require 'nokogiri'
require 'date'

namespace :ingest do 
	desc "scrape_trulia"
	task :scrape_trulia => :environment do

		path = "https://www.trulia.com/sold/94118_zip/"
		doc = Nokogiri::HTML(open(path))

		# <div class="cardDetails man pts pbn phm h6 typeWeightNormal">
		# 	<div>
		# 		<span class="cardPrice h5 man pan typeEmphasize noWrap typeTruncate">$1,625,000</span>
		# 		<!-- react-empty: 2247 -->
		# 	</div>
		# <div>
		# 	<ul class="listInline typeTruncate mvn">
		# 	<li data-auto-test="beds"><i class="iconBed"></i><!-- react-text: 2252 -->4bd<!-- /react-text --></li>
		# 	<li data-auto-test="baths"><i class="iconBath"></i><!-- react-text: 2255 -->3ba<!-- /react-text --></li>
		# 	<li data-auto-test="sqft"><!-- react-text: 2257 -->2,060 sqft<!-- /react-text --></li>
		# 	</ul>
		# </div>
		# </div>


		# get the list of properties on the main page 
		properties = doc.css('.cardDetails')
		puts properties.length

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


namespace :db do 
	desc "Match to Official Addresses, add to official addresses if it can't be matched"
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
