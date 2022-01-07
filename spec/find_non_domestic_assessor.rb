# frozen_string_literal: true

describe 'Find a Non Domestic Assessor in English', journey: true do
  before do
    visit 'https://www.gov.uk/get-new-energy-certificate'
    click_on 'Start now'
    find('#label-non-domestic').click
    click_on 'Continue'
    fill_in 'postcode', with: 'SW1A 2AA'
    click_on 'Find'
  end

  it 'shows assessor search results' do
    expect(page).to have_content /assessors in order of distance from SW1A 2AA/
  end
end

describe 'Find a Non Domestic Assessor in Welsh', journey: true do
  before do
    visit 'https://getting-new-energy-certificate.service.gov.uk/find-an-assessor/type-of-property?lang=cy'
    find('#label-non-domestic').click
    click_on 'Parhau'
    fill_in 'postcode', with: 'SW1A 2AA'
    click_on 'Chwiliwch'
  end

  it 'shows assessor search results' do
    expect(page).to have_content /aseswyr yn nhrefn eu pellter o SW1A 2AA/
  end
end
