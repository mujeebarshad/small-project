# frozen_string_literal: true

module Manage
  class BaseController < ApplicationController
    before_action :require_login
    after_action :verify_authorized
    after_action :verify_policy_scoped
  end
end
