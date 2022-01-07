# frozen_string_literal: true

RSpec.shared_context 'domains' do
  before(:all) do
  end

  def is_production?
    if ENV['REMOTE_STAGE'].nil? || ENV['REMOTE_STAGE'] == 'production'
      true
    else
      false
    end
  end

  let(:get_service) do
    is_production? ? 'https://www.gov.uk/get-new-energy-certificate' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/find-an-energy-certificate.html'
  end

  let(:find_service) do
    is_production? ? 'https://www.gov.uk/find-energy-certificate' : 'https://mhclg-epb-static-start-pages-integration.london.cloudapps.digital/find-an-energy-certificate.html'
  end
end
