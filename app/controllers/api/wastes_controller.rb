class Api::WastesController < ApplicationController
  respond_to :xml, :json

  def index
    render text: 'hello world.'
  end

  def get_regions
    regions = WasteTss.select(:area).distinct

    # render json: regions
    
    # respond_to do |format|
    #   format.json { render json: regions }
    #   format.xml  { render xml: regions }
    # end

    respond_with(regions)
  end
end