class Daycareschedulehour < ActiveRecord::Base
	validates :ccsf_schedulehour_id, 
				uniqueness: {:message => "id: %{value}" }

end
