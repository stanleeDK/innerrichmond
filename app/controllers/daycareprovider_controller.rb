class DaycareproviderController < ApplicationController


	def show
		@daycareproviders = Realdaycareprovider.all.order("LENGTH(name) DESC")

	end 

	def show_old
		# -- show all data
		# @dssdaycareproviders 	= DssCaGovDayCareRaw.all
		# @smalldaycareproviders 	= Daycareprovider.all
		# @dss_daycare_count 		= DssCaGovDayCareRaw.count
		

		# -- remove dupes between dss and ccsf. First get all the ccsf ones because they have more data
		# -- then loop through them and if it exists in the dss group then don't include it. The way
		# -- you don't include it is to create a new array which you pass to the view
		# -- the view then renders both arrays 
		@smalldaycareproviders 	= Daycareprovider.all.limit(100)
		dupe_daycares 			= Array.new

		
		@smalldaycareproviders.each_with_index do |dcp,index|
			smalldaycare = DssCaGovDayCareRaw.where(facilitynumber: dcp.daycarelicenses.first.state_license_number)
			if !smalldaycare.blank? #not a dupe! 
				dupe_daycares.push(dcp.daycarelicenses.first.state_license_number)
			end
		end 

		@dssdaycareproviders 	= DssCaGovDayCareRaw.where.not(facilitynumber: dupe_daycares)
		@dss_daycare_count 		= @dssdaycareproviders.length
		@total_daycare_count_after_deduping = @dssdaycareproviders.length + @smalldaycareproviders.length

	end 

	def search 
		user_input 				= params[:searchinput]

		# @smalldaycareproviders 	= Daycareprovider.where(mail_zip_code: user_input)
		# dupe_daycares 			= Array.new

		# @smalldaycareproviders.each_with_index do |dcp,index|
		# 	smalldaycare = DssCaGovDayCareRaw.where(facilitynumber: dcp.daycarelicenses.first.state_license_number)
		# 	if !smalldaycare.blank? #not a dupe! 
		# 		dupe_daycares.push(dcp.daycarelicenses.first.state_license_number)
		# 	end
		# end 

		# @dssdaycareproviders 	= DssCaGovDayCareRaw.where.not(facilitynumber: dupe_daycares).where(zipcode: user_input)
		# @dss_daycare_count 		= @dssdaycareproviders.length

		@daycareproviders 		= Realdaycareprovider.where(zip_code: user_input)
		@u_input 				= user_input
	end 


end
