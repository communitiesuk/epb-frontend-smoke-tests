# frozen_string_literal: true

describe 'Ensure redirects work', journey: true do
  context 'for find a certificate' do
    before do
      visit 'https://find-energy-certificate.digital.communities.gov.uk/'
    end

    it 'redirects to the gov page' do
      expect(page).to have_content 'Find an energy certificate'
    end
  end

  context 'for getting a new certificate' do
    before do
      visit 'https://getting-new-energy-certificate.digital.communities.gov.uk/'
    end

    it 'redirects to the gov page' do
      expect(page).to have_content 'Get a new energy certificate'
    end
  end
end