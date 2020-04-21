class AddRatingToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :average_rating, :float, default: 0.0
    add_column :cocktails, :ratings_sum, :integer, default: 0
    add_column :cocktails, :ratings_count, :integer, default: 0
  end
end
