# frozen_string_literal: true

describe 'Find Non-Domestic Certificate By Postcode in English', journey: true do
  context 'when searching for a domestic certificate' do
    before do
      visit 'https://www.gov.uk/find-energy-certificate'
      click_on 'Start now'
      find('#label-non-domestic').click
      click_on 'Continue'
      fill_in 'postcode', with: 'SW1A 2AA'
      click_button 'Find'
      click_on 'DEC', match: :first
    end

    it 'shows the certificate with the expected header' do
      expect(page).to have_content 'Display energy certificate (DEC)'
    end
  end
end

describe 'Find Non-Domestic Certificate By Postcode in Welsh', journey: true do
  # TODO: When we have a Welsh homepage update this section to start there
  context 'when searching for a domestic certificate in Welsh' do
    before do
      visit 'https://find-energy-certificate.service.gov.uk/find-a-certificate/type-of-property?lang=cy'
      find('#label-non-domestic').click
      click_on 'Parhau'
      fill_in 'postcode', with: 'SW1A 2AA'
      click_button 'Chwiliwch'
      click_on 'DEC', match: :first
    end

    it 'shows the certificate with the expected header' do
      expect(page).to have_content 'Tystysgrif ynni i’w harddangos (DEC)'
    end
  end
end
