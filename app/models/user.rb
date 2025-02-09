class User < ApplicationRecord
  has_many :recipes, dependent: :delete_all
  
  # Ruby method that creates getter/setter methods for the attributes
  # these methods do not persist in the database
  attr_accessor :display_name

  def display_name
    "#{first_name} #{last_name}"
  end
end
