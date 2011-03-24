require 'rubygems'
require 'dm-core'
#require 'dm-types'
require 'dm-dh_api-adapter'

DataMapper.setup(:default, :adapter => :dh_api, :api_key => '6SHU5P2HLDAYECUM')

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

class DNS
  include DataMapper::Resource

  property :comment, String
  property :zone, String
  property :type, String
  property :editable, Boolean
  property :value, String
  property :record, String

end

class DhUser
  include DataMapper::Resource

  # storage_names[:default] = 'users'
end

domains = Domain.all
dnses_editables =  DNS.all(:editable => true)
dnses_not_editables = DNS.all(:editable => false)
users = DhUser.all

puts "There's #{domains.size} domains records"

puts "There's #{dnses_editables.size} editables dnses records"
puts "There's #{dnses_not_editables.size} not editables dnses records"

puts "There's #{users.size} users records"


domains[0].domain = "testing.com"

puts domains[0].domain

domains.save