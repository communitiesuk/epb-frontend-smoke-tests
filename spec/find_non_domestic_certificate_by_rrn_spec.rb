# frozen_string_literal: true

describe 'Find Non-Domestic Certificate By RRN in English', journey: true do
  context 'when searching for a domestic certificate' do
    before do
      visit 'https://www.gov.uk/find-energy-certificate'
      click_on 'Start now'
      find('#label-non-domestic').click
      click_on 'Continue'
      click_on 'find a certificate by using its certificate number'
      fill_in 'reference_number', with: '0060-8260-7119-7386-8570'
      click_button 'Find'
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
      click_on 'chwilio am dystysgrif drwy ddefnyddio’i rhif tystysgrif'
      fill_in 'reference_number', with: '0060-8260-7119-7386-8570'
      click_button 'Chwiliwch'
    end

    it 'shows the certificate with the expected header' do
      expect(page).to have_content 'Tystysgrif ynni i’w harddangos (DEC)'
    end
  end
end
