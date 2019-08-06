lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nsone/version"

Gem::Specification.new do |spec|
  spec.name          = "ns-1"
  spec.version       = NSOne::VERSION
  spec.authors       = ["Esteban Pastorino"]
  spec.email         = ["ejpastorino@gmail.com"]
  spec.license       = "MIT"

  spec.summary       = %q{NS1 API Client}
  spec.description   = %q{Based on kitop ns1 gem}
  spec.homepage      = "https://github.com/benkap/ns1-ruby"

  spec.files         = `find . -type f`.split("\n").reject { |f| f[/test|spec\/|features|tmp|\.git\/|doc|\.yardopts|^.$|vscode|\.gem$/]}.each {|f| f.slice!(/^.\//)}
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.3.0"
end
