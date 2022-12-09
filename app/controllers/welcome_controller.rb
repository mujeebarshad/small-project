# frozen_string_literal: true

class WelcomeController < ApplicationController
  include StaticPage

  def show
    # Block welcome for authenticated users
    if current_user && current_user.roles.where.not(roles: { name: :super_admin }).any?
      redirect_to manage_root_path
    elsif current_user
      redirect_to home_path
    end
  end
end
