class BloomColor < ApplicationRecord
  has_and_belongs_to_many :plants

  def self.options_for_select
    order("INITCAP(name)").map { |e| [e.name, e.id] }
  end
end
