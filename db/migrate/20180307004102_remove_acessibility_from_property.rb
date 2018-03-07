class RemoveAcessibilityFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :acessibility, :boolean
  end
end
