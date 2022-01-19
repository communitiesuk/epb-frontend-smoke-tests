# frozen_string_literal: true

describe 'Find Non-Domestic Certificate By street and town in English', journey: true do
  context 'when searching for a domestic certificate' do
    before do
      visit find_service
      click_on 'Start now'
      find('#label-non-domestic').click
      click_on 'Continue'
      click_on 'find energy certificates and reports using the street name and town'
      fill_in 'street_name', with: 'Prime Minister & First Lord of the Treasury'
      fill_in 'town', with: 'London'
      click_button 'Find'
      click_on 'DEC', match: :first
    end

    xit 'shows the certificate with the expected header' do
      expect(page).to have_content 'Display energy certificate (DEC)'
    end
  end
end

describe 'Find Non-Domestic Certificate By street and town in Welsh', journey: true do
  context 'when searching for a domestic certificate in Welsh' do
    before do
      visit find_service_welsh
      click_on 'Dechrau nawr'
      find('#label-non-domestic').click
      click_on 'Parhau'
      click_on 'chwiliwch am dystysgrifau perfformiad ynni drwy ddefnyddio enw’r stryd a’r dref'
      fill_in 'street_name', with: 'Prime Minister & First Lord of the Treasury'
      fill_in 'town', with: 'London'
      click_button 'Chwiliwch'
      click_on 'DEC', match: :first
    end

    xit 'shows the certificate with the expected header' do
      expect(page).to have_content 'Tystysgrif ynni i’w harddangos (DEC)'
    end
  end
end
