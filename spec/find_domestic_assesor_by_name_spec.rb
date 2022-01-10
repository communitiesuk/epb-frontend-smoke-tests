# frozen_string_literal: true

describe 'Find a Domestic Assessor English', journey: true do
  before do
    visit get_service
    click_on 'Start now'
    find('#label-domestic').click
    click_on 'Continue'
  end

  context 'when searching for an existing building by name' do
    before do
      find('#label-domesticRdSap').click
      click_on 'Continue'
      click_on 'find an assessor by name'
      fill_in 'name', with: 'Andrew Parkin'
      click_on 'Search'
    end

    it 'shows assessor search results' do
      expect(page).to have_content /results for the name Andrew Parkin/
    end
  end

  context 'when searching for new building by name' do
    before do
      find('#label-domesticSap').click
      click_on 'Continue'
      click_on 'find an assessor by name'
      fill_in 'name', with: 'Andrew Parkin'
      click_on 'Search'
    end

    it 'shows assessor search results' do
      expect(page).to have_content /results for the name Andrew Parkin/
    end
  end
end
