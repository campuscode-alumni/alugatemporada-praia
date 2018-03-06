class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :title
      t.integer :maximum_guests
      t.integer :minimum_rent
      t.integer :maximum_rent
      t.decimal :daily_rate
      t.string :rent_purpose
      t.string :property_location

      t.timestamps
    end
  end
end
