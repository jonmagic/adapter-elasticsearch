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
end