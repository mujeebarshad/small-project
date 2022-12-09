# frozen_string_literal: true

module Manage
  module Settings
    class OrganizationPolicy < OrganizationScopedPolicy
      def edit?
        true
      end

      def update?
        true
      end
    end
  end
end
