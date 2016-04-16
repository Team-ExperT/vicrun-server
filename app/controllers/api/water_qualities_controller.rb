class Api::WaterQualitiesController < ApplicationController
  respond_to :xml, :json

  def index
    render text: 'hello world.'
  end

  def get_all
    qualities = WaterQuality.all

    respond_with(qualities)
  end

  def get_areas
    areas = WaterQuality.select(:area_id, :area).distinct.as_json
    new_areas = areas.each {|h| h.delete("id")}

    respond_with(new_areas)
  end

  def get_regions
    regions = WaterQuality.where(area_id: params[:area_name])

    respond_with(regions)
  end

  def get_current_version
    respond_with({'version' => 3.0})
  end

  def get_daily_levels
    levels = WaterQuality.daily_picks
    respond_with(levels)
  end

  def get_closest_stage
    coordinate = params[:coordinate]
    player_location = coordinate.split(',')
    stage = WaterQuality.closest(origin: player_location)
    respond_with(stage)
  end
end