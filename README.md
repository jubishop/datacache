# Datacache

[![Rubocop Status](https://github.com/jubishop/datacache/workflows/Rubocop/badge.svg)](https://github.com/jubishop/datacache/actions)

A wrapper for caching data until a timeout.

## Installation

### Global installation

```zsh
gem install datacache --source https://www.jubigems.org/
```

### In a Gemfile

```ruby
gem 'datacache', source: 'https://www.jubigems.org/'
```

## Usage

```ruby
cache = DataCache.new(10.seconds)
now = cache.fetch('time') { Time.now }
# Future calls to cache.fetch('time') will return the same thing for 10 seconds

cache.fresh?('time') # true
sleep 10
cache.fresh?('time') # false

now = cache.set('time') { 123 }
# Future calls to cache.fetch('time') will return 123 for 10 seconds.

cache.invalidate('time')
# All references to 'time' are expunged.
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
