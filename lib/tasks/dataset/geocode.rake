# lib/tasks/geocode_dataset.rake
require 'csv'
include Geokit::Geocoders

namespace :dataset do
  desc 'Geocode given dataset'
  task :geocode => [:read, :write] do
    puts "Dataset is ready."
  end

  task read: :environment do
    file = "#{Rails.root.join('db', 'data')}/water_quality.csv"

    puts "Opening file."
    @qualities = CSV.read(file)

    puts "Geocoding."
    @qualities.each_with_index do |quality, index|
      if index == 0
        quality << "latitude"
        quality << "longitude"
        quality << "area_id"
      else
        coord = GoogleGeocoder.geocode(quality[1] + ', Victoria, Australia')
        if coord.success
          quality << coord.lat
          quality << coord.lng
          quality << quality[0].delete(' ')
        end
      end
    end
  end

  task write: :environment do
    puts "Writing output."
    # puts @qualities.to_yaml
    CSV.open("#{Rails.root.join('db', 'data')}/water_quality.new.csv", 'w') do |csv_object|
      @qualities.each do |row_array|
        csv_object << row_array
      end
    end
  end
end