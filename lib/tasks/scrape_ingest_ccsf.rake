require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'json'


namespace :ingest do 
	desc "scrape_cc_sf"
	task :scrape_ccsf => :environment do

		uri  = URI.parse('http://childrens-council.dapper.childrenscouncil.org/api/providers')
		http = Net::HTTP.new(uri.host, uri.port)

		params = 
		{
		  "page": 1,
		  "per_page": 10000,
		  "providers": {
		    "care_type_ids": [1,2],
		    "ages": [1],
		    "schedule_year_ids": [1,2],
		    "schedule_week_ids": [1,2],
		    "schedule_day_ids": [2,3,4,5,6],
		    "zip_code_ids": [1]
		  },
		  "parent": {
		    "full_name": "Stan Lee",
		    "email": "hbtrial123@gmail.com",
		    "phone": "",
		    "home_zip_code": "10036",
		    "near_address": "",
		    "subscribe": false,
		  }#,
		  # "api_key": "77p9a5mo1nwETty6ycJa"
		}

		json_headers = {
			"Content-Type" 	=> "application/json",
		    "Accept" 		=> "application/json"
		}


		response = http.post(uri.path, params.to_json, json_headers)
		payload = JSON.parse(response.body)
		# puts JSON.pretty_generate(payload)
		# puts payload["total"]
		# puts payload["providers"].length

		payload['providers'].each do |provider|
			puts provider['name']

			dcprovider 					= Daycareprovider.new
			dcprovider.day_care_provider_id = provider['id']
			dcprovider.name 			= provider['name']
			dcprovider.alternate_name 	= provider['alternate_name']
			dcprovider.contact_name 	= provider['contact_name']
			dcprovider.phone 			= provider['phone']
			dcprovider.phone_ext 		= provider['phone_ext']
			dcprovider.phone_other 		= provider['phone_other']
			dcprovider.phone_other_ext 	= provider['phone_other_ext']
			dcprovider.fax 				= provider['fax']
			dcprovider.email 			= provider['email']
			dcprovider.url 				= provider['url']
			dcprovider.address_1 		= provider['address_1']
			dcprovider.address_2 		= provider['address_2']
			dcprovider.city_id 			= provider['city_id']
			dcprovider.state_id 		= provider['state_id']
			dcprovider.cross_street_1 	= provider['cross_street_1']
			dcprovider.cross_street_2 	= provider['cross_street_2']
			dcprovider.mail_address_1 	= provider['mail_address_1']
			dcprovider.mail_address_2 	= provider['mail_address_2']
			dcprovider.mail_city_id 	= provider['mail_city_id']
			dcprovider.mail_state_id 	= provider['mail_state_id']
			dcprovider.ssn 				= provider['ssn']
			dcprovider.ccsf_created_at 	= provider['created_at']
			dcprovider.ccsf_updated_at 	= provider['updated_at']
			dcprovider.latitude 		= provider['latitude']
			dcprovider.longitude 		= provider['longitude']
			dcprovider.schedule_year_id = provider['schedule_year_id']
			dcprovider.zip_code_id 		= provider['zip_code_id']
			dcprovider.care_type_id 	= provider['care_type_id']
			dcprovider.description 		= provider['description']

			provider['licensed_ages'].each_with_index do |l_ages,index|
				if index != 0 
					dcprovider.licensed_ages = dcprovider.licensed_ages.to_s + "," + l_ages.to_s
				else
					dcprovider.licensed_ages = l_ages.to_s
				end
			end

			dcprovider.neighborhood_id 			= provider['neighborhood_id']
			dcprovider.mail_zip_code 			= provider['mail_zip_code']
			dcprovider.accepting_referrals 		= provider['accepting_referrals']
			dcprovider.meals_optional 			= provider['meals_optional']
			dcprovider.meal_sponsor_id 			= provider['meal_sponsor_id']
			dcprovider.english_capability 		= provider['english_capability']
			dcprovider.preferred_language_id 	= provider['preferred_language_id']
			dcprovider.potty_training 			= provider['potty_training']
			dcprovider.co_op 					= provider['co_op']
			dcprovider.nutrition_program 		= provider['nutrition_program']
			dcprovider.cached_geocodable_address_string = provider['cached_geocodable_address_string']		

			provider['licenses'].each_with_index do |license,index|
				ltemp 					= Daycarelicense.new
				
				ltemp.ccsf_license_id 	= license['created_at']
				ltemp.day_care_provider_id 	= license['created_at']
				ltemp.issue_date 	= license['created_at']
				ltemp.exempt 	= license['created_at']
				ltemp.license_type 	= license['created_at']
				ltemp.state_license_number 	= license['created_at']
				ltemp.capacity 	= license['created_at']
				ltemp.exempt 	= license['created_at']
				ltemp.ccsf_license_id 	= license['created_at']
				ltemp.day_care_provider_id 	= license['created_at']
				ltemp.issue_date 	= license['created_at']
				ltemp.exempt 	= license['created_at']

				ltemp.save

				#save the licenses in a flattened state as well, so you don't need to go into the other table all the time
				if index == 1 
					dcprovider.license_id_1 = license['number']
				elsif index == 2
					dcprovider.license_id_2 = license['number']
				elsif index == 3
					dcprovider.license_id_3 = license['number']
				end 
					
				
			end

			provider['schedule_hours'].each_with_index do |schedulehours,index|
				
				scheduletemp = Daycareschedulehour.new 
				scheduletemp.ccsf_schedulehour_id 	= schedulehours['id']
				scheduletemp.ccsf_schedule_day_id 	= schedulehours['schedule_day_id']
				scheduletemp.day_care_provider_id 	= schedulehours['provider_id']
				scheduletemp.start_time 			= schedulehours['start_time']
				scheduletemp.end_time 				= schedulehours['end_time']
				scheduletemp.closed 				= schedulehours['closed']
				scheduletemp.ccsf_created_at 		= schedulehours['created_at']
				scheduletemp.ccsf_updated_at 		= schedulehours['updated_at']
				scheduletemp.open_24 				= schedulehours['open_24']

				scheduletemp.save 
			end	

			dcprovider.save 
		end

	end 
