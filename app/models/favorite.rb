class Favorite < ActiveRecord::Base
    belongs_to :cocktail
    belongs_to :user
    validates :rating, presence: true

    

    def self.destroy_favorites(cocktail_id)
        # Find all favorites with cocktail_id of associated coktail that was deleted and delete those favorite objects upon
        #cocktail deletion
        @cf = Favorite.all.where(cocktail_id: cocktail_id)
        
        @cf.each do |f|
            f.destroy
        end 
    end

end