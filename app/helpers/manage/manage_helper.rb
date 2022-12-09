# frozen_string_literal: true

module Manage
  module ManageHelper
    def organization_manage_root_path(organization = current_organization)
      manage_organization_employees_path(organization)
    end
  end
end
