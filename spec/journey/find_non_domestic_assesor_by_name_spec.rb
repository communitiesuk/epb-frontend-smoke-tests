# frozen_string_literal: true

describe 'Find a Non Domestic Assessor English', journey: true do
  before do
    visit get_service
    click_on 'Start now'
    find('#label-non-domestic').click
    click_on 'Continue'
  end

  context 'when searching by name' do
    before do
      click_on 'find an assessor by name'
      fill_in 'name', with: 'Andrew Parkin'
      click_on 'Search'
    end

    it 'shows assessor search results' do
      expect(page).to have_content /results for the name Andrew Parkin/
    end
  end
end
