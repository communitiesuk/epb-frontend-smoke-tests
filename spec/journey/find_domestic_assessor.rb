# frozen_string_literal: true

describe 'Find a Domestic Assessor in English', journey: true do
  before do
    visit get_service
    click_on 'Start now'
    find('#label-domestic').click
    click_on 'Continue'
  end

  context 'when searching for an assessor' do
    before do
      find('#label-domesticRdSap').click
      click_on 'Continue'
      fill_in 'postcode', with: 'SW1A 2AA'
      click_on 'Find'
    end

    it 'shows assessor search results' do
      expect(page).to have_content /assessors in order of distance from SW1A 2AA/
    end
  end
end

describe 'Find a Domestic Assessor in Welsh', journey: true do
  before do
    visit get_service_welsh
    click_on 'Dechrau nawr'
    find('#label-domestic').click
    click_on 'Parhau'
  end

  context 'when searching for an assessor' do
    before do
      find('#label-domesticRdSap').click
      click_on 'Parhau'
      fill_in 'postcode', with: 'SW1A 2AA'
      click_on 'Chwiliwch'
    end

    it 'shows assessor search results' do
      expect(page).to have_content /aseswyr yn nhrefn eu pellter o SW1A 2AA/
    end
  end
end
