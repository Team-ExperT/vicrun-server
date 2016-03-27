class AddAreaIdToWasteTss < ActiveRecord::Migration
  def change
    add_column :waste_tsses, :area_id, :string
  end
end
