class Location < ApplicationRecord
  has_many :plantings, dependent: :destroy
  has_many :plants, through: :plantings
end
