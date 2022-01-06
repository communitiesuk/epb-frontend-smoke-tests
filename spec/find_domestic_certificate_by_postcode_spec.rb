# frozen_string_literal: true

describe 'Find Domestic Certificate By Postcode in English', type: :feature, journey: true do
  context 'when searching for a domestic certificate' do
    before do
      visit 'https://www.gov.uk/find-energy-certificate'
      click_on 'Start now'
      find('#label-domestic').click
      click_on 'Continue'
      fill_in 'postcode', with: 'HP17 0UZ'
      click_button 'Find'
      click_on '3 Gardeners Cottages,'
    end

    it 'shows the certificate with the expected header' do
      expect(page).to have_content 'Energy performance certificate (EPC)'
    end
  end
end

describe 'Find Domestic Certificate By Postcode in Welsh', type: :feature, journey: true do
  # TODO: When we have a Welsh homepage update this section to start there
  context 'when searching for a domestic certificate in Welsh' do
    before do
      visit 'https://find-energy-certificate.service.gov.uk/find-a-certificate/type-of-property?lang=cy'
      find('#label-domestic').click
      click_on 'Parhau'
      fill_in 'postcode', with: 'HP17 0UZ'
      click_button 'Chwiliwch'
      click_on '3 Gardeners Cottages,'
    end

    it 'shows the certificate with the expected header' do
      expect(page).to have_content 'Tystysgrif perfformiad ynni (EPC)'
    end
  end
end