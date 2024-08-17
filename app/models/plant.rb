class Plant < ApplicationRecord
  has_and_belongs_to_many :bloom_colors

  has_and_belongs_to_many :bloom_months

  has_many :locations, through: :plant_locations

  has_one_attached :photo do |photo|
    photo.variant :thumb, resize_to_limit: [100, 100], preprocessed: true
  end

  # Provides a comma-separated list of other common names for display in the UI
  def other_common_names_list
    other_common_names.join(", ")
  end

  # Accepts a string of comma-separated values and sets the other_common_names field for saving to the database
  def other_common_names_list=(value)
    self.other_common_names = value.split(",").map(&:strip)
  end
end
