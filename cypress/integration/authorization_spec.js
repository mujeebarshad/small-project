describe("Authorization", () => {
  beforeEach(() => {
    cy.seed(["base"]);
  });

  it("users cannot see manage link", () => {
    cy.login("user@example.com", "password");
    cy.visit("/");
    cy.get("[data-cy=manage]").should("not.exist");
  });

  it("users cannot reach manage path", () => {
    cy.login("user@example.com", "password");
    cy.visit("/manage");
    cy.location("pathname").should("not.contain", "manage");
  });

  it("admin can see manage link", () => {
    cy.login("admin@example.com", "password");
    cy.visit("/");
    cy.get("[data-cy=manage]").should("exist");
  });

  it("admin can reach manage path", () => {
    cy.login("admin@example.com", "password");
    cy.visit("/manage");
    cy.location("pathname").should("contain", "manage");
  });
});
