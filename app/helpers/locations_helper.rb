module LocationsHelper
  def location_overview(location)
    {
      peak_bloom_months: peak_bloom_months_for(location),
      dominant_bloom_colors: dominant_bloom_colors_for(location),
      plants_with_bloom_periods: plants_with_bloom_periods(location)
    }
  end

  private

  def peak_bloom_months_for(location, count = 3)
    BloomMonth.joins(plants: :locations)
              .where(locations: { id: location.id })
              .group('bloom_months.id', 'bloom_months.month_name')
              .order('COUNT(plants.id) DESC, bloom_months.id')
              .limit(count)
              .pluck('bloom_months.month_name')
  end

  def dominant_bloom_colors_for(location, count = 3)
    BloomColor.joins(plants: :locations)
              .where(locations: { id: location.id })
              .group('bloom_colors.id', 'bloom_colors.name')
              .order('COUNT(plants.id) DESC, bloom_colors.name')
              .limit(count)
              .pluck('bloom_colors.name')
  end

  def plants_with_bloom_periods(location)
    plants = location.plants
                     .includes(:bloom_months)
                     .reject { |plant| plant.bloom_months.empty? }
                     .sort_by { |plant| [plant.bloom_months.minimum(:id), plant.common_name] }

    plants.map do |plant|
      bloom_months = plant.bloom_months.order(:id)

      {
        common_name: plant.common_name,
        bloom_start: bloom_months.first.id,
        bloom_end: bloom_months.last.id
      }
    end
  end
end
