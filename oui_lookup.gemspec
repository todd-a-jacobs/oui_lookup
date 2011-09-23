# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'oui_lookup/version'

Gem::Specification.new do |s|
  s.name        = 'oui_lookup'
  s.version     = OUI_Lookup::VERSION
  s.authors     = ['Todd A. Jacobs']
  s.email       = ['spamivore+oui_lookup@codegnome.org']
  s.homepage    = "https://github.com/CodeGnome/#{s.name}"
  s.summary     = %q{Lookup IEEE Organizationally Unique Identifiers.}
  s.description = %q{Find OUI prefixes using the IEEE public registry.}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 1.9.2'

  # specify any dependencies here; for example:
  s.add_development_dependency 'minitest'
  s.add_runtime_dependency 'rest-client'
  s.add_runtime_dependency 'nokogiri'
end
