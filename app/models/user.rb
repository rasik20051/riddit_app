class User < ActiveRecord::Base


	before_validation :prep_email

	before_save :create_avatar_url

	has_many :ribbits
	has_many :followers ,through :follower_relationships
	has_many :followeds, through :followed_relationships

	attr_accessible :avatar_url, :email, :name , :password, :password_confirmation, :username

	has_secure_password

	validates :name, presence: true
	validates :username, uniqueness: true, presence: true

	validates :email, uniqueness: true, presence: true, format: {with: /^[\w.+-]+@([\w]+.)+\w+$/,
		multiline: true}

def following? user
	self.followeds.include? user
end

def follow user
	Relationship.create follower_id: self.id,followed_id: user.id
end

private

def prep_email

	self.email= self.email.strip.downcase if self.email
end

def create_avatar_url
gravatar_url= Digest::MD5.hexdigest(self.email)

self.avatar_url="http://gravatar.com/avatar#{gravatar_url(self.email)}?s=50"
	
end

end
