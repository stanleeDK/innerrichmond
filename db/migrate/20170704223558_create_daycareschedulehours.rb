class CreateDaycareschedulehours < ActiveRecord::Migration
  def change
    create_table :daycareschedulehours do |t|

      t.integer :ccsf_schedulehour_id #: 12657,
      t.integer :ccsf_schedule_day_id#: 1,
      t.integer :day_care_provider_id#: 14,
      t.datetime :start_time #2000-01-01T07:00:00.000Z
      t.datetime :end_time #2000-01-01T18:00:00.000Z
      t.boolean :closed #: false
      t.datetime :ccsf_created_at #2000-07-18T00:00:00.000Z
      t.datetime :ccsf_updated_at #: "2016-12-09T00:00:00.000Z
      t.boolean :open_24 #: true

      t.timestamps null: false
    end
  end
end
