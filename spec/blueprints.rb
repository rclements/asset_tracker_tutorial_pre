require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  # User
  email                                 { |index| "#{index}" + Faker::Internet.email }
  first_name(:unique => false)          { Faker::Name.first_name }
  middle_initial(:unique => false)      { ('a'..'z').to_a.rand.capitalize }
  last_name(:unique => false)           { Faker::Name.last_name }
  # Client, Project, Ticket
  name                                  { Faker::Company.name }
  initials(:unique => true)             { Array.new(3) { (rand(122-97) + 65).chr}.join }
  # Work Unit
  description(:unique => false)         { Faker::Company.bs }
  hours(:unique => false)               { rand(12) + 1}
  scheduled_at(:unique => false)        { Time.now }
  # Contact
  email_address                                 { |index| "#{index}" + Faker::Internet.email }
  first_name(:unique => false)          { Faker::Name.first_name }
  last_name(:unique => false)           { Faker::Name.last_name }
end

Contact.blueprint do
  first_name
  last_name
  email_address
  client { Client.make }
end

User.blueprint do
  email
  password 'password'
  password_confirmation 'password'
  first_name
  last_name
  middle_initial
end

Client.blueprint do
  name
  initials
  status { 'Active' }
end

Project.blueprint do
  name
  client { Client.make }
end

Ticket.blueprint do
  name
  project { Project.make }
end

WorkUnit.blueprint do
  # Note: The default is for unpaid and for uninvoiced
  ticket { Ticket.make }
  user { User.make }
  description
  hours
  scheduled_at
end

WorkUnit.blueprint(:paid) do
  paid { 'Check Number 1000' }
end

WorkUnit.blueprint(:invoiced) do
  invoiced { 'Invoice Number 1000' }
end

