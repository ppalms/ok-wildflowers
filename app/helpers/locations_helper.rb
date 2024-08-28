module LocationsHelper
  def location_overview(location)
    {
      peak_bloom_months: peak_bloom_months_for(location),
      dominant_bloom_colors: dominant_bloom_colors_for(location)
    }
  end

  private

  def peak_bloom_months_for(location, count = 3)
    result = BloomMonth.joins(plants: :locations)
      .where(locations: { id: location.id })
      .group('bloom_months.id', 'bloom_months.month_name')
      .order('COUNT(plants.id) DESC, bloom_months.id')
      .limit(count)
      .pluck('bloom_months.month_name')
  end

  def dominant_bloom_colors_for(location, count = 3)
    result = BloomColor.joins(plants: :locations)
      .where(locations: { id: location.id })
      .group('bloom_colors.id', 'bloom_colors.name')
      .order('COUNT(plants.id) DESC, bloom_colors.name')
      .limit(count)
      .pluck('bloom_colors.name')
  end

  # Generates data for chart representing plant bloom times.
  # Results in a line that starts at 0 during months the plant is not blooming
  # and rises to 1 during bloom months.
  def plant_bloom_lines(location)
    plant_lines = []
    months = Date::MONTHNAMES.compact # ["January", "February", ...]

    location.plants.each_with_index do |plant, index|
      bloom_months = plant.bloom_months.order(:id) # Assuming bloom_months is sorted by month ID
      next if bloom_months.empty?

      # Create a hash with all months initialized to nil
      data_points = months.index_with { |_month| nil }

      # Fill in only the bloom months with the correct Y value
      bloom_months.each do |bloom_month|
        data_points[Date::MONTHNAMES[bloom_month.id]] = index + 1
      end

      plant_lines << {
        name: plant.common_name,
        data: data_points
      }
    end

    plant_lines
  end
end
