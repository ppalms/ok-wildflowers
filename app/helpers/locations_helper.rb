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
      .order('bloom_months.id, COUNT(plants.id) DESC')
      .limit(count)
      .pluck('bloom_months.month_name')
  end

  def dominant_bloom_colors_for(location, count = 3)
    result = BloomColor.joins(plants: :locations)
      .where(locations: { id: location.id })
      .group('bloom_colors.id', 'bloom_colors.name')
      .order('bloom_colors.name, COUNT(plants.id) DESC')
      .limit(count)
      .pluck('bloom_colors.name')
  end
end

