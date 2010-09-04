require 'machinist/active_record'
require 'sham'
require 'faker'

Client.blueprint do
  name { Faker::Company.name }
  status 'Good'
  guid { UUID.generate }
end

Project.blueprint do
  client { Client.make }
  name { Faker::Company.name }
  guid { UUID.generate }
end

Ticket.blueprint do
  project { Project.make }
  name { 'some name' }
  priority 'high'
  description { Faker::Company.name + "'s ticket" }
  guid { UUID.generate }
end

WorkUnit.blueprint do
  ticket { Ticket.make }
  description { Faker::Company.name + "'s work unit" }
  guid { UUID.generate }
end
