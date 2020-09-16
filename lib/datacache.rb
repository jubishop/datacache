require 'concurrent'

require 'core'
require 'duration'

class DataCache
  def initialize(timeout = 60.seconds)
    @timeout = timeout
    @cache = Concurrent::Hash.new
    @store_times = Concurrent::Hash.new
  end

  def fetch(key, &block)
    return @cache.fetch(key) if fresh?(key)

    return set(key, &block)
  end

  def set(key, &block)
    raise ArgumentError, 'Block must be given to DataCache.fetch' unless block

    @cache[key] = block.run
    @store_times[key] = Time.now
    return @cache.fetch(key)
  end

  def fresh?(key)
    return @cache.key?(key) && @store_times.fetch(key) + @timeout > Time.now
  end

  def invalidate(key)
    @cache.delete(key)
    @store_times.delete(key)
    return true
  end
end
