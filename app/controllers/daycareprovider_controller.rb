class DaycareproviderController < ApplicationController



	def show
		# -- show all data
		# @dssdaycareproviders 	= DssCaGovDayCareRaw.all
		# @smalldaycareproviders 	= Daycareprovider.all
		# @dss_daycare_count 		= DssCaGovDayCareRaw.count
		

		# -- remove dupes between dss and ccsf
		@smalldaycareproviders 	= Daycareprovider.all
		dupe_daycares 			= Array.new

		
		@smalldaycareproviders.each_with_index do |dcp,index|
			smalldaycare = DssCaGovDayCareRaw.where(facilitynumber: dcp.daycarelicenses.first.state_license_number)
			if !smalldaycare.blank? #not a dupe! 
				dupe_daycares.push(dcp.daycarelicenses.first.state_license_number)
			end
		end 

		@dssdaycareproviders 	= DssCaGovDayCareRaw.where.not(facilitynumber: dupe_daycares)
		@dss_daycare_count 		= @dssdaycareproviders.length

	end 

	def search 
		user_input 				= params[:searchinput]
		@smalldaycareproviders 	= Daycareprovider.where(mail_zip_code: user_input)
		dupe_daycares 			= Array.new

		@smalldaycareproviders.each_with_index do |dcp,index|
			smalldaycare = DssCaGovDayCareRaw.where(facilitynumber: dcp.daycarelicenses.first.state_license_number)
			if !smalldaycare.blank? #not a dupe! 
				dupe_daycares.push(dcp.daycarelicenses.first.state_license_number)
			end
		end 

		@dssdaycareproviders 	= DssCaGovDayCareRaw.where.not(facilitynumber: dupe_daycares).where(zipcode: user_input)
		@dss_daycare_count 		= @dssdaycareproviders.length
		@u_input 				= user_input
	end 


end
