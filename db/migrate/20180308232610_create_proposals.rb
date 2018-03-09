class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :rent_purpose
      t.integer :maximum_guests
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :petfriendly
      t.boolean :smoking_allowed
      t.text :proposal_details

      t.timestamps
    end
  end
end
