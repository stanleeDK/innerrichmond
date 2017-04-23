# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

OfficialAddress.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('official_addresses')
counter = 1 
CSV.foreach("#{Dir.home}/Dropbox/Your Code/Ruby/innerrichmond/db/Addresses_with_Units.csv",headers:true) do |row|

	property = row.to_hash
	puts "#{counter.to_i} #{property["street_name"]}"


	case property["street_name"]
	when "01ST"
		property["street_name"] = "1ST"
		property["address"].sub! "01ST", "1ST" 
	when "02ND"
		property["street_name"] = "2ND"
		property["address"].sub! "02ND", "2ND" 
	when "03RD"
		property["street_name"] = "3RD"
		property["address"].sub! "03RD", "3RD" 
	when "04TH"
		property["street_name"] = "4TH"
		property["address"].sub! "04TH", "4TH" 
	when "05TH"
		property["street_name"] = "5TH"
		property["address"].sub! "05TH", "5TH" 
	when "06TH"
		property["street_name"] = "6TH"
		property["address"].sub! "06TH", "6TH" 
	when "07TH"
		property["street_name"] = "7TH"
		property["address"].sub! "07TH", "7TH" 
	when "08TH"
		property["street_name"] = "8TH"
		property["address"].sub! "08TH", "8TH" 
	when "09TH"
		property["street_name"] = "9TH"
		property["address"].sub! "09TH", "9TH" 
	end 

	OfficialAddress.create(property)
	counter += 1

end 