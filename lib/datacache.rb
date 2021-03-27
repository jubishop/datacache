require 'concurrent'
require 'core'
require 'duration'

class DataCache
  attr_reader :timeout

  def initialize(timeout = 60.seconds)
    @timeout = timeout
    @cache = Concurrent::Hash.new
    @store_times = Concurrent::Hash.new
  end

  def fetch(key, value = nil, &block)
    return @cache.fetch(key) if fresh?(key)

    return set(key, value, &block)
  end

  def set(key, value = nil, &block)
    if value.nil? == block.nil?
      raise ArgumentError, 'block OR value must be given to DataCache.set'
    end

    @cache[key] = value.nil? ? block.run : value
    @store_times[key] = Time.now

    return @cache.fetch(key)
  end

  def exists?(key)
    return @cache.key?(key)
  end

  def fresh?(key)
    return exists?(key) && @store_times.fetch(key) + @timeout > Time.now
  end

  def invalidate(key)
    @cache.delete(key)
    @store_times.delete(key)
    return true
  end
end
