class AddEmailToProposal < ActiveRecord::Migration[5.1]
  def change
    add_column :proposals, :email, :string
  end
end
