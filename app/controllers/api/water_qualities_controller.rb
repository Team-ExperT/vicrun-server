class Api::WaterQualitiesController < ApplicationController
  respond_to :xml, :json

  def index
    render text: 'hello world.'
  end

  # def get_all
  #   qualities = WaterQuality.all

  #   respond_with(qualities)
  # end

  # def get_areas
  #   areas = WaterQuality.select(:area_id, :area).distinct.as_json
  #   new_areas = areas.each {|h| h.delete("id")}

  #   respond_with(new_areas)
  # end

  # def get_regions
  #   regions = WaterQuality.where(area_id: params[:area_name])

  #   respond_with(regions)
  # end

  def get_current_version
    respond_with({'version' => 4.0})
  end

  def get_daily_levels
    levels = WaterQuality.daily_picks

    levels.each do |level|
      if level.garbage_active == 0 && level.water_active == 0
        level.garbage_active = 1
        level.water_active = 1
      end
    end

    option = Option.find_by(:key => 'monash_expo_mode')
    monash_expo_mode = option.value

    if monash_expo_mode.eql? "true"
      monash_stage = {"garbage_active":1,"water_active":1,"id":999,"area":"Monash University","region":"Monash Caulfield","x":315,"y":319}
      levels.push(monash_stage)
    end

    respond_with(levels)
  end

  # def get_closest_stage
  #   coordinate = params[:coordinate]
  #   stage = get_closest(coordinate.split(','))
  #   respond_with(stage)
  # end

  def get_closest_catchment
    pcode = params[:pcode]
    location = Location.find_by(pcode: pcode)
    catchment = get_closest([location.lat, location.long])
    respond_with(catchment)
  end

  private
  def get_closest(location)
    WaterQuality.closest(origin: location)
  end
end