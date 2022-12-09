# frozen_string_literal: true

require "test_helper"

class EmploymentTest < ActiveSupport::TestCase
  def test_employment_is_invalid_when_organization_is_blank
    e = Employment.new
    e.valid?
    assert_includes e.errors.keys, :organization
  end

  def test_employment_is_invalid_when_user_is_blank
    e = Employment.new
    e.valid?
    assert_includes e.errors.keys, :user
  end
end
