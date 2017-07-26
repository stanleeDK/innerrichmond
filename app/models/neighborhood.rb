class Neighborhood < ActiveRecord::Base

	has_many :daycareproviders

	def day_care_count(id)
		return Daycareprovider.where(neighborhood_id: id).size
	end 

end
