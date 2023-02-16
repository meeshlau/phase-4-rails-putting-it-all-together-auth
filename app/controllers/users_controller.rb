class UsersController < ApplicationController

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: 201
        else
            render json: { errors: "user.errors.full_messages" }, status: 401
        end
    end

    def create
        user = User.create(user_params)
        if user.save
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: 422
        end
    end

    private

    def user_params
        params.permit(:username, :password_confirmation, :password, :image_url, :bio)
    end
end
