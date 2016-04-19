class WaterQuality < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def self.daily_picks
    ids = []
    keys = [57, 12, 35]
    data = []

    garbage_list = self.where(garbage_active: 1, water_active: 0)
    water_list = self.where(garbage_active: 0, water_active: 1)
    hybrid_list = self.where("(garbage_active = ? AND water_active = ?) OR (garbage_active = ? AND water_active = ?)", 0,0,1,1)

    garbage = garbage_list[self.get_rand_id(1, 57, garbage_list.count)]
    water = water_list[self.get_rand_id(1, 12, water_list.count)]
    hybrid = hybrid_list[self.get_rand_id(1, 35, hybrid_list.count)]

    [garbage, water, hybrid]

    # keys.each do |key|
    #   n = 1
    #   while true
    #     rand_id = self.get_rand_id(n, key, 129)
    #     if ids.include?(rand_id)
    #       time = Time.new
    #       n = n + 1
    #     else
    #       ids << rand_id
    #       data << self.find(rand_id)
    #       break
    #     end
    #   end
    # end

    # data
    # Rails.cache.fetch('daily_picks', expires_in: 1.day) do
    #   self.limit(3).order("RANDOM()")
    # end
  end

  private

  def self.get_rand_id(n, key, total)
    time = Time.new
    rand_id = (calc_d(n, time.month, key) + 
      calc_d(n, time.year, key) +
      calc_d(n, time.day, key)) % total
  end

  def self.calc_d(n, d, key) 
    n.times do
      d = d * key
    end
    d
  end
end
