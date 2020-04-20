class CreateTopCocktails < ActiveRecord::Migration[6.0]
  def change
    create_table :top_cocktails do |t|
      t.integer :cocktail_id
      t.integer :average_rating
      t.integer :ratings_sum
      t.integer :ratings_count, :default => 0
    end
  end
end
