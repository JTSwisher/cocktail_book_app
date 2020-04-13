class AddCommentsToFavorites < ActiveRecord::Migration[6.0]
  def change
    add_column :favorites, :comments, :string
  end
end
