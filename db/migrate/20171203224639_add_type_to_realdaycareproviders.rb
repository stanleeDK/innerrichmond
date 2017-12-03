class AddTypeToRealdaycareproviders < ActiveRecord::Migration
  def change
    add_column :realdaycareproviders, :type, :string
  end
end
