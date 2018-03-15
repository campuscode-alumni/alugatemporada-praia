class AddValueToProposal < ActiveRecord::Migration[5.1]
  def change
    add_column :proposals, :value, :decimal
  end
end
