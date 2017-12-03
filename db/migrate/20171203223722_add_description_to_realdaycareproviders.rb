class AddDescriptionToRealdaycareproviders < ActiveRecord::Migration
  def change
    add_column :realdaycareproviders, :description, :string
  end
end
