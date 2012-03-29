require 'spec_helper'

describe Adapter::ElasticSearch do
  before(:each) do
    index = 'adapter-elasticsearch'
    `curl -s -XDELETE http://localhost:9200/#{index}`
    `curl -s -XPUT http://localhost:9200/#{index} -d'{ "index" : { "analysis" : { "analyzer" : { "default" : { "type" : "simple" } } } } }'`
    `curl -s -XPUT http://localhost:9200/#{index}/document/_mapping -d'{"document":{"properties":{"foo":{"type":"string","analyzer":"standard"}}}}'`

    @client   = ElasticSearch::Index.new(index, 'http://127.0.0.1:9200')
    @adapter  = Adapter[:elasticsearch].new(@client, {:type => 'document'})
  end

  let(:client)  { @client }
  let(:adapter) { @adapter }

  it_should_behave_like 'an elasticsearch adapter'

  describe "#write" do
    context "with parent" do
      let(:adapter) { Adapter[:elasticsearch].new(@client, {:type => 'document', :parent => :library}) }

      it "sets parent parameter" do
        params = {'foo' => 'bar', 'library' => '2'}
        @client.should_receive(:add).with('document', '123', params, :parent => '2')
        adapter.write('123', params)
      end

      it "does not set parent on non-hash values" do
        @client.should_receive(:add).with('document', '123', {'_value' => '456'}, {})
        adapter.write('123', '456')
      end
    end
  end
end