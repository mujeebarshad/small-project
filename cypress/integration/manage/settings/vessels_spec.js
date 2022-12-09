describe("Manage > Settings > Vessels", () => {
  beforeEach(() => {
    cy.seed(["base"]);
    cy.login("admin@example.com", "password");
    cy.visit("/manage/organizations/1/settings/meta_data/edit");
  });

  it("show the list of vessels", () => {
    cy.get("[data-cy=vessel-1]");
  });

  it("add a new vessel", () => {
    cy.get("[data-cy=vessel-3]").should("not.exist");
    cy.get("[data-cy=add-vessel]").click();
    cy.get("[data-cy=name]").type("{selectall}A new vessel");
    cy.get("[data-cy=vessel-submit]").click();
    cy.get("[data-cy=vessel-3]");
  });

  it("edit an existing vessel", () => {
    cy.get("[data-cy=vessel-1-edit]").click();
    cy.get("[data-cy=name]").type("{selectall}An updated vessel");
    cy.get("[data-cy=vessel-submit]").click();
    cy.get(".modal").should("not.be.visible", { log: false });
    cy.get("[data-cy=vessel-1]").contains("An updated vessel");
  });

});
