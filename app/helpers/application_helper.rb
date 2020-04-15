module ApplicationHelper

    def current_path
        #use current path and check to see if it includes user params[:user_id] to render view descriptions accordingly. 
        current_uri = request.env['PATH_INFO']
        if current_uri.include?(current_user.id.to_s)
            return true
        else 
            return false
        end 
    end 

end
