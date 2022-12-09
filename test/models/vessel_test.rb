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

end
