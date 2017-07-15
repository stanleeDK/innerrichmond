class Daycarelicense < ActiveRecord::Base
	validates :ccsf_license_id, 
		uniqueness: {:message => "id: %{value}" }
end
