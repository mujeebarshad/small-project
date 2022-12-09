# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User
  rolify

  has_many :employments, dependent: :destroy

  validates_uniqueness_of :email, case_sensitive: false, allow_blank: false
  validates :email, presence: true
  validates :password, length: { minimum: 6 }

  def manages_organizations
    Organization.managed_by(self)
  end

  def full_name
    return email if first_name.blank? && last_name.blank?
    "#{first_name} #{last_name}"
  end
end
