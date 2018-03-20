class RemoveAcceptedFromProposal < ActiveRecord::Migration[5.1]
  def change
    remove_column :proposals, :accepted, :boolean
  end
end
