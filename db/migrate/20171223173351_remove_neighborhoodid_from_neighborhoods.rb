class RemoveNeighborhoodidFromNeighborhoods < ActiveRecord::Migration
  def change
  	remove_column :neighborhoods, :neighborhood_id
  end
end
