class AddPropertyRefToPriceRange < ActiveRecord::Migration[5.1]
  def change
    add_reference :price_ranges, :property, foreign_key: true
  end
end
