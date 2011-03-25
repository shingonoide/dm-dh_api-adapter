require 'httparty'
require 'dm-core'

module DataMapper
  module DhApi
    module Adapter
      include HTTParty
      format :json
      base_uri 'https://api.dreamhost.com'

      def self.api_key(api_key)
        @@api_key = api_key
      end
      def self.domains
        options = {:query => {:key => @@api_key, :format => 'json', :cmd => 'domain-list_domains'}}
        request_api(options)
      end
      def self.dnses
        options = {:query => {:key => @@api_key, :format => 'json', :cmd => 'dns-list_records'}}
        request_api(options)
      end
      def self.users
        options = {:query => {:key => @@api_key, :format => 'json', :cmd => 'user-list_users_no_pw'}}
        request_api(options)
      end
      def self.users_pw
        options = {:query => {:key => @@api_key, :format => 'json', :cmd => 'user-list_users'}}
        request_api(options)
      end

      def self.request_api(options)
        response = get('/', options)
        case response['result']
          when 'success'
            response['data']
          when 'error'
            raise APIRequestError, "Error: #{response['data']}" + (response['reason'].blank? ? " " : " - Reason: #{response['reason']}")
          else
            raise APIRequestError, "Unknown exception"
        end
      end

      class APIRequestError < RuntimeError; end
    end
  end
end

module DataMapper
  module Adapters
    class DhApiAdapter < AbstractAdapter

      # Looks up one record or a collection of records from the data-store:
      # "SELECT" in SQL.
      #
      # @param [Query] query
      #   The query to be used to seach for the resources
      #
      # @return [Array]
      #   An Array of Hashes containing the key-value pairs for
      #   each record
      #
      # @api semipublic
      def read(query)
        query.filter_records(records_for(query.model).dup)
      end

      private

      # Make a new instance of the adapter. The @records ivar is the 'data-store'
      # for this adapter. It is not shared amongst multiple incarnations of this
      # adapter, eg DataMapper.setup(:default, :adapter => :in_memory);
      # DataMapper.setup(:alternate, :adapter => :in_memory) do not share the
      # data-store between them.
      #
      # @param [String, Symbol] name
      #   The name of the Repository using this adapter.
      # @param [String, Hash] uri_or_options
      #   The connection uri string, or a hash of options to set up
      #   the adapter
      #
      # @api semipublic
      def initialize(name, options = {})
        super
        DataMapper::DhApi::Adapter.api_key(options.delete(:api_key))
        @records = {}
      end

      # All the records we're storing. This method will look them up by model name
      #
      # @api private
      def records_for(model)
        storage_name = model.storage_name(name)
        case storage_name.to_sym
          when :domains, :domain, :data_mapper_dh_api_models_domains
            @records[storage_name] ||= DataMapper::DhApi::Adapter.domains
          when :dnses, :dns, :data_mapper_dh_api_models_dns
            @records[storage_name] ||= DataMapper::DhApi::Adapter.dnses
          when :users, :user, :data_mapper_dh_api_models_users
            @records[storage_name] ||= DataMapper::DhApi::Adapter.users
          when :users_pw, :user_pw, :data_mapper_dh_api_models_users_pw
            @records[storage_name] ||= DataMapper::DhApi::Adapter.users_pw
          else
            raise NotImplementedError, "Storage (#{storage_name}) not implemented"
        end

        @records[storage_name] ||= []
      end

    end # class DhApiAdapter

    const_added(:DhApiAdapter)
  end # module Adapters
end # module DataMapper