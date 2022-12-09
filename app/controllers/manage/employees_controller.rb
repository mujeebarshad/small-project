# frozen_string_literal: true

module Manage
  class EmployeesController < BaseController
    include OrganizationScoped
    def index
      authorize([:manage, Employment])
      @employments = scope.paginate(page: params[:page], per_page: 20)

      respond_to do |format|
        format.html { render }
        format.js { render "manage/employees/infinite_scroll_index" }
      end
    end

    def edit
      @employment = scope.find(params[:id])
      authorize([:manage, @employment])
    end

    # rubocop:disable Metrics/AbcSize
    def update
      @employment = scope.includes(EMPLOYMENT_ROW_INCLUDES).find(params[:id])
      authorize([:manage, @employment])

      if @employment.update(employment_params)
        respond_to do |format|
          format.html do
            flash[:success] = "Employee updated!"
            redirect_back fallback_location: manage_organization_employees_path
          end
          format.js do
            @certificate_count = CourseCompletion.where(user_id: @employment.user_id)
                                                 .group(:user_id).count
            @tab_index = 1
            render :update
          end
        end
      else
        @tab_index = 1
        @editing = true
        render :edit
      end
    end
    # rubocop:enable Metrics/AbcSize

    def new
      @employment = scope.build
      @employment.build_user
      authorize([:manage, @employment])
    end

    def create
      @employment = scope.build(employment_params)
      authorize([:manage, @employment])
      @employment.user.password = Clearance::Token.new

      if @employment.save
        flash[:success] = "Employee added!"
        redirect_to manage_organization_employees_path
      else
        render :new
      end
    end

    def destroy
      @employment = scope.find(params[:id])
      authorize([:manage, @employment])

      if @employment.destroy
        flash[:success] = "Employee removed!"
        redirect_back fallback_location: manage_organization_employees_path
      else
        flash[:danger] = "There were issues removing the user"
        render :edit
      end
    end

    private

    def scope
      policy_scope([:manage, Employment])
    end

    def employment_params
      params.require(:employment).permit(:id, :external_id, :vessel_id, :position_id,
                                         :increase_licenses_if_full, :invite_message,
                                         user_attributes: %i[id email first_name last_name password])
    end

    def filtering_params
      return {} if params[:filter].blank?
      params[:filter].slice(:search, :position, :vessel)
    end
  end
end
