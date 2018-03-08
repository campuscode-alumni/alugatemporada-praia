class RemoveLocationFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :location, :string
  end
end
