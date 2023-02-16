class RecipesController < ApplicationController
    before_action :authorize

    def index
        user = User.find_by(id: session[:user_id])
        if user
            render json: Recipe.all, include: 'user', status: 201
        else
            render json: {errors: " " }, status: 401
        end
    end

    def create
        new_recipe = Recipe.create!(title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete], user_id: session[:user_id])
        # if new_recipe
        render json: new_recipe, include: 'user', status: 201
        # else
    rescue ActiveRecord::RecordInvalid => invalid
            render json: {errors: [invalid.record.errors] }, status: 422
        # end

    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :recipe)
    end

    def authorize
        return render json: { errors: ["Unauthorized"] }, status: :unauthorized unless session.include? :user_id
    end
end


