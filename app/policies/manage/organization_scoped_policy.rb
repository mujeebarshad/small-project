# frozen_string_literal: true

module Manage
  class OrganizationScopedPolicy
    attr_reader :organization, :user, :record

    def initialize(context, record)
      @organization = context.first
      @user = context.last
      @record = record.last

      raise Pundit::NotAuthorizedError unless can_manage_organization?
    end

    class Scope
      attr_reader :organization, :user, :scope

      def initialize(context, scope_array)
        @organization = context.first
        @user = context.last
        @scope = scope_array.last
      end

      def resolve
        scope.where(organization_id: organization.id)
      end
    end

    protected

    def can_manage_organization?
      organization.administrators.include?(user)
    end

    def can_manage_record?
      record.organization_id == organization.id
    end
  end
end
