class User < ApplicationRecord
  has_one :driving_licence

  ADULT_AGE = 18

  def adult?
    age >= ADULT_AGE
  end
end
