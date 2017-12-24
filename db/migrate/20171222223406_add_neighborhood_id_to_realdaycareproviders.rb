class AddNeighborhoodIdToRealdaycareproviders < ActiveRecord::Migration
  def change
    add_column :realdaycareproviders, :neighborhood_id, :integer
  end
end
