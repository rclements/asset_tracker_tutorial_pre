require 'machinist/active_record'
require 'sham'
require 'faker'

Client.blueprint do
  name { Faker::Company.name }
  status 'test'
end

Project.blueprint do
  client { Client.make }
  name { Faker::Company.name }
end
