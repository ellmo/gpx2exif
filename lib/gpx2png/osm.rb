require 'rubygems'
require 'gpx2png/osm_base'

$:.unshift(File.dirname(__FILE__))

module Gpx2png
  class Osm < OsmBase

    DEFAULT_RENDERER = :rmagick
    attr_accessor :renderer

    def initialize
      super
      @renderer ||= DEFAULT_RENDERER
      @r = nil
    end

    def to_png(filename)
      setup_renderer
      initial_calculations
      download_and_join_tiles
      @r.save(filename)
      filename
    end

    attr_accessor :renderer_options

    # Get proper renderer class
    def setup_renderer
      case @renderer
        when :chunky_png
          require 'gpx2png/renderers/chunky_png_renderer'
          @r = ChunkyPngRenderer.new(@renderer_options)
        when :rmagick
          require 'gpx2png/renderers/rmagick_renderer'
          @r = RmagickRenderer.new(@renderer_options)
        else
          raise ArgumentError
      end
    end

  end
end