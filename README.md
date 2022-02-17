EPB Frontend Smoke Tests
===================

This is a collection of [Cypress](https://www.cypress.io) tests, with a GitHub Action workflow to run them on a schedule and notify the EPBR team on any failure (via Slack and a [custom action](https://github.com/communitiesuk/epb-post-cypress-failures-to-slack)).

## Running the tests

Run `npm ci` to install dependencies locally.

Run `npm run test` to run the whole test suite against production (using headless [Electron](https://www.electronjs.org)). (NB. These may execute fast enough to trigger the DDoS protection on the live app and lead to test failures because of this. To run the tests slowly enough not to trigger this condition, use `npm run test-with-delay`.)

While working on the tests, it's advised to use the Cypress dashboard app on your machine, which can be run using `npx cypress open`.

Consult the [Cypress docs](https://docs.cypress.io/) for Cypress testing syntax and examples.

### Running tests against the Integration environment

Run `CYPRESS_API_STAGE=integration npm run test-with-delay`.
