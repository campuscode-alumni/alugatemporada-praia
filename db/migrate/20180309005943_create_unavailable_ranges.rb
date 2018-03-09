class CreateUnavailableRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :unavailable_ranges do |t|
      t.string :description
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
