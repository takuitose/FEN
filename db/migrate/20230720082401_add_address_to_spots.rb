class AddAddressToSpots < ActiveRecord::Migration[6.1]
  def change
    add_column :spots, :address, :string
  end
end
