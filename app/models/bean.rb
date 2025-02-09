class Bean < ApplicationRecord
  belongs_to :roaster

  has_many :recipe_beans
  has_many :recipes, through: :recipe_beans

  # Creates a new bean from a similar bean
  # by cloning its attributes and creating 
  # a new instance
  def create_similar_bean(roaster)
    new_bean = self.deep_dup
    new_bean.roaster_id = roaster.id
    new_bean.save!
  end

  def fresh?
    # Returns true if the bean was roasted in the last 20 days
    # using between? method
    roasted_at.between?(20.days.ago, Time.now)
    # using cover? method
    # (20.days.ago..Time.now).cover?(roasted_at)
  end
end
