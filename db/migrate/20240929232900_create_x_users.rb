# typed: true

class CreateXUsers < ActiveRecord::Migration[6.1]
  def change
    # 登録したら基本的に変えないデータ
    create_table :x_users do |t|
      # メールアドレスかSSOのIDどちらかは必須
      t.string :email
      t.string :sso_provider
      t.string :sso_uid
      t.string :name, null: false
      # メールアドレスとパスワードのテーブルは別にする
      # SSOの情報とトークンのテーブルも別にする
      # 表示名やアイコンなど変更を許可する表示情報は別のテーブルにする
      # ユーザーの有効無効も別のテーブルにする

      t.timestamps # created_at, updated_atはデフォルトで作成される
    end

    add_index :x_users, :email, unique: true
    add_index :x_users, :sso_uid, unique: true
    add_index :x_users, :name, unique: true
  end
end
