class Bean < ApplicationRecord
  belongs_to :roaster

  # Creates a new bean from a similar bean
  # by cloning its attributes and creating 
  # a new instance
  def create_from_similar_bean(bean, roaster)
    b2 = b1.deep_dup
    b2.roaster_id = roaster.id
    b2.save!
  end
end
