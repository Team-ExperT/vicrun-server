# lib/tasks/geocode_dataset.rake
require 'csv'
include Geokit::Geocoders

namespace :dataset do
  desc 'Prepare given raw dataset'
  task :prepare => [:read, :label_difficulty, :write] do
    puts "Dataset is ready."
  end

  task read: :environment do
    file = "#{Rails.root.join('db', 'data')}/water_quality.csv"

    puts "Opening file."
    @qualities = CSV.read(file)

    puts "Geocoding."
    @qualities.each_with_index do |quality, index|
      if index == 0
        quality << "latitude"       # col[9]
        quality << "longitude"      # col[10]
        quality << "area_id"        # col[11]
        quality << "score_avg"      # col[12]
        quality << "score_rank"     # col[13]
        quality << "garbage_active" # col[14]
        quality << "water_active"   # col[15]
      else
        coord = GoogleGeocoder.geocode(quality[2] + ', Victoria, Australia')
        if coord.success
          area = quality[1]
          region = quality[2]

          # Remove word Catchment from area
          quality[1] = simplify_area(area)

          # Simplify region
          # quality[2] = simplify_region(region)

          quality << coord.lat
          quality << coord.lng
          quality << quality[1] # :area_id is same as area as we have remove for Catchment

          # Add difficulty columns
          difficulty = calculate_difficulty(quality)
          quality << difficulty[:average]
          quality << 0 # filled by :label_difficulty
          quality << difficulty[:garbage]
          quality << difficulty[:water]
        end
      end
    end
  end

  def simplify_area(area)
    new_area = area.split
    new_area.first
  end

  def simplify_region(region)
    creek = region.split(' at ').first
    suburb = region.split(', ').last
    creek + ', ' + suburb
  end

  def calculate_difficulty(quality)
    # garbage = sqrt(ni*ox*ph*20)*10
    # water = 23 - sqrt(min+ max)

    garbage = Math::sqrt(quality[3].to_f * quality[4].to_f * quality[5].to_f * 20) * 10
    water = 23 - Math::sqrt(quality[6].to_f + quality[8].to_f)
    {:average => (garbage + water) / 2, :garbage => garbage, :water => water }
  end

  task :label_difficulty do
    # Temporarily remove header
    shifted = @qualities.shift
    
    # Label garbage
    @qualities.sort_by! { |q| q[14].to_f }
    @qualities.each_with_index do |quality, index|
      if index < 64
        quality[14] = 1
      else
        quality[14] = 0
      end
    end
    
    # Label water
    @qualities.sort_by! { |q| q[15].to_f }
    @qualities.each_with_index do |quality, index|
      if index < 64
        quality[15] = 1
      else
        quality[15] = 0
      end
    end

    # Rank score avg
    @qualities.sort_by! { |q| q[12].to_f }.reverse!
    @qualities.each_with_index do |quality, index|
      quality[13] = index + 1
    end

    # Put back the header
    @qualities.unshift(shifted)

    # Re-sort by id
    @qualities.sort_by! { |q| q[0].to_i }
  end

  task write: :environment do
    puts "Writing output."
    # puts @qualities.to_yaml
    CSV.open("#{Rails.root.join('db', 'data')}/water_quality.prepared.csv", 'w') do |csv_object|
      @qualities.each do |row_array|
        csv_object << row_array
      end
    end
  end
end