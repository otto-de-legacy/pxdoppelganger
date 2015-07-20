require 'rspec'
require 'fileutils'
require '../../lib/controller/analyzer'

describe '#analyzer' do

  PATH_TO_OTTO_LOGO = '../images/ottologo.png'
  PATH_TO_DIFFERENT_LOGO = '../images/ottologo2.png'
  DIFFERENCE_IMAGE = '../images/otto_DIFF.png'

  after(:each) { FileUtils.rm DIFFERENCE_IMAGE if File.exist? (DIFFERENCE_IMAGE) }

  it "should throw an exception if the images is not png" do
    expect {
      Analyzer.new('some_wrong/path.JPG', 'another_wrong/path.JPG')
    }.to raise_error("The images need to be in png format")
  end

  it "should throw an exception if the image cannot be found" do
    expect {
      Analyzer.new('some_wrong/path.png', 'another_wrong/path.PNG')
    }.to raise_error(Errno::ENOENT)
  end

  it "should throw an exception if the images do not have the same width" do
    expect {
      Analyzer.new(PATH_TO_OTTO_LOGO, '../images/ottologosmall.png')
    }.to raise_error("The images do not have the same width.")
  end

  it "should return an empty array if both analyzed images are the same" do
    analyzer = Analyzer.new(PATH_TO_OTTO_LOGO, PATH_TO_OTTO_LOGO)
    expect(
        analyzer.difference.empty?
    ).to be(true)
  end

  it "should return 0% change if both analyzed images are the same" do
    analyzer = Analyzer.new(PATH_TO_OTTO_LOGO, PATH_TO_OTTO_LOGO)
    expect(
        analyzer.difference_in_percent
    ).to eq(0)
  end

  it "should return a not empty array if both analyzed images are not the same" do
    analyzer = Analyzer.new(PATH_TO_OTTO_LOGO, PATH_TO_DIFFERENT_LOGO)
    expect(
        analyzer.difference.empty?
    ).to be(false)
  end

  it "should return x% change if the analyzed images are not the same" do
    analyzer = Analyzer.new(PATH_TO_OTTO_LOGO, PATH_TO_DIFFERENT_LOGO)
    expect(
        analyzer.difference_in_percent.round(2)
    ).to eq(1.38)
  end

  it "should create an output image" do
    analyzer = Analyzer.new(PATH_TO_OTTO_LOGO, PATH_TO_DIFFERENT_LOGO)
    expect(
        analyzer.save_output(DIFFERENCE_IMAGE)
    ).to be_a(File)
  end

  it "should save an output image" do
    analyzer = Analyzer.new(PATH_TO_OTTO_LOGO, PATH_TO_DIFFERENT_LOGO)
    analyzer.save_output(DIFFERENCE_IMAGE)
    expect(
        File.exist? (DIFFERENCE_IMAGE)
    ).to be(true)
  end

end
