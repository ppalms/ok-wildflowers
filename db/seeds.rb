# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

(1..12).each do |month_number|
  BloomMonth.find_or_create_by!(month_name: Date::ABBR_MONTHNAMES[month_number], month_number: month_number)
end

%w[Red Orange Yellow Green Blue Purple White Black Brown Pink].each do |color_name|
  BloomColor.find_or_create_by!(name: color_name)
end

Organization.find_or_create_by(name: 'Gardenerd')
