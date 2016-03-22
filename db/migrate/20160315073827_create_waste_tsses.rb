class CreateWasteTsses < ActiveRecord::Migration
  def change
    create_table :waste_tsses do |t|
      t.string :area
      t.string :region
      t.integer :n
      t.float :min
      t.float :p25
      t.float :p50
      t.float :p75
      t.float :max

      t.timestamps null: false
    end
  end
end
