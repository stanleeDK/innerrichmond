class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
    	t.integer :neighborhood_id
    	t.string :neighborhood_name

      t.timestamps null: false
    end
  end
end
