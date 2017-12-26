
namespace :normalize do 
	desc "reset id numbers"
	task :reset_realdaycareproviders_table_ids => :environment do
		ActiveRecord::Base.connection.reset_pk_sequence!('realdaycareproviders')
	end 
end 


namespace :normalize do 
	desc "normalize_to_realdaycareproviders"
	task :normalize_to_realdaycareproviders => :environment do
		
		# ActiveRecord::Base.connection.reset_pk_sequence!('realdaycareproviders')
		
		# get all of the ones from children's council
		smalldaycareproviders 	= Daycareprovider.all
		dupe_daycares 			= Array.new
		puts "CCSF count: #{smalldaycareproviders.count}"

		#now normalize ccsf (childrens't council SF)
		smalldaycareproviders.each_with_index do |smalldcp, i|

			puts "#{i} #{smalldcp.name}"
			realdcprovider 					= Realdaycareprovider.new
			realdcprovider.name 			= smalldcp.name
			realdcprovider.business_name 	= smalldcp.alternate_name
			realdcprovider.daycare_type 	= "Home Based Daycare"
			realdcprovider.phone 			= smalldcp.phone
			realdcprovider.email 			= smalldcp.email
			realdcprovider.url 				= smalldcp.url
			realdcprovider.address 			= smalldcp.mail_address_1
			# realdcprovider.neighborhood 	= smalldcp.
			# realdcprovider.age_range 		= smalldcp.
			# realdcprovider.schedule 		= smalldcp.
			realdcprovider.zip_code 		= smalldcp.mail_zip_code
			realdcprovider.description 		= smalldcp.description
			realdcprovider.license_id_1 	= smalldcp.daycarelicenses.first.state_license_number
			if smalldcp.daycarelicenses.size > 1
				realdcprovider.license_id_2 = smalldcp.daycarelicenses.second.state_license_number
			end
			# realdcprovider.license_id_3 	= smalldcp.

			# puts realdcprovider.name 	
			realdcprovider.save
			
		end 


		# compare them to the dss licensees and remove dupes from the 
		# dss cohort, you want to remove from dss because the ccsf ones have 
		# more data ;) 
		smalldaycareproviders.each_with_index do |dcp, i|
			smalldaycare = DssCaGovDayCareRaw.where(facilitynumber: dcp.daycarelicenses.first.state_license_number)
			if !smalldaycare.blank? #not a dupe so don't put into array! 
				dupe_daycares.push(dcp.daycarelicenses.first.state_license_number)
			end
		end
		puts "DSS dupes already in CCSF cohort: #{dupe_daycares.count}"

		dssdaycareproviders = DssCaGovDayCareRaw.where.not(facilitynumber: dupe_daycares)
		puts "DSS non-dupe count: #{dssdaycareproviders.count}"

	
		# now normalize all of the dss ones 
		dssdaycareproviders.each_with_index do |dss, i|

			puts "#{i} #{dss.facilityname}"
			realdcprovider 					= Realdaycareprovider.new
			realdcprovider.name 			= dss.facilityname
			realdcprovider.business_name 	= dss.facilityname
			realdcprovider.daycare_type 	= dss.facilitytype
			realdcprovider.phone 			= dss.telephone
			# realdcprovider.email 			= dss.
			# realdcprovider.url 			= dss.
			realdcprovider.address 			= dss.streetaddress
			# realdcprovider.neighborhood 	= dss.
			# realdcprovider.age_range 		= dss.
			# realdcprovider.schedule 		= dss.
			realdcprovider.zip_code 		= dss.zipcode
			realdcprovider.license_id_1 	= dss.facilitynumber
			# realdcprovider.license_id_2 	= dss.
			# realdcprovider.license_id_3 	= dss.

			realdcprovider.save
		end

	end 
end 
