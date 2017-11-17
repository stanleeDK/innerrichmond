require 'open-uri'
require 'net/http'
require 'json'

# - still need to figure things out that have to do with complaints 
# - still need to get the links to the reports 


namespace :ingest do 
	desc "scrape_ccsf"
	task :reset_dss_table_ids => :environment do
		ActiveRecord::Base.connection.reset_pk_sequence!('dss_ca_day_care_raws')
	end 
end 

namespace :ingest do 
	desc "scrape_dss"
	task :scrape_dss => :environment do
		puts "hello"

		# Family Child Care Home(Large) 0-2		https://secure.dss.ca.gov/ccld/TransparencyAPI/api/FacilitySearch?facType=810&facility=&Street=&city=&zip=&county=San%20Francisco&facnum=
		# Childcare Infant 0-2					https://secure.dss.ca.gov/ccld/TransparencyAPI/api/FacilitySearch?facType=830&facility=&Street=&city=&zip=&county=San%20Francisco&facnum=
		# Childcare Pre-School 2-5				https://secure.dss.ca.gov/ccld/TransparencyAPI/api/FacilitySearch?facType=850&facility=&Street=&city=&zip=&county=San%20Francisco&facnum=
		# School Age 5-17						https://secure.dss.ca.gov/ccld/TransparencyAPI/api/FacilitySearch?facType=840&facility=&Street=&city=&zip=&county=San%20Francisco&facnum=

		uri  = URI.parse('https://secure.dss.ca.gov/ccld/TransparencyAPI/api/FacilitySearch?facType=810&facility=&Street=&city=&zip=&county=San%20Francisco&facnum=')
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		
		res = http.get(uri)
		payload = JSON.parse(res.body)

		facility_detail_uri = 'https://secure.dss.ca.gov/ccld/TransparencyAPI/api/FacilityDetail/'
		payload['FACILITYARRAY'].each do |daycare|
			puts daycare['FACILITYNAME']
			uri2 = URI.parse(facility_detail_uri + daycare['FACILITYNUMBER'])
			http2 = Net::HTTP.new(uri2.host, uri2.port)
			http2.use_ssl = true
			http2.verify_mode = OpenSSL::SSL::VERIFY_NONE

			res2 = http2.get(uri2)
			payload2 = JSON.parse(res2.body)
			# puts payload2['FacilityDetail']['CAPACITY'];

			dss_daycare_provider = DssCaGovDayCareRaw.new
			dss_daycare_provider.capacity 			= payload2['FacilityDetail']['CAPACITY']
			dss_daycare_provider.city  				= payload2['FacilityDetail']['CITY']
			dss_daycare_provider.contact  			= payload2['FacilityDetail']['CONTACT']
			dss_daycare_provider.county  			= payload2['FacilityDetail']['COUNTY']
			dss_daycare_provider.districtoffice  	= payload2['FacilityDetail']['DISTRICTOFFICE']
			dss_daycare_provider.doaddress			= payload2['FacilityDetail']['DOADDRESS']
			dss_daycare_provider.docity 			= payload2['FacilityDetail']['DOCITY']
			dss_daycare_provider.dostate  			= payload2['FacilityDetail']['DOSTATE']
			dss_daycare_provider.dotelephone  		= payload2['FacilityDetail']['DOTELEPHONE']
			dss_daycare_provider.dozipcode  		= payload2['FacilityDetail']['DOZIPCODE']
			dss_daycare_provider.facilityname  		= payload2['FacilityDetail']['FACILITYNAME']
			dss_daycare_provider.facilitynumber  	= payload2['FacilityDetail']['FACILITYNUMBER']
			dss_daycare_provider.facilitytype  		= payload2['FacilityDetail']['FACILITYTYPE']
			dss_daycare_provider.lastvisitdate 		= payload2['FacilityDetail']['LASTVISITDATE']
			dss_daycare_provider.licenseeffectivedate  = payload2['FacilityDetail']['LICENSEEFFECTIVEDATE']
			dss_daycare_provider.licensefirstdate  		= payload2['FacilityDetail']['LICENSEFIRSTDATE']
			dss_daycare_provider.licenseename  			= payload2['FacilityDetail']['LICENSEENAME']
			dss_daycare_provider.nbrallvisits  			= payload2['FacilityDetail']['NBRALLVISITS']
			dss_daycare_provider.nbrcmpltvisits  		= payload2['FacilityDetail']['NBRCMPLTVISITS']
			dss_daycare_provider.nbrcmplttypa  			= payload2['FacilityDetail']['NBRCMPLTTYPA']
			dss_daycare_provider.nbrcmplttypb  			= payload2['FacilityDetail']['NBRCMPLTTYPB']
			dss_daycare_provider.nbrcmpltinc  			= payload2['FacilityDetail']['NBRCMPLTINC']
			dss_daycare_provider.nbrcmpltuns  			= payload2['FacilityDetail']['NBRCMPLTUNS']
			dss_daycare_provider.nbrcmpltsub  			= payload2['FacilityDetail']['NBRCMPLTSUB']
			dss_daycare_provider.nbrcmpltunf  			= payload2['FacilityDetail']['NBRCMPLTUNF']
			dss_daycare_provider.nbrinspvisits  		= payload2['FacilityDetail']['NBRINSPVISITS']
			dss_daycare_provider.nbrinsptypa  			= payload2['FacilityDetail']['NBRINSPTYPA']
			dss_daycare_provider.nbrinsptypb  			= payload2['FacilityDetail']['NBRINSPTYPB']
			dss_daycare_provider.nbrothervisits  		= payload2['FacilityDetail']['NBROTHERVISITS']
			dss_daycare_provider.nbrothertypa  			= payload2['FacilityDetail']['NBROTHERTYPA']
			dss_daycare_provider.nbrothertypb  			= payload2['FacilityDetail']['NBROTHERTYPB']
			dss_daycare_provider.state  				= payload2['FacilityDetail']['STATE']
			dss_daycare_provider.status  				= payload2['FacilityDetail']['STATUS']
			dss_daycare_provider.streetaddress  		= payload2['FacilityDetail']['STREETADDRESS']
			dss_daycare_provider.telephone  			= payload2['FacilityDetail']['TELEPHONE']
			dss_daycare_provider.vstdateall  			= payload2['FacilityDetail']['VSTDATEALL']
			dss_daycare_provider.vstdatecmplt  			= payload2['FacilityDetail']['VSTDATECMPLT']
			dss_daycare_provider.vstdateinsp  			= payload2['FacilityDetail']['VSTDATEINSP']
			dss_daycare_provider.vstdateother  			= payload2['FacilityDetail']['VSTDATEOTHER']
			dss_daycare_provider.zipcode  				= payload2['FacilityDetail']['ZIPCODE']
			dss_daycare_provider.totcmpvisits  			= payload2['FacilityDetail']['TOTCMPVISITS']
			dss_daycare_provider.totsubalg  			= payload2['FacilityDetail']['TOTSUBALG']
			dss_daycare_provider.totincalg  			= payload2['FacilityDetail']['TOTINCALG']
			dss_daycare_provider.totunsalg  			= payload2['FacilityDetail']['TOTUNSALG']
			dss_daycare_provider.totunfalg  			= payload2['FacilityDetail']['TOTUNFALG']
			dss_daycare_provider.tottypea  				= payload2['FacilityDetail']['TOTTYPEA']
			dss_daycare_provider.tottypeb  				= payload2['FacilityDetail']['TOTTYPEB']
			dss_daycare_provider.cmpcount  				= payload2['FacilityDetail']['CMPCOUNT']
			puts payload2['FacilityDetail']['COMPLAINTARRAY']
			puts payload2['TSO']['FacilityNumber']
			puts payload2['TSO']['CaseClosed']
			puts payload2['TSO']['PleadingDate']
			puts payload2['TSO']['ActionType']
			# dss_daycare_provider.complaintarray  = payload2['FacilityDetail']['COMPLAINTARRAY']
			# dss_daycare_provider.tsocase  = payload2['FacilityDetail']['CAPACITY']

			dss_daycare_provider.save

		end 	


	end 
end 
