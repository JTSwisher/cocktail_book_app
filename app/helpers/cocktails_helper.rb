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

end
