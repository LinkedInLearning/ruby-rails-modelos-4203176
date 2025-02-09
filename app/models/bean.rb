class Bean < ApplicationRecord
  belongs_to :roaster

  # Creates a new bean from a similar bean
  # by cloning its attributes and creating 
  # a new instance
  def create_similar_bean(roaster)
    new_bean = self.deep_dup
    new_bean.roaster_id = roaster.id
    new_bean.save!
  end
end
