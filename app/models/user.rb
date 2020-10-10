class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes
  has_many :active_relationships, class_name: 'Friiiend', foreign_key: 'user_id', inverse_of: :follower, dependent: :destroy
  has_many :passive_relationships, class_name: 'Friiiend', foreign_key: 'follower_id', inverse_of: :following, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  #has_many :followers, :class_name => "Friiiend", :foreign_key => "user_id"
  #has_many :following, :class_name => "Friiiend", :foreign_key => "follower_id"
  def to_s
    name
  end
  def tweets_for_me
    Tweet.where(user_id: id).or(Tweet.where(user_id: active_relationships.select(:follower_id)))
  end
  def following?(other_user)
    active_relationships.find_by(follower_id: other_user.id)
  end
  def unfollow!(other_user)
    active_relationships.find_by(follower_id: other_user.id).destroy!
  end
end

