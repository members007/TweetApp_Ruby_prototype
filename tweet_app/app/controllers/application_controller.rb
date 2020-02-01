class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(id: session[:user_id]) 
    end

    def authenticate_user
        if @current_user == nil
            flash[:notice] = "login が必要です"
            redirect_to("/")
        end
    end

    def forbid_login_user
        if @current_user != nil
            flash[:notice] = "すでにloginしています"
            redirect_to("/posts/index")
        end
    end

    def ensure_correct_user
        if @current_user.id != params[:id].to_i
            flash[:notice] = "権限がありません"
            redirect_to("/")
        end
    end

end
