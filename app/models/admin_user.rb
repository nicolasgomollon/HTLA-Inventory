class AdminUser < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :password, :username, :fullname
  has_secure_password

  before_save :create_remember_token

  validates :password, :presence => { :on => :create }
  validates :username, :presence => true, :uniqueness => true
  validates :fullname, :presence => true

  private
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
	end
end
