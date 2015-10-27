class User < ActiveRecord::Base
	has_many :posts
	has_many :comments

	validates_uniqueness_of :username
	validates :email, confirmation: true, presence: true
	validates :password, confirmation: true, presence: true
	validates_presence_of :username, :fname, :lname, :email, :password, :country

	before_validation :ensure_username_has_a_value
	before_validation :normalize_username, on: :create

	protected
	 def ensure_username_has_a_value
	 	if username.nil?
	 		self.username = email unless email.blank?
	 	end
	 end

	 def normalize_username
      self.username = self.username.downcase.titleize
    end
end
