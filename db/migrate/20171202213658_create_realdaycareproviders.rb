class CreateRealdaycareproviders < ActiveRecord::Migration
  def change
    create_table :realdaycareproviders do |t|

		t.string :name
		t.string :business_name
		t.string :phone
		t.string :email
		t.string :url
		t.string :address
		t.string :neighborhood
		t.string :age_range
		t.string :schedule
		t.integer :zip_code
		t.integer :license_id_1
		t.integer :license_id_2
		t.integer :license_id_3
		t.decimal :latitude, precision: 15, scale: 7
		t.decimal :longitude, precision: 15, scale: 7
		t.timestamps null: false
    end
  end
end
