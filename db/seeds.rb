# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
plants = [
  { scientific_name: "Gaillardia pulchella", common_names:["Indian Blanket"], bloom_colors: ["Red", "Yellow"], bloom_time: ["May","Jun","Jul","Aug"] }
]

plants.each do |plant_attributes|
  Plant.find_or_create_by!(plant_attributes)
end
