class Daycarelicense < ActiveRecord::Base
	validates :ccsf_license_id, 
		uniqueness: {:message => "id: %{value}" }

	belongs_to :daycareprovider, foreign_key: "day_care_provider_id"



end
