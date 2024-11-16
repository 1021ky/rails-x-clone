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
# typed: false
require 'rails_helper'

RSpec.describe XUser, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
