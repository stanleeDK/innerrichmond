class CreateDssCaGovDayCareRaws < ActiveRecord::Migration
  def change
    create_table :dss_ca_gov_day_care_raws do |t|

      t.string :capacity
      t.string :city
      t.string :contact
      t.string :county
      t.string :districtoffice
      t.string :doaddress
      t.string :docity
      t.string :dostate
      t.string :dotelephone
      t.string :dozipcode
      t.string :facilityname
      t.string :facilitynumber
      t.string :facilitytype
      t.string :lastvisitdate
      t.string :licenseeffectivedate
      t.string :licensefirstdate
      t.string :licenseename
      t.string :nbrallvisits
      t.string :nbrcmpltvisits
      t.string :nbrcmplttypa
      t.string :nbrcmplttypb
      t.string :nbrcmpltinc
      t.string :nbrcmpltuns
      t.string :nbrcmpltsub
      t.string :nbrcmpltunf
      t.string :nbrinspvisits
      t.string :nbrinsptypa
      t.string :nbrinsptypb
      t.string :nbrothervisits
      t.string :nbrothertypa
      t.string :nbrothertypb
      t.string :state
      t.string :status
      t.string :streetaddress
      t.string :telephone
      t.string :vstdateall
      t.string :vstdatecmplt
      t.string :vstdateinsp
      t.string :vstdateother
      t.string :zipcode
      t.string :totcmpvisits
      t.string :totsubalg
      t.string :totincalg
      t.string :totunsalg
      t.string :totunfalg
      t.string :tottypea
      t.string :tottypeb
      t.string :cmpcount
      t.string :complaintarray
      t.string :tsocase 

      t.timestamps null: false
    end
  end
end
