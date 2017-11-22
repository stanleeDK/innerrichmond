class DssCaGovDayCareRaw < ActiveRecord::Base


	def telephone
		temp = self[:telephone]
		# return temp
		return temp.gsub(/[()]/,'')
	end 
end
