class Roaster < ApplicationRecord
  def self.not_from_colombia
    # SELECT FROM roasters WHERE id NOT IN (1,2,3)
    excluded_ids = Roaster.where(location: "Bogotá, Colombia").pluck(:id)
    Roaster.where.not(id: excluded_ids)
  end
end
