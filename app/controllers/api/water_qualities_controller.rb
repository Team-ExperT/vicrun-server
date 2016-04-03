class Api::WaterQualitiesController < ApplicationController
  respond_to :xml, :json

  def index
    render text: 'hello world.'
  end

  def get_areas
    areas = WaterQuality.select(:area_id, :area).distinct
    
    new_areas = []
    areas.each do |area|
      new_area = {
        :area_id => area.area_id,
        :area    => area.area
      }
      new_areas << new_area
    end

    respond_with(new_areas)
  end

  def get_regions
    regions = WaterQuality.where(area_id: params[:area_name])

    respond_with(regions)
  end

  def get_current_version
    respond_with({'version' => 1.0})
  end
end