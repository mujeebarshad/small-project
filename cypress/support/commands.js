// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

Cypress.Commands.add("seed", scenarios => {
  const commands = scenarios
    .map(scenario => {
      return `db:seed:development:${scenario}`;
    })
    .join(" ");
  cy.exec(`bin/rake db:seed:reset ${commands}`, { timeout: 20000 });
});

Cypress.Commands.add("login", (email, password) => {
  cy.request("post", "session_without_csrf", {
    session: {
      email: email,
      password: password
    }
  });
  cy.getCookie("remember_token").should("exist");
});

Cypress.Commands.add(
  "modalOpened",
  {
    prevSubject: true
  },
  subject => {
    cy.wrap(subject).should("have.class", "modal--display");
  }
);

Cypress.Commands.add(
  "modalOpenedAndLoaded",
  {
    prevSubject: true
  },
  subject => {
    cy.wrap(subject)
      .should("have.class", "modal--display")
      .within(() => {
        cy.get(".modal__content").should(
          "not.have.class",
          "modal__content--loading"
        );
      });
  }
);

Cypress.Commands.add("requestsCount", alias => {
  cy.wrap().then(
    () => cy.state("requests").filter(req => req.alias === alias).length
  );
});

Cypress.Commands.add("nativeScrollToBottom", (offset = 0) => {
  cy.window().then(win => {
    win.scrollTo(0, win.document.body.scrollHeight - offset);
  });
});
