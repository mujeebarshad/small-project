# frozen_string_literal: true

module Manage
  class ManageController < BaseController
    before_action :skip_policy_scope

    def show
      authorize %i[manage manage]
      redirect_to helpers.organization_manage_root_path
    end
  end
end
