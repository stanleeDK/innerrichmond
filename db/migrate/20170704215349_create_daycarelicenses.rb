class CreateDaycarelicenses < ActiveRecord::Migration
  def change
    create_table :daycarelicenses do |t|


      t.integer :ccsf_license_id
      t.integer :day_care_provider_id
      t.datetime :issue_date
      t.boolean :exempt
      t.string :license_type
      t.integer :state_license_number # "384000511",
      t.integer :capacity #8,
      t.integer :capacity_desired #8,
      t.integer :capacity_subsidy #8,
      t.integer :age_from_year #0,
      t.integer :age_from_month #1,
      t.integer :age_to_year#12,
      t.integer :age_to_month #11,
      t.integer :vacancies #4,
      t.datetime :ccsf_created_at #2000-07-18T00:00:00.000Z,
      t.datetime :ccsf_updated_at #2016-12-09T00:00:00.000Z


      t.timestamps null: false
    end
  end
end
