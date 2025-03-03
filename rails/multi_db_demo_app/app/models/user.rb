# == Schema Information
# Schema version: 20250301020209#
# Table name: users
#
#  id         :integer          not null, primary key
#  height     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
end
