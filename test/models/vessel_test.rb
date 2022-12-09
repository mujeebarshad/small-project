# frozen_string_literal: true

require "test_helper"

class VesselTest < ActiveSupport::TestCase
  def test_employment_is_invalid_when_name_is_blank
    v = Vessel.new
    v.valid?
    assert_includes v.errors.keys, :name
  end

  def test_vessel_is_invalid_without_organization
    vessel = Vessel.new
    vessel.valid?
    assert_includes vessel.errors.keys, :organization
  end

  def test_vessel_deleted_successfully_when_users_moved_to_new_vessel
    user = UserFactory.create(email: "duplicate_email@example.com")
    o = OrganizationFactory.create
    o.vessels.create(name: "Test1")
    o.vessels.create(name: "Test2")
    vessel = o.vessels.first
    target_vessel = o.vessels.last
    vessel.employments.create(user_id: user.id, organization_id: o.id)
    vessel.delete_vessel_and_move_users?(target_vessel)
    assert target_vessel.employments.count == 1
  end

  def test_vessel_deleted_successfully_when_users_not_moved
    user = UserFactory.create(email: "duplicate_email@example.com")
    o = OrganizationFactory.create
    o.vessels.create(name: "Test")
    vessel = o.vessels.first
    vessel.employments.create(user_id: user.id, organization_id: o.id)
    assert vessel.delete_vessel_and_move_users?(nil)
  end

  def test_vessel_cannot_be_deleted_when_target_vessel_is_same_as_deleting_vessel
    user = UserFactory.create(email: "duplicate_email@example.com")
    o = OrganizationFactory.create
    o.vessels.create(name: "Test")
    vessel = o.vessels.first
    target_vessel = o.vessels.first
    vessel.employments.create(user_id: user.id, organization_id: o.id)
    assert !vessel.delete_vessel_and_move_users?(target_vessel)
  end
end
