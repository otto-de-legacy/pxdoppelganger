require 'rspec'
require '../../lib/controller/analyzer'
require '../../lib/pxdoppelganger'

PATH_TO_OTTO_LOGO = '../images/ottologo.png'
PATH_TO_DIFFERENT_LOGO = '../images/ottologo2.png'
DIFFERENCE_IMAGE = '../images/otto_DIFF.png'

describe '#equal?' do

  it 'returns "true" if two images are equal' do
    pxdoppelganger = PXDoppelganger::Images.new(
        PATH_TO_OTTO_LOGO, PATH_TO_OTTO_LOGO
    )
    expect(
        pxdoppelganger.equal?
    ).to be(true)
  end

  it 'returns "false" if two images are equal' do
    pxdoppelganger = PXDoppelganger::Images.new(
        PATH_TO_OTTO_LOGO, PATH_TO_DIFFERENT_LOGO
    )
    expect(
        pxdoppelganger.equal?
    ).to be(false)
  end

end

describe '#difference' do

  it 'returns the %-difference of two images' do
    pxdoppelganger = PXDoppelganger::Images.new(
        PATH_TO_OTTO_LOGO, PATH_TO_DIFFERENT_LOGO
    )
    expect(
        pxdoppelganger.difference.round(2)
    ).to eq(1.38)
  end

end

describe '#save_difference_image' do

  after(:each) { FileUtils.rm DIFFERENCE_IMAGE if File.exist? (DIFFERENCE_IMAGE) }

  it 'saves the difference image' do
    pxdoppelganger = PXDoppelganger::Images.new(
        PATH_TO_OTTO_LOGO, PATH_TO_DIFFERENT_LOGO
    )
    pxdoppelganger.save_difference_image(DIFFERENCE_IMAGE)
    expect(
        File.exist? (DIFFERENCE_IMAGE)
    ).to be(true)
  end

end