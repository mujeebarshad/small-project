# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  include Authorization

  helper_method :current_organization

  def current_organization
    organization = current_user&.manages_organizations&.find_by(id: session[:current_organization_id])
    organization = current_user&.manages_organizations&.first unless organization.present?
    organization
  end

  rescue_from Pundit::NotAuthorizedError do
    redirect_unauthorized
  end

  protected

  def redirect_unauthorized
    redirect_to request.referrer || root_path, flash: { danger: "You are not authorized to perform this action." }
  end
end
