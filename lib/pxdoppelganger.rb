require 'rubygems'
require 'controller/analyzer'

module PXDoppelganger

  class Images

    def initialize(base_image, new_image)
      @result = Analyzer.new(base_image, new_image)
    end

    def equal?
      @result.difference == []
    end

    def difference
      @result.difference_in_percent
    end

    def save_difference_image(path)
      @result.save_output(path)
    end

  end

end
