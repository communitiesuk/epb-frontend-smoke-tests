# frozen_string_literal: true

describe 'Find Domestic Certificate By street and town in English', journey: true do
  context 'when searching for a domestic certificate' do
    before do
      visit find_service
      click_on 'Start now'
      find('#label-domestic').click
      click_on 'Continue'
      click_on 'find an EPC using the street name and town'
      fill_in 'street_name', with: 'Bamburgh Castle'
      fill_in 'town', with: 'Bamburgh'
      click_button 'Find'
      click_on 'The Keep'
    end

    xit 'shows the certificate with the expected header' do
      expect(page).to have_content 'Energy performance certificate (EPC)'
    end
  end
end

describe 'Find Domestic Certificate By street and town in Welsh', type: :feature, journey: true do
  context 'when searching for a domestic certificate in Welsh' do
    before do
      visit find_service_welsh
      click_on 'Dechrau nawr'
      find('#label-domestic').click
      click_on 'Parhau'
      click_on 'chwiliwch am EPC drwy ddefnyddio enw’r stryd a’r dref'
      fill_in 'street_name', with: 'Bamburgh Castle'
      fill_in 'town', with: 'Bamburgh'
      click_button 'Chwiliwch'
      click_on 'The Keep'
    end

    xit 'shows the certificate with the expected header' do
      expect(page).to have_content 'Tystysgrif perfformiad ynni (EPC)'
    end
  end
end
