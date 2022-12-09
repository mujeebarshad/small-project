# frozen_string_literal: true

class SessionsController < Clearance::SessionsController
  skip_before_action :verify_authenticity_token, only: :create_without_csrf

  def new
    @user ||= User.new
    super
  end

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or home_path
      else
        # Make sure there is some error message to the user.
        @user ||= User.new
        @user&.errors&.add(:password, "is incorrect")

        flash.now.notice = status.failure_message
        render template: "sessions/new", status: :unauthorized
      end
    end
  end

  def create_without_csrf
    @user = authenticate(params)
    sign_in(@user)
  end
end
