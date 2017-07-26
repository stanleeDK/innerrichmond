class Daycareprovider < ActiveRecord::Base
	validates :day_care_provider_id, 
				uniqueness: {:scope => :contact_name, :message => "id: %{value}" }

	belongs_to :neighborhood
	has_many :daycarelicenses, foreign_key: "day_care_provider_id" 

	def number_of_licenses(id)
		return Daycarelicense.where(day_care_provider_id: id).size
	end

	# before_save :return_dupe_message

	# def return_dupe_message 
	# 	puts "hello"
	# 	if self.invalid?
	# 		puts self.errors[:uniqueness]
	# 	end 
	# end

end
