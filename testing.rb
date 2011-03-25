require 'rubygems'
require 'dm-core'
#require 'dm-types'
require 'dm-dh_api-adapter'

DataMapper.setup(:default, :adapter => :dh_api, :api_key => '6SHU5P2HLDAYECUM')

require 'dm-dh_api-adapter/models'
require 'pp'
include DataMapper::DhApi::Models

domains = Domain.all
dnses_editables = DNS.all(:editable => true)
dnses_not_editables = DNS.all(:editable => false)
users = User.all
pp Domain.all

puts "#{Domain.last.domain}"
puts "There's #{domains.size} domains records"

puts "There's #{dnses_editables.size} editables dnses records"
puts "There's #{dnses_not_editables.size} not editables dnses records"

puts "There's #{users.size} users records"


domains[0].domain = "testing.com"

puts domains[0].domain

domains.save