class Recipe < ApplicationRecord
  attribute :difficulty, :integer, default: 0

  belongs_to :user

  #relacion con la tabla intermedia
  has_many :recipe_beans
  has_many :beans, through: :recipe_beans

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

  def with_roaster_and_bean
    recipes = Recipe.joins(:user)
                    .joins(:beans)
                    .joins("INNER JOIN roasters ON beans.roaster_id = roasters.id")
                    .select("recipes.*, users.email AS user_email, roasters.name AS roaster_name, beans.name AS bean_name")

    recipes.each do |recipe|
      puts "#{recipe.title} by #{recipe.user_email}, using beans #{recipe.bean_name} from #{recipe.roaster_name}"
    end
  end

  def can_destroy?
    throw :abort if created_at.today?
  end

  # Get all recipes with a specific bean name
  def self.with_specific_bean(bean_name)
    find_by_sql("
      SELECT recipes.*
      FROM recipes
      JOIN recipe_beans ON recipes.id = recipe_beans.recipe_id
      JOIN beans ON recipe_beans.bean_id = beans.id
      WHERE beans.name LIKE \'%#{bean_name}%\'
    ")
  end
end
