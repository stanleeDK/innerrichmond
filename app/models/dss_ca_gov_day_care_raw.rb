class DssCaGovDayCareRaw < ActiveRecord::Base
	validates :facilitynumber, uniqueness: true

	CONST_INFANT_CENTER = "0-2"
	CONST_FAMILY_DAY_CARE_HOME = "0-1O"
	CONST_SCHOOL_AGE_DAY_CARE_CENTER = "5-17" 
	DAY_CARE_CENTER = "2-5"

	def telephone
		temp = self[:telephone]
		# return temp
		return temp.gsub(/[()]/,'')
	end 

	def age_range
		if self[:facilitytype] = "INFANT CENTER"
			return CONST_INFANT_CENTER
		elsif 
			self[:facilitytype] = "FAMILY DAY CARE HOME"
			return CONST_FAMILY_DAY_CARE_HOME
		elsif 
			self[:facilitytype] = "SCHOOL AGE DAY CARE CENTER"
			return CONST_SCHOOL_AGE_DAY_CARE_CENTER
		elsif
			self[:facilitytype] = "DAY CARE CENTER"
			return DAY_CARE_CENTER
		end	
	end 
end
