class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_recipe, if: :recipe_controller?

  protected

  def recipe_controller?
    controller_name == 'recipes' 
  end

  def set_recipe
    @recipe = Recipe.last || create_default_recipe
  end
  
  private
  
  def create_default_recipe
    Recipe.create(default_recipe_attributes)
  end
  
  def default_recipe_attributes
    { name: 'Default Recipe', description: 'This is the default recipe.' }
  end

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password)
    end
  end
end
