# frozen_string_literal: true

module Manage
  class EmploymentPolicy < OrganizationScopedPolicy
    def index?
      can_manage_organization?
    end

    def new?
      can_manage_record?
    end

    def create?
      can_manage_record?
    end

    def edit?
      can_manage_record?
    end

    def update?
      can_manage_record?
    end

    def destroy?
      can_manage_record?
    end
  end
end
