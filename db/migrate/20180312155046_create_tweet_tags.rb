class CreateTweetTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tweet_tags do |t|
      t.references :tweet_id, foreign_key: true
      t.references :tag_id, foreign_key: true

      t.timestamps
    end
  end
end
