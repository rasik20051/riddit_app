class Relationship < ActiveRecord::Base

	belongs_to :follower,classname: "user"
	belongs_to :followed,classname: "User"
end
