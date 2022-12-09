describe("Manage > Settings > General", () => {
  beforeEach(() => {
    cy.seed(["base"]);
    cy.login("admin@example.com", "password");
    cy.visit("/manage/organizations/1/settings/organization/edit");
  });

  it("change the organization name", () => {
    cy.get("[data-cy=name]").type("{selectall}An updated name");
    cy.get("[data-cy=save-name]").click();
    cy.reload();
    cy.get("[data-cy=name]").should("have.value", "An updated name");
  });
});
