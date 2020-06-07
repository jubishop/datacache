require 'core'

class DataCache
  # Timeout is in seconds
  def initialize(timeout = 60)
    @timeout = timeout
    @cache = {}
    @store_times = {}
  end

  def fetch(key, &block)
    raise ArgumentError, 'Block must be given to DataCache.fetch' unless block

    if @cache.key?(key) && Time.now.to_i - @store_times.fetch(key) < @timeout
      return @cache.fetch(key)
    end

    @cache[key] = block.run
    @store_times[key] = Time.now.to_i
    return @cache.fetch(key)
  end

  def invalidate(key)
    @cache.delete(key)
    @store_times.delete(key)
  end
end
