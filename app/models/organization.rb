# frozen_string_literal: true

class Organization < ApplicationRecord
  resourcify # Used by rolify to keep track of which models can be used in roles

  ADMINISTRATOR_ROLES = %i[admin manager].freeze

  has_many :vessels, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :employees, through: :employments, source: :user

  attr_accessor :contact_person

  class << self
    def managed_by(user)
      Organization.with_roles(ADMINISTRATOR_ROLES.map(&:to_s), user)
    end

    def administrators
      User.joins(:roles).where(roles: { resource_type: "Organization", name: ADMINISTRATOR_ROLES }).distinct
    end
  end

  def administrators
    self.class.administrators.where(roles: { resource_id: id })
  end
end
