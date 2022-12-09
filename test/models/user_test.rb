# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def test_user_is_invalid_when_email_is_blank
    u = UserFactory.build(email: nil)
    u.valid?
    assert_includes u.errors.keys, :email
  end

  def test_user_is_invalid_when_password_is_blank
    u = UserFactory.build(password: nil)
    u.valid?
    assert_includes u.errors.keys, :password
  end

  def test_user_is_invalid_when_email_is_taken
    UserFactory.create(email: "duplicate_email@example.com")
    u = UserFactory.build(email: "duplicate_email@example.com")
    u.valid?
    assert_includes u.errors.keys, :email
    assert_includes u.errors.details[:email].map { |error| error[:error] }, :taken
  end

  def test_password_validates_length
    u = UserFactory.create(password: ">sixletter")
    u.password = "new"
    u.valid?
    assert_includes u.errors.keys, :password
    u.password = "letter"
    u.valid?
    assert_not_includes u.errors.keys, :password
  end

  def test_user_can_change_password
    u = UserFactory.create
    u.password = "new-password"
    assert u.valid?
  end

  def test_user_can_change_email
    u = UserFactory.create
    u.email = "new@email.com"
    assert u.valid?
  end

  def test_all_employments_removed_when_user_is_removed
    u = UserFactory.create
    o = OrganizationFactory.create
    o.employments.create(user: u)

    assert u.employments.present?
    u.destroy
    assert_equal Employment.where(user_id: u.id).count, 0
  end
end
