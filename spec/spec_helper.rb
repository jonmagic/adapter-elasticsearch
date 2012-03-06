require 'bundler'
Bundler.require :default, :test

require 'adapter/spec/an_adapter'
require 'adapter/spec/types'
require 'adapter-elasticsearch'

shared_examples_for "an elasticsearch adapter" do
  it_should_behave_like 'an adapter'

  Adapter::Spec::Types.each do |type, (key, key2)|
    it "writes Object values to keys that are #{type}s like a Hash" do
      adapter[key] = {:foo => :bar}
      adapter[key].should == {'id' => 'key', 'foo' => 'bar'}
    end
  end
end