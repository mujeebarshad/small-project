# frozen_string_literal: true

module Manage
  module Settings
    class MetaDataController < BaseController
      include OrganizationScoped

      def edit
        authorize(%i[manage settings meta_data])
        @vessels = policy_scope([:manage, :settings, Vessel]).by_name
      end
    end
  end
end
