class Neighborhood < ActiveRecord::Base
	validates :neighborhood_name, uniqueness: true

	has_many :daycareproviders
	has_many :realdaycareproviders

	def day_care_count(id)
		return Daycareprovider.where(neighborhood_id: id).size
	end 

end
