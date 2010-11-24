# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require File.expand_path(File.dirname(__FILE__) + "../../spec/blueprints")

# Create an admin account
print "Creating user accounts..."
User.create(:email => 'admin@isotope11.com',
            :first_name => 'Admin',
            :middle_initial => 'A',
            :last_name => 'McAdmin',
            :password => '123456',
            :password_confirmation => '123456').has_role!(:admin)

# Create 2 developer accounts (1 with unpaid hours)
User.create(:email => 'test@isotope11.com',
            :first_name => 'Test',
            :middle_initial => 'T',
            :last_name => 'McTestman',
            :password => '123456',
            :password_confirmation => '123456')

# Create 3 random user accounts
3.times { User.make }
puts "done"

# Create 4 clients (1 without any projects)
print "Creating clients..."
4.times { Client.make }
puts "done"

# Create 2 projects per client
print "Creating projects..."
Client.all.each do |client|
  Project.make(:client => client)
end
puts "done"

# Create 2 tickets per project
print "Creating tickets..."
Project.all.each do |project|
  Ticket.make(:project => project)
end
puts "done"

# Create a bunch of work units
print "Creating work units..."
Ticket.all.each do |ticket|
  20.times { WorkUnit.make(:ticket => ticket,
                           :user => User.all.sort_by{ rand }.first,
                           :scheduled_at => Date.current.beginning_of_week + (-6..6).to_a.shuffle.first.days ) }
end
puts "done"

# Create 2 contacts per client

# Create 2 comments per user
