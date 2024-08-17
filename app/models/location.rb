class Location < ApplicationRecord
  has_many :plants, through: :plant_locations
end
