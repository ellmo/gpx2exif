require 'spec_helper'
require 'gpx2png/osm'

describe Gpx2png::Osm do
  it "should create simple map" do
    e = Gpx2png::Osm.new
    e.add(50.0, 20.0)
    e.add(51.0, 20.0)
    e.add(51.0, 21.0)
    e.add(50.0, 21.0)
    e.to_png('samples/png_sample1.png')
  end

  it "should create using GPX file" do
    g = GpxUtils::TrackImporter.new
    g.add_file(File.join('spec', 'fixtures', 'sample.gpx'))

    e = Gpx2png::Osm.new
    e.coords = g.coords
    e.zoom = 8
    e.to_png('samples/png_sample2.png')
  end
end
