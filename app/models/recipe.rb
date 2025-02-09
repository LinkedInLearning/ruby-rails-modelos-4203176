class Recipe < ApplicationRecord
  attribute :difficulty, :integer, default: 0

  belongs_to :user
  before_destroy :can_destroy?

  scope :easy, -> { where(difficulty: 1).or(Recipe.where(difficulty: 2)) }

  def can_destroy?
    throw :abort if created_at.today?
  end
end
