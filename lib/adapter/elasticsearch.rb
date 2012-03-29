require 'adapter'
require 'elasticsearch'

module Adapter
  module ElasticSearch
    NonHashValueKeyName = '_value'

    def read(key)
      doc = client.mget(@options[:type], [key_for(key)])['docs'].first
      doc['exists'] ? decode(doc) : nil
    end

    def write(key, value)
      options = {}
      if @options.key?(:parent) && value.is_a?(Hash)
        options[:parent] = value[@options[:parent].to_s]
      end
      client.add(@options[:type], key_for(key), encode(value), options)
    end

    def delete(key)
      read(key).tap { client.remove(@options[:type], key_for(key)) }
    end

    def clear
      client.remove_all(@options[:type])
    end

    def encode(value)
      value.is_a?(Hash) ? value : {NonHashValueKeyName => value}
    end

    def decode(value)
      return if value.nil?

      if value['_source'].key?(NonHashValueKeyName)
        value['_source'][NonHashValueKeyName]
      else
        value['_source'].merge({'id' => value['_id']})
      end
    end
  end
end

Adapter.define(:elasticsearch, Adapter::ElasticSearch)