class Favorite < ActiveRecord::Base
    include FavoritesHelper
    belongs_to :cocktail
    belongs_to :user
    validates :rating, presence: true

    scope :highest_rated, -> {where ("rating >= 7.0")}

end