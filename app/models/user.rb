class User < ActiveRecord::Base
	has_many :posts
	has_many :comments

	validates_uniqueness_of :username
	validates :email, confirmation: true, presence: true
	validates :password, confirmation: true, presence: true
	validates_presence_of :username, :fname, :lname, :email, :password, :country

	before_validation :ensure_login_has_a_value

	protected
	 def ensure_login_has_a_value
	 	if login.nil?
	 		self.login = email unless email.blank?
	 	end
	 end
end
