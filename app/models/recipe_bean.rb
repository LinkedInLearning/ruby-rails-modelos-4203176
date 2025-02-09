class RecipeBean < ApplicationRecord
  belongs_to :recipe
  belongs_to :bean
  validates :amount, presence: true, numericality: { greater_than: 0 }
end