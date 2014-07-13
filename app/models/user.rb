class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  validates_presence_of :handle
  validates_uniqueness_of :handle
 
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
 
  has_many :followers, through: :reverse_relationships, source: :follower

  def following?(other_user)
  	self.relationships.find_by(follower_id: other_user.id)
  end

  def follow!(other_user)
  	self.relationships.create!(followed_id: other_user.id)
  end 
  def unfollow!(other_user)
  	self.relationships.find_by(follow_id: other_use.id).destroy
  end 
end
