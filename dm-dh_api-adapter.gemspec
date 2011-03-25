# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dm-dh_api-adapter/version"

Gem::Specification.new do |s|
  s.name        = "dm-dh_api-adapter"
  s.version     = Dm::Dhapi::Adapter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rui Andrada"]
  s.email       = ["shingonoide@gmail.com"]
  s.homepage    = "http://gihub.com/shingonoide/dm-dh_api-adapter"
  s.summary     = %q{DataMapper adapter for access Dreamhost's API}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "dm-dh_api-adapter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency("dm-core", "~> 1.1.0")
  s.add_runtime_dependency("httparty", "~> 0.7.4")
  s.add_development_dependency("rspec", "~> 1.3.1")
end
