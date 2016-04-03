class CreateWaterQualities < ActiveRecord::Migration
  def change
    create_table :water_qualities do |t|
      t.string  :area
      t.string  :region
      t.float   :ni_p50
      t.float   :ox_p50
      t.float   :ph_p50
      t.float   :ts_min
      t.float   :ts_p50
      t.float   :ts_max
      t.float   :latitude
      t.float   :longitude
      t.string  :area_id

      t.timestamps null: false
    end
  end
end
