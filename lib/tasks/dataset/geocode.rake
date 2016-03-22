# lib/tasks/geocode_dataset.rake
require 'csv'
include Geokit::Geocoders

namespace :dataset do
  desc 'Geocode given dataset'
  task :geocode => [:read, :write] do
    puts "Dataset is ready."
  end

  task read: :environment do
    file = "#{Rails.root.join('db', 'data')}/waste_tss.csv"

    puts "Opening file."
    @wastes = CSV.read(file)

    puts "Geocoding."
    @wastes.each_with_index do |waste, index|
      if index == 0
        waste << "latitude"
        waste << "longitude"
      else
        coord = GoogleGeocoder.geocode(waste[1] + ', Victoria, Australia')
        if coord.success
          waste << coord.lat
          waste << coord.lng
        end
      end
    end
  end

  task write: :environment do
    puts "Writing output."
    CSV.open("#{Rails.root.join('db', 'data')}/waste_tss.new.csv", 'w') do |csv_object|
      @wastes.each do |row_array|
        csv_object << row_array
      end
    end
  end
end