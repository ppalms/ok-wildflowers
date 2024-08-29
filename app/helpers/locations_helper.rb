module LocationsHelper
  def location_overview(location)
    {
      peak_bloom_months: peak_bloom_months_for(location),
      dominant_bloom_colors: dominant_bloom_colors_for(location)
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
end
