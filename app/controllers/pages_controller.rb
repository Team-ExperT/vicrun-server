class PagesController < ApplicationController
  def dataset
    @waste = WasteTss.all

    # Load markers onto map
    @hash = Gmaps4rails.build_markers(@waste) do |waste, marker|
      marker.lat waste.latitude
      marker.lng waste.longitude
      marker.infowindow waste.area + ' - ' + waste.region
    end
  end
end