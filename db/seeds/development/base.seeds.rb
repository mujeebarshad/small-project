# frozen_string_literal: true

admin = UserFactory.create(
  email: "admin@example.com",
  password: "password",
  first_name: "Admin",
  last_name: "Example"
)

UserFactory.create(
  email: "user@example.com",
  password: "password",
  first_name: "User",
  last_name: "Example"
)

organization = OrganizationFactory.create(name: "Organization")
organization.employees << admin
admin.add_role(:admin, organization)

organization.employments.first.update(vessel: organization.vessels.create(name: "M/S Freja"))
organization.vessels.create(name: "M/S Remmer Line")
