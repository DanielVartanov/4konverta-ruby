require 'happymapper'
require 'forwardable'

class Person
  include HappyMapper

  attribute :id, Integer
  attribute :name, String
end

class Persons
  include HappyMapper

  has_many :persons, Person
end

class User
  include HappyMapper
  extend Forwardable

  element :country, String, :attributes => { :code => String }
  element :currency, String, :attributes => { :code => String, :id => String }
  element :first_day_of_week, Integer, :tag => 'firstDayOfWeek'
  element :timeZone, String
  element :disable_extended_syntax, Boolean, :tag => 'disableExtendedSyntax'

  has_one :person_collection, Persons
  def_delegator :person_collection, :persons
end

#xml = Nokogiri::XML(response.body, nil, 'UTF-8')
#User.parse(xml).first