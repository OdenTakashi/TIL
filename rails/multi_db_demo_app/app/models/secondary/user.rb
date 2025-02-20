# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Secondary::User < SecondaryRecord
end
