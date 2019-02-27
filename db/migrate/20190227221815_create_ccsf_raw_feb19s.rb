class CreateCcsfRawFeb19s < ActiveRecord::Migration
  def change
    create_table :ccsf_raw_feb19s do |t|

    	t.datetime 	:added_date
    	t.string :physical_address_city
    	t.decimal :physical_address_lat
    	t.decimal :physical_address_long
    	t.string :physical_address_state
    	t.string :physical_address_street1
    	t.string :physical_address_street2 
    	t.string :physical_address_zip 

    	t.string :mail_address_city
    	t.decimal :mail_address_lat
    	t.decimal :mail_address_long
    	t.string :mail_address_state
    	t.string :mail_address_street1
    	t.string :mail_address_street2 
    	t.string :mail_address_zip 

		t.string :age_group_from_json
		t.string :age_group_to_json

		t.string :phonealt 
		t.string :phone_ext

		t.string :attributes_json

		t.string :center_name
		t.string :email

		t.string :enrollments_json 
		t.string :generalInfo_json 

		t.datetime 	:incorporated_at

		t.string :languages_json 

		t.datetime 	:last_modified_at

		t.string :license_id
		t.integer :license_capcity 
		t.string :license_types_json

		t.string :notes
		t.string :phone

		t.string :primary_owner_json

		t.string :rates_json

		t.string :schooldistricts
		t.string :schooltransport

		t.string :shift_days_json
		t.string :shifts_json

		t.datetime 	:start_date
		t.datetime 	:status_changed_at
		
		t.string :center_type
		t.string :website

     	t.timestamps null: false
    end
  end
end
