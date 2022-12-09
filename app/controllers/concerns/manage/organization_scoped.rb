# frozen_string_literal: true

module Manage
  module OrganizationScoped
    extend ActiveSupport::Concern

    included do
      before_action :set_organization
    end

    def pundit_user
      [@organization, current_user]
    end

    private

    def set_organization
      @organization = Organization.find(params[:organization_id])
      session[:current_organization_id] = @organization.id unless session[:current_organization_id] == @organization.id
    end
  end
end
