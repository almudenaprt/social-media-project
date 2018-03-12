class TweetTag < ApplicationRecord
  belongs_to :tweet_id
  belongs_to :tag_id
end
