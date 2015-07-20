require File.expand_path('../lib/pxdoppelganger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = %w{Finn Lorbeer}
  gem.email = %w{finn.von.friesland@gmail.com}
  gem.summary = %q{pXdoppelganger will help you in your automated design regression testing}
  gem.description = %q{pXdoppelganger compares two images and can tell you the exact difference (in % of pixels changed). If you compare two screenshots of you app before and after a release, it will help you to automate your design regression tests. It follows the suggestions of image comparison by in Jeff Kreeftmeijers blog: jeffkreeftmeijer.com/2011/comparing-images-and-creating-image-diffs/}
  gem.homepage = "https://www.otto.de"

  gem.files = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.name = 'pxdoppelganger'
  gem.require_paths = %w(lib)
  gem.version = PXDoppelganger::Version
end
