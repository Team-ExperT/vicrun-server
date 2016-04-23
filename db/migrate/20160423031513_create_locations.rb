class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :pcode
      t.string  :locality
      t.float   :lat
      t.float   :long

      t.timestamps null: false
    end
  end
end
