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
      t.float   :score_avg
      t.integer :score_rank
      t.integer :garbage_active
      t.integer :water_active
      t.float   :x
      t.float   :y

      t.timestamps null: false
    end
  end
end
