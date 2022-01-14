# frozen_string_literal: true

describe 'Find Domestic Certificate By RRN in English', journey: true do
  context 'when searching for a domestic certificate' do
    before do
      visit find_service
      click_on 'Start now'
      find('#label-domestic').click
      click_on 'Continue'
      click_on 'find an EPC by using its certificate number'
      fill_in 'reference_number', with: '9038-0010-6222-8839-5964'
      click_button 'Find'
    end

    it 'shows the certificate with the expected header' do
      expect(page).to have_content 'Energy performance certificate (EPC)'
    end
  end
end

describe 'Find Domestic Certificate By RRN in Welsh', type: :feature, journey: true do
  # TODO: When we have a Welsh homepage update this section to start there
  context 'when searching for a domestic certificate in Welsh' do
    before do
      visit 'https://find-energy-certificate.service.gov.uk/find-a-certificate/type-of-property?lang=cy'
      find('#label-domestic').click
      click_on 'Parhau'
      click_on 'chwilio am EPC drwy ddefnyddio rhif y dystysgrif'
      fill_in 'reference_number', with: '9038-0010-6222-8839-5964'
      click_button 'Chwiliwch'
    end

    it 'shows the certificate with the expected header' do
      expect(page).to have_content 'Tystysgrif perfformiad ynni (EPC)'
    end
  end
end
