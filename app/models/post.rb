class Post < ActiveRecord::Base
	belongs_to :user # 'belongs to' will be table with foreign key user_id
	validates_presence_of :content
end
