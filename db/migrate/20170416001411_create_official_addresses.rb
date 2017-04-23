class CreateOfficialAddresses < ActiveRecord::Migration
  def change
    create_table :official_addresses do |t|
      t.integer :eas_base_id
      t.integer :eas_sub_id
      t.integer :CNN
      t.string 	:address
      t.integer :address_number
      t.string  :address_number_suffix
      t.string  :street_name
      t.string  :street_type
      t.string  :unit_number
      t.integer :zipcode
      t.integer :blocklot
      t.decimal :long, precision: 15, scale: 7
      t.decimal :lat, precision: 15, scale: 7

      t.timestamps null: false
    end
  end
end
