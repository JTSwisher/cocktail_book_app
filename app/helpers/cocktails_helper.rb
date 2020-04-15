module CocktailsHelper

    def cocktail_owner(c)
        if c.user_id == current_user.id
            content_tag :td, "Me"
        else
            content_tag :td, "#{c.user.name}"
        end
    end

end
