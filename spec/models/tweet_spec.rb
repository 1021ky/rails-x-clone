# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  content    :string
#  x_user_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
