# frozen_string_literal: true

module Manage
  module Settings
    class VesselsController < BaseController
      include OrganizationScoped

      def new
        @vessel = scope.build
        authorize([:manage, :settings, @vessel])
      end

      def create
        @vessel = scope.build(vessel_params)
        authorize([:manage, :settings, @vessel])

        if @vessel.save
          redirect_to edit_manage_organization_settings_meta_data_path, flash: { success: "Vessel added" }
        else
          render "new", flash: { danger: "There were issues adding the vessel" }
        end
      end

      def edit
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])
      end

      def update
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])

        if @vessel.update(vessel_params)
          redirect_to edit_manage_organization_settings_meta_data_path, flash: { success: "Vessel updated" }
        else
          render "edit", flash: { danger: "There were issues updating the vessel" }
        end
      end

      def destroy
        @vessel = scope.find(params[:id])
        authorize([:manage, :settings, @vessel])

        if @vessel.destroy
          redirect_back fallback_location: edit_manage_organization_settings_meta_data_path,
                        flash: { success: "Vessel removed!" }
        else
          render "edit", flash: { danger: "There were issues removing the vessel" }
        end
      end

      private

      def scope
        policy_scope([:manage, :settings, Vessel])
      end

      def vessel_params
        params.require(:vessel).permit(:id, :name)
      end
    end
  end
end
