# frozen_string_literal: true

RSpec.shared_context 'domains' do
  before(:all) do
    # WebMock.disable!
  end

  after(:all) do
    str = 'Tested against '
    str += is_production? ? 'Production' : 'Integration'
    pp str
  end

  def is_production?
    return true if ENV['API_STAGE'].nil? || ENV['API_STAGE'] == 'production'

    false
  end

  let(:get_service) do
    is_production? ? 'https://www.gov.uk/get-new-energy-certificate?smoke-test=true' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/getting-a-new-energy-certificate.html'
  end

  let(:find_service) do
    is_production? ? 'https://www.gov.uk/find-energy-certificate?smoke-test=true' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/find-an-energy-certificate.html'
  end

  let(:get_service_welsh) do
    is_production? ? 'https://www.gov.uk/cael-tystysgrif-ynni-newydd' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/sicrhau-tystysgrif-ynni-newydd.html'
  end

  let(:find_service_welsh) do
    is_production? ? 'https://www.gov.uk/dod-o-hyd-i-dystysgrif-ynni' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/chwiliwch-am-dystysgrif-ynni.html'
  end
end
