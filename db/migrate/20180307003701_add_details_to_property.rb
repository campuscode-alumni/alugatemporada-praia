class AddDetailsToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :property_type, :string
    add_column :properties, :location, :string
    add_column :properties, :description, :text
    add_column :properties, :total_rooms, :integer
    add_column :properties, :acessibility, :boolean
    add_column :properties, :petfriendly, :boolean
    add_column :properties, :smoking_allowed, :boolean
  end
end
