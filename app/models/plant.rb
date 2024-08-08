class Plant < ApplicationRecord
  def other_common_names_list
    other_common_names.join(", ")
  end

  def other_common_names_list=(value)
    self.other_common_names = value.split(",").map(&:strip)
  end

  has_and_belongs_to_many :bloom_colors

  has_and_belongs_to_many :bloom_months

  has_one_attached :photo do |photo|
    photo.variant :thumb, resize_to_limit: [100, 100], preprocessed: true
  end
end
