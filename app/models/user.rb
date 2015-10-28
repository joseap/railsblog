class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments

	attr_accessor :password_salt
	attr_accessor :password_hash

	validates_uniqueness_of :username
	validates :email, confirmation: true, presence: true
	validates :password, confirmation: true, presence: true, length: { minimum: 5 }
	validates_presence_of :username, :fname, :lname, :email, :password, :country, :avatar

	before_validation :ensure_username_has_a_value
	before_validation :normalize_username, on: :create

	before_save :encrypt_password


	# PAPERCLIP 
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png" 
	
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	protected
	 def ensure_username_has_a_value
	 	if username.nil?
	 		self.username = email unless email.blank?
	 	end
	 end

	 def encrypt_password
	 	  if password.present?
     		 self.password_salt = BCrypt::Engine.generate_salt
     		 self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
 		 end
	 end

	 def normalize_username
      self.username = self.username.downcase.titleize
    end
end
