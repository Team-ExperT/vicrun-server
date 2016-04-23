# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'smarter_csv'
require 'json'

# 1st chunk
# SmarterCSV.process ( "#{Rails.root.join('db', 'data')}/water_quality.prepared.csv") do |chunk|
#   chunk.each do |data_hash|
#     WaterQuality.create!(data_hash)
#   end
# end

# 2nd chunk
file = File.read("#{Rails.root.join('db', 'data')}/water_quality.pixelated.json")
data_hash = JSON.parse(file)

data_hash.each do |data|
  WaterQuality.create!(data)
end

SmarterCSV.process ( "#{Rails.root.join('db', 'data')}/location.csv") do |chunk|
  chunk.each do |data_hash|
    Location.create!(data_hash)
  end
end