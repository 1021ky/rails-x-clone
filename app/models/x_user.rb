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
end
