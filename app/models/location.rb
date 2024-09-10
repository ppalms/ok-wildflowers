class Location < ApplicationRecord
  validates :name, presence: true

  has_many :plantings, dependent: :delete_all

  has_many :plants, through: :plantings

  has_many :notes, dependent: :delete_all

  belongs_to :organization
end
