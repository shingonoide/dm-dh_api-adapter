module DataMapper
  module DhApi
    module Models
      class DNS
        include DataMapper::Resource

        property :comment, String
        property :zone, String
        property :type, String
        property :editable, Boolean
        property :value, String
        property :record, String

      end

      class Domain
        include DataMapper::Resource
        property :fastcgi, Boolean
        property :hosting_type, String
        property :xcache, Boolean
        property :php_fcgid, Boolean
        property :security, Boolean
        property :unique_ip, String
        property :domain, String
        property :account, String
        property :type, String
        property :passanger, Boolean
        property :path, String
        property :home, String
        property :user, String
        property :www_or_not, String
      end

      class User
        include DataMapper::Resource

        property :disk_used_mb, Float
        property :gecos, String
        property :username, String
        property :account, String
        property :type, String
        property :quota_mb, String
        property :shell, String
        property :home, String
        property :password, String
      end
    end
  end
end
