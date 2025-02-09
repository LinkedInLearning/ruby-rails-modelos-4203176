class Recipe < ApplicationRecord
  attribute :difficulty, :integer, default: 0

  belongs_to :user
  before_destroy :can_destroy?

  scope :easy, -> { where(difficulty: 1).or(Recipe.where(difficulty: 2)) }

  def pretty_print_recipes_by_user
    # includes
    recipes = Recipe.includes(:user)
    recipes.each do |recipe|
      puts "#{recipe.title} by #{recipe.user.first_name}"
    end
    
    # joins
    recipes = Recipe.joins(:user).select("recipes.*, users.first_name as author")
    recipes.each do |recipe|
      puts "#{recipe.title} by #{recipe.author}"
    end
  end

  def can_destroy?
    throw :abort if created_at.today?
  end
end
