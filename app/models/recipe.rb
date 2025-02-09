class Recipe < ApplicationRecord
  attribute :difficulty, :integer, default: 0

  belongs_to :user
  
  scope :easy, -> { where(difficulty: 1).or(Recipe.where(difficulty: 2)) }
end
