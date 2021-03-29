Gem::Specification.new do |spec|
  spec.name          = 'datacache'
  spec.version       = '1.2'
  spec.summary       = %q(A wrapper for caching data until a timeout.)
  spec.authors       = ['Justin Bishop']
  spec.email         = ['jubishop@gmail.com']
  spec.homepage      = 'https://github.com/jubishop/datacache'
  spec.license       = 'MIT'
  spec.files         = Dir['lib/**/*.rb'] + Dir['sig/**/*.rbs']
  spec.require_paths = ['lib']
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.metadata      = {
    'source_code_uri' => 'https://github.com/jubishop/datacache',
    'steep_types' => 'sig'
  }
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0')
  spec.add_runtime_dependency('concurrent-ruby')
  spec.add_runtime_dependency('core')
  spec.add_runtime_dependency('duration')
end
