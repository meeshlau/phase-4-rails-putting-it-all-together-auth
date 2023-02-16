class SessionsController < ApplicationController

    def create
        u = User.find_by_username(params[:username])
        if u&.authenticate(params[:password])
            session[:user_id] = u.id
            render json: u, status: 201
        else
            render json: { errors: ["error"] }, status: 401
        end
    end

    def destroy
       user = User.find_by(id: session[:user_id])
       if user
            session.destroy
            head :no_content, status: 204
       else
            render json: {errors: [" "] }, status: 401
       end
    end
end