end 

# {
#   "total": 15,
#   "providers": [
	# {
	#   "id": 14,
	#   "name": "Moorer, Mary L.",
	#   "alternate_name": "M&M Childcare",
	#   "contact_name": "Moorer, Mary L.",
	#   "phone": "4155850241",
	#   "phone_ext": null,
	#   "phone_other": null,
	#   "phone_other_ext": null,
	#   "fax": "4152391436",
	#   "email": "jem346@aol.com",
	#   "url": null,
	#   "address_1": "210 Thrift St",
	#   "address_2": null,
	#   "city_id": 5,
	#   "state_id": 5,
	#   "cross_street_1": "Thrift St",
	#   "cross_street_2": "Ocean Ave",
	#   "mail_address_1": "210 Thrift St",
	#   "mail_address_2": null,
	#   "mail_city_id": 5,
	#   "mail_state_id": 5,
	#   "ssn": null,
	#   "tax_id": null,
	#   "created_at": "2000-07-18T00:00:00.000Z",
	#   "updated_at": "2016-12-09T00:00:00.000Z",
	#   "latitude": 37.7228693,
	#   "longitude": -122.45219,
	#   "schedule_year_id": 1,
	#   "zip_code_id": 12,
	#   "care_type_id": 1,
	#   "description": "A loving home setting with a preschool environment. We offer \"The Early Beginnings Preschool Program\". Kids enjoy daily activities such as: circle time, arts and crafts, show and tell. We provide nutritious, hot meals daily.\r\n\r\n-Adult: Child ratio - 1:3\r\n-Bus Routes: 54, 29, M & K.",
	#   "licensed_ages": [
	#     1,
	#     2,
	#     3,
	#     4,
	#     5,
	#     6,
	#     7,
	#     8,
	#     9,
	#     10,
	#     11,
	#     12,
	#     13,
	#     14,
	#     15,
	#     16,
	#     17,
	#     18,
	#     19,
	#     20,
	#     21,
	#     22,
	#     23,
	#     24,
	#     25,
	#     26,
	#     27,
	#     28,
	#     29,
	#     30,
	#     31,
	#     32,
	#     33,
	#     34,
	#     35,
	#     36,
	#     37,
	#     38,
	#     39,
	#     40,
	#     41,
	#     42,
	#     43,
	#     44,
	#     45,
	#     46,
	#     47,
	#     48,
	#     49,
	#     50,
	#     51,
	#     52,
	#     53,
	#     54,
	#     55,
	#     56,
	#     57,
	#     58,
	#     59,
	#     60,
	#     61,
	#     62,
	#     63,
	#     64,
	#     65,
	#     66,
	#     67,
	#     68,
	#     69,
	#     70,
	#     71,
	#     72,
	#     73,
	#     74,
	#     75,
	#     76,
	#     77,
	#     78,
	#     79,
	#     80,
	#     81,
	#     82,
	#     83,
	#     84,
	#     85,
	#     86,
	#     87,
	#     88,
	#     89,
	#     90,
	#     91,
	#     92,
	#     93,
	#     94,
	#     95,
	#     96,
	#     97,
	#     98,
	#     99,
	#     100,
	#     101,
	#     102,
	#     103,
	#     104,
	#     105,
	#     106,
	#     107,
	#     108,
	#     109,
	#     110,
	#     111,
	#     112,
	#     113,
	#     114,
	#     115,
	#     116,
	#     117,
	#     118,
	#     119,
	#     120,
	#     121,
	#     122,
	#     123,
	#     124,
	#     125,
	#     126,
	#     127,
	#     128,
	#     129,
	#     130,
	#     131,
	#     132,
	#     133,
	#     134,
	#     135,
	#     136,
	#     137,
	#     138,
	#     139,
	#     140,
	#     141,
	#     142,
	#     143,
	#     144,
	#     145,
	#     146,
	#     147,
	#     148,
	#     149,
	#     150,
	#     151,
	#     152,
	#     153,
	#     154,
	#     155
	#   ],
	#   "neighborhood_id": 15,
	#   "mail_zip_code": "94112",
	#   "accepting_referrals": true,
	#   "meals_optional": false,
	#   "meal_sponsor_id": 7,
	#   "english_capability": null,
	#   "preferred_language_id": 1,
	#   "potty_training": true,
	#   "co_op": null,
	#   "nutrition_program": true,
	#   "cached_geocodable_address_string": "Thrift St, @, Ocean Ave,  San Francisco, California, 94112",
	#   "random": 0.00704502640292048,
	#   "licenses": [
	#     {
	#       "id": 3848,
	#       "provider_id": 14,
	#       "date": "1998-12-22",
	#       "exempt": false,
	#       "license_type": "fcc",
	#       "number": "384000511",
	#       "capacity": 8,
	#       "capacity_desired": 8,
	#       "capacity_subsidy": 8,
	#       "age_from_year": 0,
	#       "age_from_month": 1,
	#       "age_to_year": 12,
	#       "age_to_month": 11,
	#       "vacancies": 4,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z"
	#     }
	#   ],
	#   "schedule_hours": [
	#     {
	#       "id": 12657,
	#       "schedule_day_id": 1,
	#       "provider_id": 14,
	#       "start_time": "2000-01-01T07:00:00.000Z",
	#       "end_time": "2000-01-01T18:00:00.000Z",
	#       "closed": false,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z",
	#       "open_24": true
	#     },
	#     {
	#       "id": 12658,
	#       "schedule_day_id": 2,
	#       "provider_id": 14,
	#       "start_time": "2000-01-01T07:00:00.000Z",
	#       "end_time": "2000-01-01T18:00:00.000Z",
	#       "closed": false,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z",
	#       "open_24": true
	#     },
	#     {
	#       "id": 12659,
	#       "schedule_day_id": 3,
	#       "provider_id": 14,
	#       "start_time": "2000-01-01T07:00:00.000Z",
	#       "end_time": "2000-01-01T18:00:00.000Z",
	#       "closed": false,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z",
	#       "open_24": true
	#     },
	#     {
	#       "id": 12660,
	#       "schedule_day_id": 4,
	#       "provider_id": 14,
	#       "start_time": "2000-01-01T07:00:00.000Z",
	#       "end_time": "2000-01-01T18:00:00.000Z",
	#       "closed": false,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z",
	#       "open_24": true
	#     },
	#     {
	#       "id": 12661,
	#       "schedule_day_id": 5,
	#       "provider_id": 14,
	#       "start_time": "2000-01-01T07:00:00.000Z",
	#       "end_time": "2000-01-01T18:00:00.000Z",
	#       "closed": false,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z",
	#       "open_24": true
	#     },
	#     {
	#       "id": 12662,
	#       "schedule_day_id": 6,
	#       "provider_id": 14,
	#       "start_time": "2000-01-01T07:00:00.000Z",
	#       "end_time": "2000-01-01T18:00:00.000Z",
	#       "closed": false,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z",
	#       "open_24": true
	#     },
	#     {
	#       "id": 12663,
	#       "schedule_day_id": 7,
	#       "provider_id": 14,
	#       "start_time": "2000-01-01T07:00:00.000Z",
	#       "end_time": "2000-01-01T18:00:00.000Z",
	#       "closed": false,
	#       "created_at": "2000-07-18T00:00:00.000Z",
	#       "updated_at": "2016-12-09T00:00:00.000Z",
	#       "open_24": true
	#     }
	#   ],
	#   "subsidies": [
	#     {
	#       "id": 3,
	#       "name": "CalWORKs/AP Vouchers",
	#       "created_at": "2017-07-02T21:30:05.197Z",
	#       "updated_at": "2017-07-02T21:30:05.197Z",
	#       "description": "This option only applies for families currently receiving CalWORKs benefits. You may select this option to view child care providers that accept vouchers (child care payments from CalWORKs). Keep in mind that some providers may have not notified us that they accept vouchers.",
	#       "display": true
	#     },
	#     {
	#       "id": 6,
	#       "name": "Sibling Discount",
	#       "created_at": "2017-07-02T21:30:05.197Z",
	#       "updated_at": "2017-07-02T21:30:05.197Z",
	#       "description": null,
	#       "display": null
	#     }
	#   ]
	# }
# ]
