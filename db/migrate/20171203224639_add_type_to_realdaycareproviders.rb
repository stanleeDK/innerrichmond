class AddTypeToRealdaycareproviders < ActiveRecord::Migration
  def change
    add_column :realdaycareproviders, :daycare_type, :string
  end
end
