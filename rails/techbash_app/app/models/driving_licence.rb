class DrivingLicence < ApplicationRecord
  belongs_to :user

  validate :must_be_adult

  def test_demo
    user = User.last
    binding.irb
    user.create_driving_licence!
  end

  private
  def must_be_adult
    return if user.adult?

    errors.add(:user, "成人でないと運転免許は取得できません。")
  end
end
