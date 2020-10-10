class Tag < ApplicationRecord
    has_many :taggings
    has_many :tweets, through: :taggings
end
