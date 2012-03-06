# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "adapter/elasticsearch/version"

Gem::Specification.new do |s|
  s.name        = "adapter-elasticsearch"
  s.version     = Adapter::ElasticSearch::VERSION
  s.authors     = ["Jonathan Hoyt"]
  s.email       = ["hoyt@github.com"]
  s.homepage    = ""
  s.summary     = %q{Adapter for ElasticSearch}
  s.description = %q{Adapter for ElasticSearch}

  s.rubyforge_project = "adapter-elasticsearch"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'adapter', '~> 0.5.2'
  s.add_dependency 'elasticsearch-client', '~> 0.0.3'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.8.0'
end
