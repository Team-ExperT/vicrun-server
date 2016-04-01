class CreateWaterQualities < ActiveRecord::Migration
  def change
    create_table :water_qualities do |t|
      t.string  :area
      t.string  :region
      t.integer :am_n
      t.float   :am_min
      t.float   :am_p25
      t.float   :am_p50
      t.float   :am_p75
      t.float   :am_max
      t.integer :ts_n
      t.float   :ts_min
      t.float   :ts_p25
      t.float   :ts_p50
      t.float   :ts_p75
      t.float   :ts_max
      t.float   :latitude
      t.float   :longitude
      t.string  :area_id

      t.timestamps null: false
    end
  end
end
