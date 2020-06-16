require 'core'

class DataCache
  def initialize(timeout = 60.seconds)
    @timeout = timeout
    @cache = {}
    @store_times = {}
  end

  def fetch(key, &block)
    raise ArgumentError, 'Block must be given to DataCache.fetch' unless block

    if @cache.key?(key) && @store_times.fetch(key) + @timeout > Time.now
      return @cache.fetch(key)
    end

    @cache[key] = block.run
    @store_times[key] = Time.now
    return @cache.fetch(key)
  end

  def invalidate(key)
    @cache.delete(key)
    @store_times.delete(key)
  end
end
