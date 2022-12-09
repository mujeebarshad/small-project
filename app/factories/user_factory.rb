# frozen_string_literal: true

class UserFactory
  def self.build(attributes = {})
    User.new({
      email: "user_#{(Time.now.to_f * 1000).to_i}@example.com",
      password: "password"
    }.merge(attributes))
  end

  def self.create(attributes = {})
    build(attributes).tap(&:save!)
  end
end
