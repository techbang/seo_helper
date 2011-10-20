# -*- encoding: utf-8 -*-
require File.expand_path('../lib/seo_helper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["xdite"]
  gem.email         = ["xdite@techbang.com.tw"]
  gem.description   = %q{SEO helper of Techbang}
  gem.summary       = %q{SEO helper of Techbang}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "seo_helper"
  gem.require_paths = ["lib"]
  gem.version       = SeoHelper::VERSION
end
