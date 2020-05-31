Gem::Specification.new do |spec|
  spec.name          = "datacache"
  spec.version       = "1.0"
  spec.date          = "2020-05-30"
  spec.summary       = %q{A wrapper for caching data until a timeout}
  spec.authors       = ["Justin Bishop"]
  spec.email         = ["jubishop@gmail.com"]
  spec.homepage      = "https://github.com/jubishop/datacache"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.1")
  spec.files         = Dir["lib/**/*.rb"]
  spec.add_runtime_dependency 'core'
end
