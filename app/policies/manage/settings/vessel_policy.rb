# frozen_string_literal: true

module Manage
  module Settings
    class VesselPolicy < OrganizationScopedPolicy
      def new?
        true
      end

      def create?
        true
      end

      def edit?
        true
      end

      def update?
        true
      end

      def destroy?
        true
      end

      def move_users_to_vessel_modal?
        true
      end
    end
  end
end
