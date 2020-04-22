module CocktailsHelper

    def cocktail_owner(c)
        #use cocktail obect to compare owner user_id with current_user.id to render created by name accordingly
        #created by current_user(me) or different user name 
        if c.user_id == current_user.id
            content_tag :td, "Me"
        else
            content_tag :td, "#{c.user.name}"
        end
    end

    def cocktail_rating(c)
        if c.ratings_count > 0
            content_tag :td, "#{c.average_rating} / 10"
        else 
            tag.td 'Not Rated'
        end 
    end

end
