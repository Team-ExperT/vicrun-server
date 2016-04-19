class WaterQuality < ActiveRecord::Base
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  def self.daily_picks
    ids = []
    keys = [57, 12, 35]
    data = []
    result = []

    data << self.where(garbage_active: 1, water_active: 0)
    data << self.where(garbage_active: 0, water_active: 1)
    data << self.where("(garbage_active = ? AND water_active = ?) OR (garbage_active = ? AND water_active = ?)", 0,0,1,1)

    data.each_with_index do |d, i|
      total = d.count
      id = self.get_rand_id(keys[i], total)
      result << d[id]
    end
    
    result
  end

  private

  def self.get_rand_id(key, total)
    time = Time.new
    rand_id = ((time.month * key) + 
      (time.year * key) +
      (time.day * key)) % total
  end
end
