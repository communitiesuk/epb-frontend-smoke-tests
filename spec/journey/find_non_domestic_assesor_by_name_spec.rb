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

describe 'Find a Non Domestic Assessor Welsh', journey: true do
  before do
    visit get_service_welsh
    click_on 'Dechrau nawr'
    find('#label-non-domestic').click
    click_on 'Parhau'
  end

  context 'when searching for an assessor by name' do
    before do
      click_on 'chwilio am asesydd yn ôl enw'
      fill_in 'name', with: 'Andrew Parkin'
      click_on 'Chwiliwch'
    end

    it 'shows assessor search results' do
      expect(page).to have_content /canlyniadau ar gyfer yr enw Andrew Parkin/
    end
  end
end
