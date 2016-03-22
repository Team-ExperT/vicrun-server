class AddCoordinateToWasteTss < ActiveRecord::Migration
  def change
  	add_column :waste_tsses, :latitude, :float
  	add_column :waste_tsses, :longitude, :float
  end
end
