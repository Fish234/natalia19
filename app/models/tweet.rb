class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

    def add_like(user)
      Like.create(user: user, tweet: self)
    end

    def remove_link(user)
      Like.where(user: user, tweet: self).first.destroy
    end

    def original_tweet
      Tweet.find(self.origin_tweet)
    end

    after_create do
      tweet = Tweet.find_by(id: self.id)
      # Extracting Hashtags
      hashtags = tweet.content.scan(/#\w+\b/)
      # Running a loop that adds each hashtag association to the PostTag table
      hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag)
        tweet.tags << tag
      end
    end
    after_update do
      tweet = Tweet.find_by(id: self.id)
      tweet.tags.clear
      # Extracting Hashtags
      hashtags = tweet.content.scan(/#\w+\b/)
      # Running a loop that adds each hashtag association to the PostTag table
      hashtags.uniq.map do |hashtag|
        tag = Tag.find_or_create_by(name: hashtag)
        tweet.tags << tag
      end
    end
end
