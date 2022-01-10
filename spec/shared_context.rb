# frozen_string_literal: true

RSpec.shared_context 'domains' do
  before(:all) do
  end

  after(:all) do
    str = 'Tested against '
    str += is_production? ? 'Production' : 'Integration'
    pp str
  end

  def is_production?
    return true if ENV['API'].nil? || ENV['API_STAGE'] == 'production'

    false
  end

  let(:get_service) do
    is_production? ? 'https://www.gov.uk/get-new-energy-certificate' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/find-an-energy-certificate.html'
  end

  let(:find_service) do
    is_production? ? 'https://www.gov.uk/find-energy-certificate' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/find-an-energy-certificate.html'
  end
end
