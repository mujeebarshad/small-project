# frozen_string_literal: true

module Manage
  class ManagePolicy
    attr_reader :user

    def initialize(user, _record)
      @user = user
    end

    def show?
      user.manages_organizations.exists?
    end
  end
end
