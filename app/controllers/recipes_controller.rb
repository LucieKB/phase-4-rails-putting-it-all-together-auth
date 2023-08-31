class RecipesController < ApplicationController
before_action :authorized
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
   
    def index
        recipes = Recipe.all
        render json: recipes, status: :ok
    end

    def create
        user = User.find_by(id: session[:user_id])
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: :created
    end

    private

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end


end
