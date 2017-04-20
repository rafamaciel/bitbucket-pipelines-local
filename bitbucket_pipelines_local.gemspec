# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitbucket_pipelines_local/version'

Gem::Specification.new do |spec|
  spec.name          = "bitbucket_pipelines_local"
  spec.version       = BitbucketPipelinesLocal::VERSION
  spec.authors       = ["Rafael de Barcelos Maciel"]
  spec.email         = ["rafael.maciel@earocha.com.br"]
  spec.summary       = "Bitbucket pipelines local"
  spec.description   = "Bitbucket pipelines local"
  spec.homepage      = ""
  spec.license       = "MIT"


  spec.files         = `git ls-files`.split($/)

  spec.executables   = 'pipelines'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
