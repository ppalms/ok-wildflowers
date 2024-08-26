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
  def plant_bloom_data(location)
    months = Date::ABBR_MONTHNAMES
    data = []

    location.plants.each do |plant|
      bloom_hash = (1..12).each_with_object({}) do |month_id, hash|
        hash[months[month_id]] = plant.bloom_months.any? { |bloom_month| bloom_month.id == month_id } ? 1 : 0
      end

      data << { name: plant.common_name, data: bloom_hash }
    end

    Rails.logger.info "Inspecting plant bloom data: #{data}"
    data
  end
end

