class Api::WastesController < ApplicationController
  respond_to :xml, :json

  def index
    render text: 'hello world.'
  end

  def get_areas
    areas = WasteTss.select(:area).distinct

    respond_with(areas)
  end
  def get_regions
    regions = WasteTss.where(area: params[:area_name])

    respond_with(regions)
  end
end