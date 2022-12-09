# frozen_string_literal: true

class ShowManagePolicy < ApplicationPolicy
  def show?
    return false if user.blank?
    user.manages_organizations.exists?
  end
end
