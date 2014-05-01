# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'parchment/version'

Gem::Specification.new do |spec|
  spec.name          = 'parchment'
  spec.version       = Parchment::VERSION
  spec.date          = Time.now.strftime('%Y-%m-%d')
  spec.authors       = ['Allen Petlock']
  spec.email         = ['apetlock@gmail.com']
  spec.summary       = %q{Simple word processing document interaction}
  spec.description   = %q{A simple library for reading and intereacting with word processing documents, such as ODT, DOCX, etc.}
  spec.homepage      = 'https://github.com/apetlock/parchment'
  spec.license       = 'MIT'
  
  spec.files         = `git ls-files -z`.split('\n')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
  spec.add_runtime_dependency 'rubyzip', '~> 1'
end
