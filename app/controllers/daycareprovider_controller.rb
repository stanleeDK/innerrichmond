class DaycareproviderController < ApplicationController


	def show
		@daycareproviders = DssCaGovDayCareRaw.all
		@smalldaycareproviders = Daycareprovider.all
		@dss_daycare_count = DssCaGovDayCareRaw.count
	end 


end
