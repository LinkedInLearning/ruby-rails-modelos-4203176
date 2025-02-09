class Recipe < ApplicationRecord
  attribute :difficulty, :integer, default: 0
  
  belongs_to :user
end
