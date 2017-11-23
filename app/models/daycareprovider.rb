class Daycareprovider < ActiveRecord::Base
	validates :day_care_provider_id, 
				uniqueness: {:scope => :contact_name, :message => "id: %{value}" }

	belongs_to :neighborhood
	has_many :daycarelicenses, foreign_key: "day_care_provider_id", primary_key: "day_care_provider_id"

	def number_of_licenses(id)
		return Daycarelicense.where(day_care_provider_id: id).size
	end

	def capacity(dcp_id)
		licenses = Daycarelicense.where(day_care_provider_id: id)
		capacity = 0
		license.each do |l|
			capacity =+ l.capacity 
		end 
	end 

	def age_range
		temp_range = self[:licensed_ages].split(",")
		range = "#{temp_range[0].to_i/12}-#{temp_range.last.to_i/12}"
		return range
	end

	# before_save :return_dupe_message

	# def return_dupe_message 
	# 	puts "hello"
	# 	if self.invalid?
	# 		puts self.errors[:uniqueness]
	# 	end 
	# end

end
