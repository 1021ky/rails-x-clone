# == Schema Information
#
# Table name: x_users
#
#  id           :bigint           not null, primary key
#  email        :string
#  sso_provider :string
#  sso_uid      :string
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# typed: strict

class XUser < ApplicationRecord
  # https://railstutorial.jp/chapters/modeling_users?version=7.0#sec-database_migrations を参照
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, precence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX },
                    uniquness: { case_sensitice: false }
  # TODO: https://railstutorial.jp/chapters/modeling_users?version=7.0#sec-database_migrations　を参照しながら、バリデーションとパスワード保存をできるように
end
