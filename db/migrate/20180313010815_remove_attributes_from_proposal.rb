class RemoveAttributesFromProposal < ActiveRecord::Migration[5.1]
  def change
    remove_column :proposals, :name, :string
    remove_column :proposals, :email, :string
  end
end
