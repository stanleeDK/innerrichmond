require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'

# curl 'https://childrens-council.herokuapp.com/api/providers' 
# -H 'Accept: application/json' 
# -H 'Referer: https://www.childrenscouncil.org/families/find-child-care/child-care-referrals/child-care-search/' 
# -H 'Origin: https://www.childrenscouncil.org' 
# -H 'If-Modified-Since: Mon, 26 Jul 1997 05:00:00 GMT' 
# -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36' 
# -H 'DNT: 1' 
# -H 'Content-Type: application/json;charset=UTF-8' 
# --data-binary '{"per_page":15,"providers":{"address":"94118, San Francisco, CA","agesServiced":158,"acceptsChildren":"FULL_TIME","typesOfCare":["Family Child Care","Child Care Center"],"yearlySchedule":"FULL_YEAR","weeklySchedule":["MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY"],"distance":5,"ageGroups":["PRESCHOOL_1","SCHOOL_2"],"locationA":{"latitude":37.7822891,"longitude":-122.463708}},"parent":{"care_reasons":["Looking for Work"],"found_option":"Flyer/brochure","full_name":"Stan Lee","email":"stan.lee@outlook.dk","home_zip_code":"94118","near_address":"","phone":"","subscribe":false,"children":[{"ageWeeks":158,"yearlySchedule":"FULL_YEAR"}]}}' --compressed

namespace :ingest do 
	desc "scrape_ccsf"
	task :scrape_ccsf_feb_2019 => :environment do
		puts "starting scrape"
		ActiveRecord::Base.connection.reset_pk_sequence!('ccsf_raw_feb19s')
		
		uri  = URI.parse('https://childrens-council.herokuapp.com/api/providers')
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true 

		json_headers = {
			"Content-Type" 	=> "application/json;charset=UTF-8",
		    "Accept" 		=> "application/json",
		    "Referer"		=> "https://www.childrenscouncil.org/families/find-child-care/child-care-referrals/child-care-search/",
		    "Origin"		=> "https://www.childrenscouncil.org",
		    "DNT"			=> "1",
		    "User-Agent"	=> "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.109 Safari/537.36",
		    "If-Modified-Since" => "Mon, 26 Jul 1997 05:00:00 GMT"
		}

		search_parameters = 
		{
		  "per_page": 1,
		  "providers": {
		    "address": "94118, San Francisco, CA",
		    "agesServiced": 158,
		    "acceptsChildren": "FULL_TIME",
		    "typesOfCare": [
		      "Family Child Care",
		      "Child Care Center"
		    ],
		    "yearlySchedule": "FULL_YEAR",
		    "weeklySchedule": [
		      "MONDAY",
		      "TUESDAY",
		      "WEDNESDAY",
		      "THURSDAY",
		      "FRIDAY"
		    ],
		    "distance": 5,
		    "ageGroups": [
		      "PRESCHOOL_1",
		      "SCHOOL_2"
		    ],
		    "locationA": {
		      "latitude": 37.7822891,
		      "longitude": -122.463708
		    }
		  },
		  "parent": {
		    "care_reasons": [
		      "Looking for Work"
		    ],
		    "found_option": "Flyer/brochure",
		    "full_name": "Stan Lee",
		    "email": "stan.lee@outlook.dk",
		    "home_zip_code": "94118",
		    "near_address": "",
		    "phone": "",
		    "subscribe": false,
		    "children": [
		      {
		        "ageWeeks": 158,
		        "yearlySchedule": "FULL_YEAR"
		      }
		    ]
		  }
		}

		response = http.post(uri.path, search_parameters.to_json, json_headers)
		payload = JSON.parse(response.body)

		# t = payload['content'][0]["ageGroupFrom"].to_json
		# v = payload['content'][0]["attributes"].to_json
		# puts JSON.parse(v)["environment"]
		payload['content'].each do |provider|

			ccsf_raw = CcsfRawFeb19.new 
			ccsf_raw.added_date = provider["addedDate"]

			ccsf_raw.physical_address_city 		= provider["addresses"][0]["city"]
			ccsf_raw.physical_address_lat 		= provider["addresses"][0]["latitude"]
			ccsf_raw.physical_address_long 		= provider["addresses"][0]["longitude"]
			ccsf_raw.physical_address_state 	= provider["addresses"][0]["state"]
			ccsf_raw.physical_address_street1 	= provider["addresses"][0]["street1"]
			ccsf_raw.physical_address_street2  	= provider["addresses"][0]["street2"]
			ccsf_raw.physical_address_zip  		= provider["addresses"][0]["zip"]

			ccsf_raw.mail_address_city 		= provider["addresses"][1]["city"]
			ccsf_raw.mail_address_lat 		= provider["addresses"][1]["latitude"]
			ccsf_raw.mail_address_long 		= provider["addresses"][1]["longitude"]
			ccsf_raw.mail_address_state 	= provider["addresses"][1]["state"]
			ccsf_raw.mail_address_street1 	= provider["addresses"][1]["street1"]
			ccsf_raw.mail_address_street2  	= provider["addresses"][1]["street2"]
			ccsf_raw.mail_address_zip  		= provider["addresses"][1]["zip"]

			ccsf_raw.age_group_from_json = provider["ageGroupFrom"]
			ccsf_raw.age_group_to_json = provider["ageGroupTo"]

			ccsf_raw.phonealt = provider["altPhone"]
			ccsf_raw.phone_ext = provider["altPhoneExt"]

 			ccsf_raw.attributes_json = provider["attributes"]

			ccsf_raw.center_name = provider["centerName"]
			ccsf_raw.email = provider["email"]

			ccsf_raw.enrollments_json  = provider["enrollments"]
			ccsf_raw.generalInfo_json  = provider["generalInfo"]

			ccsf_raw.incorporated_at = provider["incorporationDate"]

			ccsf_raw.languages_json  = provider["languages"]

			ccsf_raw.last_modified_at = provider["lastModifiedTime"]

			ccsf_raw.license_id = provider["licenseId"]
			ccsf_raw.license_capcity  = provider["licenseCapacity"]
			ccsf_raw.license_types_json = provider["licenseTypes"]

			ccsf_raw.notes = provider["notes"]
			ccsf_raw.phone = provider["phone"]

			ccsf_raw.primary_owner_json = provider["primaryOwner"]

			ccsf_raw.rates_json = provider["rates"]

			ccsf_raw.schooldistricts = provider["schoolDistricts"]
			ccsf_raw.schooltransport = provider["schoolTransport"]

			ccsf_raw.shift_days_json = provider["shiftDays"]
			ccsf_raw.shifts_json = provider["shifts"]

			ccsf_raw.start_date = provider["startDate"]
			ccsf_raw.status_changed_at = provider["statusChangeDate"]
				
			ccsf_raw.center_type = provider["typeOfCare"]
			ccsf_raw.website = provider["lastModifiedTime"]

			

			ccsf_raw.save 
			if ccsf_raw.errors.any?
				puts ccsf_raw.errors.full_messages
			end 
		end 

	end 
end 

