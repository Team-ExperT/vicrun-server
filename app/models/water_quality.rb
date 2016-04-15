class WaterQuality < ActiveRecord::Base
  def self.daily_picks
    ids = []
    keys = [57, 12, 35]
    data = []

    keys.each do |key|
      rand_id = self.get_rand_id(key)
      while true
        if ids.include?(rand_id)
          time = Time.new
          rand_id = self.get_rand_id(key*time.sec)
        else
          ids << rand_id
          data << self.find(rand_id)
          break
        end
      end
    end

    data
    # Rails.cache.fetch('daily_picks', expires_in: 1.day) do
    #   self.limit(3).order("RANDOM()")
    # end
  end

  private

  def self.get_rand_id(key)
    time = Time.new
    rand_id = ((time.month*key) + (time.year*key) + (time.day)) % 129
  end
end
