class Cocktail < ActiveRecord::Base
    belongs_to :user
    has_many :cocktail_ingredients
    has_many :ingredients, through: :cocktail_ingredients

    validates :name, presence: true
    validates :instructions, presence: true 

    accepts_nested_attributes_for :cocktail_ingredients, limit: 5,  :reject_if => proc { |attrs| attrs[:quantity].blank? && attrs[:ingredient_attributes][:name].blank?}
    
    #def cocktail_ingredients_attributes=(cocktail_ingredient_attributes)
     #   cocktail_ingredient_attributes.values.each do |ci|
      #      if ci[:quantity] != ""
       #         cocktail_ingredient = CocktailIngredient.find_or_create_by(quantity: ci[:quantity])
        #        binding.pry
         #       self.cocktail_ingredients[:quantity] = cocktail_ingredient.quantity
                
          #  end 
        #end 
    #end 

    def self.find_cocktails_by_ingredient(query)
        ingredients = query.split(/\W+/)
        cocktail_ids = []
        ingredient_ids = []

        ingredients.each do |i|
            ingredient = Ingredient.where("name like ?", "%#{i.downcase}%")
            ingredient.each do |i|
                ids = CocktailIngredient.all.where(ingredient_id: i.id)
                ids.each do |i|
                    ingredient_ids << i.cocktail_id
                end 
            end 
        end 

        ingredient_ids.each do |ci|
            cocktail_ids << ci
        end 

        @cocktails = Cocktail.all.where(id: cocktail_ids)

        if !@cocktails.empty?
            @cocktails
        else 
            @cocktails = Cocktail.all
        end 
    end 


end 