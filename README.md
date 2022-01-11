EPB Frontend Smoke Tests
===================

This is a collection of rspec with Capybara tests, using Chrome to access the live application.

## Getting Started

Make sure you have the following installed:

* [Ruby](https://www.ruby-lang.org) Version 3.0.3
    * [Bundler](https://bundler.io) to install dependencies found in `Gemfile`
* [Git](https://git-scm.com) (_optional_)

Run Test
Journey test are run using Capybara on the Production front end instance.
To run the test suite use the cmd

`make test`

to run the test suite against integration set the ENV variable 'API_STAGE' to be anything other than production and re run make test e.g.

      API_STAGE=integration
      make test