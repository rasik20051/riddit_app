class User < ActiveRecord::Base

	before_validation :prep_email

	before_save :create_avatar_url
	attr_accessible :username,:email,:password,:password_confirmation,:avatar_url
	has_secure_password

	validates name, presence: true
	validates username, uniqueness: true, presence: true

	validates email, uniqueness: true, presence: true, format: {with: /^[\w.+-]+@([\w]+.)+\w+$/}

private

def prep_email

	self.email= self.email.strip.downcase if self.email
end

def create_avatar_url
gravatar_url= Digest::MD5.hexdigest(self.email)

self.avatar_url="http://gravatar.com/avatar#{gravatar_url(self.email)}?s=50"
	
end

end
