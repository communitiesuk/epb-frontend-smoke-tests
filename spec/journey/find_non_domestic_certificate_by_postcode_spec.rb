# frozen_string_literal: true

describe 'Find Non-Dom EPC By Postcode in English', journey: true do
  context 'when searching for a domestic certificate' do
    before do
      visit find_service
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

describe 'Find Non-Dom EPC By Postcode in Welsh', journey: true do
  context 'when searching for a domestic certificate in Welsh' do
    before do
      visit find_service_welsh
      click_on 'Dechrau nawr'
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
