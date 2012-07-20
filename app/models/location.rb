class Location < ActiveRecord::Base
  attr_accessible :name

  has_many :computers

  validates_presence_of :name
end
