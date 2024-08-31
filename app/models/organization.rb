class Organization < ApplicationRecord
  validates :name, presence: true

  has_many :users, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :plants, dependent: :destroy
end
