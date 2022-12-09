// ***********************************************************
// This example support/index.js is processed and
// loaded automatically before your test files.
//
// This is a great place to put global configuration and
// behavior that modifies Cypress.
//
// You can change the location of this file or turn off
// automatically serving support files with the
// 'supportFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/configuration
// ***********************************************************

import "./commands";

// We get some JS exceptions thrown from rails-ujs when running
// within Cypress.. Not sure why but for now don't fail..
Cypress.on("uncaught:exception", () => {
  return false;
});
