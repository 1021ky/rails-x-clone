#
# Tweetsテーブル追加
#
class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :content
      t.references :x_user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
