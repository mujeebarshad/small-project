describe("Sessions", () => {
  it("login with correct credentials", () => {
    cy.seed(["base"]);
    cy.visit("/session/new");
    cy.get("[data-cy=email]").type("user@example.com");
    cy.get("[data-cy=password]").type("password");
    cy.get("[data-cy=signin]").click();
    cy.location("pathname").should("eq", "/home");
    cy.get("[data-cy=sign-out]");
  });

  it("login with incorrect email", () => {
    cy.seed(["base"]);
    cy.visit("/session/new");
    cy.get("[data-cy=email]").type("foobar@example.com");
    cy.get("[data-cy=password]").type("password");
    cy.get("[data-cy=signin]").click();
    cy.location("pathname").should("eq", "/session");
  });

  it("login with incorrect password", () => {
    cy.seed(["base"]);
    cy.visit("/session/new");
    cy.get("[data-cy=email]").type("user@example.com");
    cy.get("[data-cy=password]").type("foobar");
    cy.get("[data-cy=signin]").click();
    cy.location("pathname").should("eq", "/session");
  });

  it("logout", () => {
    cy.seed(["base"]);
    cy.visit("/session/new");
    cy.get("[data-cy=email]").type("user@example.com");
    cy.get("[data-cy=password]").type("password");
    cy.get("[data-cy=signin]").click();
    cy.get("[data-cy=sign-out]").click();
    cy.location("pathname").should("eq", "/sign_in");
    cy.get("[data-cy=sign-out]").should("not.exist");
  });

  it("login with email", () => {
    cy.seed(["base"]);
    cy.visit("/");
    cy.get("[data-cy=sign-in]").click();
    cy.get("[data-cy=email]").type("user@example.com");
    cy.get("[data-cy=password]").type("password");
    cy.get("[data-cy=signin]").click();
  });

  it("login with missing email", () => {
    cy.seed(["base"]);
    cy.visit("/");
    cy.get("[data-cy=sign-in]").click();
    cy.get("[data-cy=email]").type("missing@example.com");
    cy.get("[data-cy=signin]").click();
    cy.contains("Password is incorrect");
  });
});
