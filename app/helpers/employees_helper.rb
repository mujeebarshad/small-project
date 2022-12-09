# frozen_string_literal: true

module EmployeesHelper
  def employments_form_url(employment)
    if employment.persisted?
      manage_organization_employee_path(@organization, employment)
    else
      manage_organization_employees_path
    end
  end
end
