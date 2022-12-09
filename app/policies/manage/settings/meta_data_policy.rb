# frozen_string_literal: true

module Manage
  module Settings
    class MetaDataPolicy < OrganizationScopedPolicy
      def edit?
        true
      end
    end
  end
end
