class AddAccessibilityToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :accessibility, :boolean
  end
end
