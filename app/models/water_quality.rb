class WaterQuality < ActiveRecord::Base
  def self.daily_picks
    Rails.cache.fetch('daily_picks', expires_in: 1.day) do
      self.limit(3).order("RANDOM()")
    end
  end
end
