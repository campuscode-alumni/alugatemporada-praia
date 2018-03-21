class AddAvatarToOwner < ActiveRecord::Migration[5.1]
  def up
    add_attachment :owners, :avatar
  end

  def down
    remove_attachment :owners, :avatar
  end
end
