# frozen_string_literal: true

describe 'Find Domestic Certificate By Postcode', journey: true do
  before do
    visit 'https://www.gov.uk/find-energy-certificate'
    click_on 'Start now'
  end

  context 'when searching for a domestic certificate' do
    it 'returns page with expected content' do
      expect(page).to have_content 'What type of property is the certificate for?'
    end
  end

  context 'with a postcode for which certificates exist' do
    before do
      find('#label-domestic').click
      click_on 'Continue'
      fill_in 'postcode', with: 'HP17 0UZ'
      click_button 'Find'
    end

    it 'shows existence of those certificates on the search results page' do
      expect(page).to have_content /EPCs for HP17 0UZ/
    end

    context 'when selecting a known certificate from the results list' do
      before do
        click_on '3 Gardeners Cottages,'
      end

      it 'shows the certificate with the expected header' do
        expect(page).to have_content 'Energy performance certificate (EPC)'
      end
    end
  end
end
