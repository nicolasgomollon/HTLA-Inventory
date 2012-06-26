# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
students = Student.create([
  {:id => 1, :firstname => "Julian", :lastname => "Moore", :studentid => 10082, :classof => 2012},
  {:id => 2, :firstname => "John", :lastname => "Smith", :studentid => 10082, :classof => 2013},
  {:id => 3, :firstname => "Bobby", :lastname => "Tables", :studentid => 10082, :classof => 2014}  
])

templates = ComputerTemplate.create([
  {:name => "ACER Aspire One 532h", :parts => "Screen,Hard Drive,Shell,Battery,Hinges,Keyboard"},
  {:name => "HP Mini 2133", :parts => "Screen,Hard Drive,Shell,Battery,Hinges,Keyboard"}
])

computers = Computer.create([
  {:id => 1, :serial => "LUSAL0B1370114FD241601", :idtag => "ACERL16"},
  {:id => 2, :serial => "CNU8252V3S", :idtag => "HPL01" }
])

Computer.find(1).create_parts(ComputerTemplate.find(1))
Computer.find(2).create_parts(ComputerTemplate.find(2))

Computer.find(1).computer_ownerships.new(:student_id => 1, :startdate => Date.parse("2011-08-17"), :enddate => Date.parse("2012-05-31")).save
Computer.find(2).computer_ownerships.new(:student_id => 3, :startdate => Date.parse("2011-08-17"), :enddate => Date.parse("2012-05-31")).save
Computer.find(2).computer_ownerships.new(:student_id => 2, :startdate => Date.parse("2012-06-01"), :enddate => 1.month.from_now).save
