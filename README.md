# Datacache

A wrapper for caching data until a timeout.

## Installation

Add these lines to your application's Gemfile:

```ruby
gem 'concurrent-ruby', require: 'concurrent'

gem 'core', github: 'jubishop/core'
gem 'duration', github: 'jubishop/duration'
gem 'datacache', github: 'jubishop/datacache'
```

And then execute:

```sh
$ bundle install
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
