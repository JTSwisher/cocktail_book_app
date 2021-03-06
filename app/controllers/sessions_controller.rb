class SessionsController < ApplicationController
    before_action :require_login, only: [:destroy]

    def new
        if !current_user
            @user = User.new
        else 
            redirect_to user_path(current_user)
        end 
     end 

    def create
        if auth_hash
          if user = User.find_by(email: auth_hash["info"]["email"])
            session[:user_id] = user.id
            redirect_to user_path(user)
          else
            user = User.create(email: auth_hash["info"]["email"], name: auth_hash["info"]["name"], password: SecureRandom.hex)
            session[:user_id] = user.id
            redirect_to user_path(user)
          end 
        else
            if user = User.find_by(email: params[:user][:email])
               if  user.authenticate(params[:user][:password])
                    session[:user_id] = user.id 
                    redirect_to user_path(user)
                else 
                    flash[:alert] = "Your login credentials were incorrect. Please try again."
                    redirect_to login_path
                end
            else
                flash[:alert] = "Your login credentials were incorrect. Please try again." 
                redirect_to login_path
            end
            
        end 
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end

private

    def auth_hash
        request.env["omniauth.auth"]
    end 
    

end
