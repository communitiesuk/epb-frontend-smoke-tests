const { defineConfig } = require('cypress')

module.exports = defineConfig({
  chromeWebSecurity: false,
  env: {
    get_service_en_integration:
      'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/getting-a-new-energy-certificate.html',
    get_domain_integration: 'https://getting-new-energy-certificate-integration.london.cloudapps.digital/',
    get_service_en_production: 'https://www.gov.uk/get-new-energy-certificate',
    get_domain_production: 'https://getting-new-energy-certificate.service.gov.uk/',
    find_service_en_integration:
      'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/find-an-energy-certificate.html',
    find_domain_integration: 'https://find-energy-certificate-integration.london.cloudapps.digital/',
    find_service_en_production: 'https://www.gov.uk/find-energy-certificate',
    find_domain_production: 'https://find-energy-certificate.service.gov.uk/',
    get_service_cy_integration:
      'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/sicrhau-tystysgrif-ynni-newydd.html',
    get_service_cy_production: 'https://www.gov.uk/cael-tystysgrif-ynni-newydd',
    find_service_cy_integration:
      'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/chwiliwch-am-dystysgrif-ynni.html',
    find_service_cy_production:
      'https://www.gov.uk/dod-o-hyd-i-dystysgrif-ynni',
  },
  e2e: {
    // We've imported your old cypress plugins here.
    // You may want to clean this up later by importing these.
    setupNodeEvents(on, config) {
      return require('./cypress/plugins/index.js')(on, config)
    },
  },
  video: true,
  videoCompression: true,
})
