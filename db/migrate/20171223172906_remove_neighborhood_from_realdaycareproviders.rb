class RemoveNeighborhoodFromRealdaycareproviders < ActiveRecord::Migration
  def change
  	remove_column :realdaycareproviders, :neighborhood
  end
end
