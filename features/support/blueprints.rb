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
  name   { Faker::Company.name }
  guid   { UUID.generate }
end

Ticket.blueprint do
  project     { Project.make }
  name        { 'some name' }
  priority    'high'
  description { Faker::Company.name + "'s ticket" }
  guid        { UUID.generate }
end

User.blueprint do
  first_name     { Faker::Name.first_name }
  last_name      { Faker::Name.last_name  }
  middle_initial { ('A'..'Z').to_a.rand   }
  email          { Faker::Internet.email  }
  password_confirmation 'password'
  password 'password'
end

WorkUnit.blueprint do
  ticket      { Ticket.make }
  user        { User.make }
  description { Faker::Company.name + "'s work unit" }
  guid        { UUID.generate }
end
