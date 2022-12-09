# frozen_string_literal: true

module Manage
  module Settings
    class OrganizationsController < BaseController
      include OrganizationScoped
      before_action :skip_policy_scope

      def edit
        authorize([:manage, :settings, @organization])
      end

      def update
        authorize([:manage, :settings, @organization])

        if @organization.update(setting_attributes)
          redirect_to url_for(action: :edit), flash: { success: "Settings saved" }
        else
          render :edit, flash: { danger: "There were issues saving your settings" }
        end
      end

      private

      def setting_attributes
        params.require(:organization).permit(:name, :bio, :web_url, :facebook_url, :twitter_url,
                                             :linkedin_url, :private_profile, :no_index,
                                             avatar_attributes: %i[original edited editor_state])
      end
    end
  end
end
