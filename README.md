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
now = cache.fetch('now') { Time.now }
# Future calls to cache.fetch('now') will return the same thing for 10 seconds

cache.fresh?('now') # true

cache.set('now') { 123 }
# Future calls to cache.fetch('now') will return 123 for 10 seconds.

cache.invalidate('now')
# All references to 'now' are expunged.

cache.fresh?('now') # false 
```
