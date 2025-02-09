class RecipeBean < ApplicationRecord
  # relacion con las tablas padre
  belongs_to :recipe
  belongs_to :bean
  validates :amount, presence: true, numericality: { greater_than: 0 }
end