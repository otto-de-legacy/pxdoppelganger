require 'oily_png'
require 'chunky_png'
require 'fileutils'
include OilyPNG::Color
include ChunkyPNG::Color

class Analyzer

  attr_accessor :difference, :difference_in_percent

  def initialize(base_image, new_image)
    raise 'The images need to be in png format' unless are_images_png?(base_image, new_image)
    self.images = [
        ChunkyPNG::Image.from_file(base_image),
        ChunkyPNG::Image.from_file(new_image),
    ]
    raise_different_size unless images_have_same_width?
    self.difference = difference_analyzer
    self.difference_in_percent = percent_calculator(difference)
  end

  def save_output(path)
    @output.save(path)
  end

  private

  attr_accessor :images

  def are_images_png?(base, new)
    true if (base.downcase.include? 'png') && (new.downcase.include? 'png')
  end

  def images_have_same_width?
    images.first.width == images.last.width
  end

  def raise_different_size
    raise "The images do not have the same width."
  end

  def difference_analyzer
    @output = ChunkyPNG::Image.new(images.first.width, images.first.height, WHITE)
    difference = []
    images.first.height.times do |y|
      images.first.row(y).each_with_index do |pixel, x|
        begin
          unless pixel == images.last[x,y]
            score = Math.sqrt(
                (r(images.last[x,y]) - r(pixel)) ** 2 +
                (g(images.last[x,y]) - g(pixel)) ** 2 +
                (b(images.last[x,y]) - b(pixel)) ** 2
            ) / Math.sqrt(MAX ** 2 * 3)

            @output[x,y] = grayscale(MAX - (score * MAX).round)
            difference << score
          end
        rescue ChunkyPNG::OutOfBounds
          # "out of bound error"
          # in Y-Direction (= one image is longer than the other)
          # if webpages change, they may have a different vertical length
        end
      end
    end
    difference
  end

  def percent_calculator(difference)
    if difference == []
      0
    else
      ((difference.inject {|sum, value| sum + value} / images.first.pixels.length) * 100).to_f
    end
  end

end
