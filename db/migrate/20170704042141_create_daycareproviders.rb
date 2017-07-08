class CreateDaycareproviders < ActiveRecord::Migration
  def change
    create_table :daycareproviders do |t|

    	t.integer :day_care_provider_id
		t.string :name
		t.string :alternate_name
		t.string :contact_name
		t.string :phone
		t.string :phone_ext
		t.string :phone_other
		t.string :phone_other_ext
		t.string :fax
		t.string :email
		t.string :url
		t.string :address_1
		t.string :address_2
		t.integer :city_id
		t.integer :state_id
		t.string :cross_street_1
		t.string :cross_street_2
		t.string :mail_address_1
		t.string :mail_address_2
		t.string :mail_city_id
		t.string :mail_state_id
		t.string :ssn
		t.string :tax_id
		t.datetime :ccsf_created_at 
		t.datetime :ccsf_updated_at
		t.decimal :latitude, precision: 15, scale: 7
		t.decimal :longitude, precision: 15, scale: 7
		t.integer :schedule_year_id
		t.integer :zip_code_id
		t.integer :care_type_id
		t.string :description
		t.string :licensed_ages
  		t.integer :neighborhood_id
  		t.integer :mail_zip_code
  		t.boolean :accepting_referrals
		t.boolean :meals_optional
		t.integer :meal_sponsor_id
		t.string :english_capability
		t.integer :preferred_language_id
		t.boolean :potty_training
		t.string :co_op
		t.boolean :nutrition_program
		t.string :cached_geocodable_address_string
		t.integer :license_id_1
		t.integer :license_id_2
		t.integer :license_id_3

		t.timestamps null: false
    end
  end
end
