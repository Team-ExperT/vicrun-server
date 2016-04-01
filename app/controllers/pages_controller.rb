class PagesController < ApplicationController
  def dataset
    @qualities = WaterQuality.all

    # Load markers onto map
    @hash = Gmaps4rails.build_markers(@qualities) do |quality, marker|
      marker.lat quality.latitude
      marker.lng quality.longitude
      marker.infowindow quality.area + ' - ' + quality.region
    end
  end
end