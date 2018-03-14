class AddPropertyRefToUnavailableRanges < ActiveRecord::Migration[5.1]
  def change
    add_reference :unavailable_ranges, :property, foreign_key: true
  end
end
