#$KCODE = 'UTF-8'
#$KCODE = "u"

require 'rubygems'
require 'patron'
require 'nokogiri'

require 'classes'

def person_id
  @person_id ||= fetch_person_id
end

def fetch_person_id
  response = @session.get '/user'
  xml = Nokogiri::XML(response.body, nil, 'UTF-8')
  user = User.parse(xml).first
  user.persons.first.id
end

auth_account = { :login => '', :password => '' }

@session = Patron::Session.new
@session.base_url = "http://4konverta.com/data/#{auth_account[:login]}"
@session.timeout = 10

@session.headers['4KAuth'] = auth_account[:password]
@session.headers['4KApplication'] = 'Demo'

response = @session.get "/execution/2010-05-24"
xml = Nokogiri::XML(response.body, nil, 'UTF-8')

puts xml.to_xml