# frozen_string_literal: true

class Employment < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  belongs_to :vessel, optional: true

  validate :user_not_already_connected, on: :create, if: proc { |e| e.organization.present? }

  after_destroy :remove_user_roles

  attr_accessor :invite_message
  accepts_nested_attributes_for :user, update_only: true

  def user_attributes=(attributes)
    attributes = attributes.symbolize_keys
    if new_record? && attributes[:email].present? && (u = User.find_by_normalized_email(attributes[:email]))
      u.assign_attributes(attributes.except(:password))
      self.user = u
    else
      super(attributes)
    end
  end

  private

  def remove_user_roles
    user.roles.where(resource: organization).pluck(:name).each do |role|
      user.remove_role(role, organization)
    end
  end

  def user_not_already_connected
    return if organization.employments.where(user_id: user_id).blank?
    errors.add("user.email", "is already connected")
    user.errors&.add(:email, "is already connected")
  end
end
