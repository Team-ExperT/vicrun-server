class WaterQuality < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def self.daily_picks
    ids = []
    keys = [57, 12, 35]
    data = []

    keys.each do |key|
      n = 1
      while true
        rand_id = self.get_rand_id(1, key)
        if ids.include?(rand_id)
          time = Time.new
          n = n + 1
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

  def self.get_rand_id(n, key)
    time = Time.new
    rand_id = (calc_d(n, time.month, key) + 
      calc_d(n, time.year, key) +
      calc_d(n, time.day, key)) % 129
  end

  def self.calc_d(n, d, key) 
    n.times do
      d = d * key
    end
  end
end
