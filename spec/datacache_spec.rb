require 'datacache'
require 'duration'

RSpec.describe(DataCache) {
  before(:each) {
    @datacache = DataCache.new
  }

  it('defaults to 60 seconds') {
    expect(@datacache.timeout).to(eq(60.seconds))
  }

  it('goes stale after timeout') {
    @datacache.set('key', 'value')

    cur_time = Time.now
    allow(Time).to(receive(:now).and_return(cur_time + 30.seconds))
    expect(@datacache.fresh?('key')).to(be(true))
    allow(Time).to(receive(:now).and_return(cur_time + 90.seconds))
    expect(@datacache.fresh?('key')).to(be(false))
  }

  it('always says nonexistent keys are stale') {
    expect(@datacache.fresh?('dne')).to(be(false))
  }

  it('invalidates keys') {
    @datacache.set('key', 'value')
    expect(@datacache.fetch('key')).to(eq('value'))
    @datacache.invalidate('key')
    expect(@datacache.exists?('key')).to(be(false))
  }

  context('#set') {
    it('takes a block') {
      @datacache.set('key') { return 'value' }
      expect(@datacache.fetch('key')).to(eq('value'))
    }

    it('demands a block OR a value') {
      expect { @datacache.set('key', 'value') { 'and_block' } }.to(
          raise_error(ArgumentError))
      expect { @datacache.set('key') }.to(raise_error(ArgumentError))
    }
  }
}
