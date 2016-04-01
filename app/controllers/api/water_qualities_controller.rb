class Api::WaterQualitiesController < ApplicationController
  respond_to :xml, :json

  def index
    render text: 'hello world.'
  end

  def get_areas
    areas = WaterQuality.select(:area_id, :area).distinct

    respond_with(areas)
  end
  def get_regions
    regions = WaterQuality.where(area_id: params[:area_name])

    respond_with(regions)
  end
end