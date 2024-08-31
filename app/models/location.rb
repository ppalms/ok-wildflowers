class Location < ApplicationRecord
  has_many :plantings, dependent: :delete_all
  has_many :plants, through: :plantings

  belongs_to :organization
end
