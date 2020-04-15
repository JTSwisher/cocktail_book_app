module ApplicationHelper

    def current_path
        current_uri = request.env['PATH_INFO']
        if current_uri.include?(current_user.id.to_s)
            return true
        else 
            return false
        end 
    end 

end
