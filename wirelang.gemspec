
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wirelang/version'

Gem::Specification.new do |spec|
  spec.name          = 'wirelang'
  spec.version       = Wirelang::VERSION
  spec.authors       = ['Vasily Kolesnikov']
  spec.email         = ['re.vkolesnikov@gmail.com']

  spec.summary       = 'SICP Chapter 3 examples'
  spec.homepage      = 'https://github.com/v-kolesnikov/werilang'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
