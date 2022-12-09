# frozen_string_literal: true

require "test_helper"

class OrganizationTest < ActiveSupport::TestCase
  def test_all_employments_removed_when_organization_is_removed
    u = UserFactory.create
    o = OrganizationFactory.create
    o.employments.create(user: u)

    assert o.employments.present?
    o.destroy
    assert_equal Employment.where(organization_id: o.id).count, 0
    assert User.find(u.id)
  end

  def test_all_vessels_removed_when_organization_is_removed
    o = OrganizationFactory.create
    o.vessels.create(name: "Test")

    assert o.vessels.present?
    o.destroy
    assert_equal Vessel.where(organization_id: o.id).count, 0
  end
end
