class CreateIngestedTruliaProperties < ActiveRecord::Migration
  def change
    create_table :ingested_trulia_properties do |t|

		t.string 	:address
		t.integer 	:address_number
		t.string  	:address_number_suffix
		t.string  	:street_name
		t.string  	:street_type
		t.string  	:unit_number
		t.integer 	:zipcode

		t.string 	:size_description
		t.integer 	:bedrooms
		t.integer 	:bathrooms
		t.integer 	:square_feet

		t.string 	:property_page

		t.decimal 	:value 
		t.date 		:sold_at 

      t.timestamps null: false
    end
  end
end
