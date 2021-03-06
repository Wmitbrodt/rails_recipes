class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_user, only: [:edit, :update, :destroy]
  
  def index
  	@recipe = Recipe.all.order("created_at DESC")
  end

  def show 
  end

  def new 
  	@recipe = current_user.recipes.build
  end

  def create 
  	@recipe = current_user.recipes.build(recipe_params)

  	if @recipe.save
  	  redirect_to @recipe, notice: "Successfully created new recipe"
  	else
  	  render 'new'
  	end
  end 

  def edit 
  end

  def update
  	if @recipe.update(recipe_params)
  		redirect_to @recipe
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@recipe.destroy
  	redirect_to root_path, notice: "Successfully deleted recipe"
  end

  private

  
  def check_user
    unless (@recipe.user == current_user)
      redirect_to root_url, alert: "Sorry, this recipe belongs to someone else!"
    end
  end

  def recipe_params
  	params.require(:recipe).permit(:title, :description, :image, :image2, :slug, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end

  def find_recipe
  	@recipe = Recipe.friendly.find(params[:id]) # find recipe using friendly id
  end
end
