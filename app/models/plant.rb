class Plant < ApplicationRecord
  def common_names_list
    common_names.join(", ")
  end

  def common_names_list=(value)
    self.common_names = value.split(",").map(&:strip)
  end

  has_and_belongs_to_many :bloom_colors

  has_one_attached :photo do |photo|
    photo.variant :thumb, resize_to_limit: [100, 100], preprocessed: true
  end
end
