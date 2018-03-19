class AddNameToOwner < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :owner_name, :string
  end
end
