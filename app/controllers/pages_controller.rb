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

  def convert2
    pi = Math::PI
    latitude    = -37.5967768 # (φ)
    longitude   = 144.1998141   # (λ)

    mapWidth    = 740;
    mapHeight   = 604;

    # get x value
    x = (longitude+180)*(mapWidth/360)

    # convert from degrees to radians
    latRad = latitude*pi/180;

    # get y value
    mercN = Math::log(Math::tan((pi/4)+(latRad/2)));
    y     = (mapHeight/2)-(mapWidth*mercN/(2*pi));

    render :text => x.to_s + ', ' + y.to_s
  end

  def convert
    # m = MapsProjection.new
    # p = m.fromLatLngToPoint(-37.812317, 144.969615, 9)
    # render :text => p.x.to_s + ', ' + p.y.to_s
    @hash = {}
    @qualities = WaterQuality.all
    @qualities.each do |q|
      c = _convert(q.latitude, q.longitude)
      hash = {
        'area'  => q.area,
        'region'  => q.region,
      }
      hash = hash.merge(c)
      @hash[q.id] = hash
    end

    render :text => @hash.to_yaml
  end

  def projection
    @qualities = WaterQuality.all
    @qualities.to_json
  end

  private

  def _convert(lat, lng)
    zoom = 10
    @scale = 1 << zoom
    @tile_size = 256

    worldCoordinate = project(lat, lng)
    pixelCoordinate = _pixelCoordinate(worldCoordinate)
    tileCoordinate = _tileCoordinate(worldCoordinate)
    
    {
      'world' => worldCoordinate.to_s,
      'pixel' => pixelCoordinate.to_s,
      'tile'  => tileCoordinate.to_s
    }
  end

  def project(lat, lng)
      siny = Math::sin(lat * Math::PI / 180);

      # // Truncating to 0.9999 effectively limits latitude to 89.189. This is
      # // about a third of a tile past the edge of the world tile.
      siny = [[siny, -0.9999].max, 0.9999].min

      x = @tile_size * (0.5 + lng / 360)
      y = @tile_size * (0.5 - Math::log((1 + siny) / (1 - siny)) / (4 * Math::PI))

      [x, y]
  end

  def _pixelCoordinate(coord)
    [coord.first * @scale, coord.last * @scale]
  end

  def _tileCoordinate(coord)
    [coord.first * @scale / @tile_size, coord.last * @scale / @tile_size]
  end
end