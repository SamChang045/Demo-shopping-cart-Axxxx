class AddFavoritesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :favorites_count, :integer, default: 0
  end
end
