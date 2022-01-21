# frozen_string_literal: true

describe 'Find EPC By Postcode', journey: true do
  context 'with a postcode for which certificates exist' do
    before do
      visit find_service
      click_on 'Start now'
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

describe 'Find EPC By Postcode in Welsh', journey: true do
  context 'with a postcode for which certificates exist' do
    before do
      visit find_service_welsh
      click_on 'Dechrau nawr'
      find('#label-domestic').click
      click_on 'Parhau'
      fill_in 'postcode', with: 'HP17 0UZ'
      click_button 'Chwiliwch'
    end

    it 'shows existence of those certificates on the search results page' do
      expect(page).to have_content /EPCs ar gyfer HP17 0UZ/
    end

    context 'when selecting a known certificate from the results list' do
      before do
        click_on '3 Gardeners Cottages,'
      end

      it 'shows the certificate with the expected header' do
        expect(page).to have_content 'Tystysgrif perfformiad ynni (EPC)'
      end
    end
  end
end
