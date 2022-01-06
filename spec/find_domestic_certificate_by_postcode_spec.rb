# frozen_string_literal: true

describe "Find Domestic Certificate By Postcode", type: :feature, journey: true do

  context "when searching for a domestic certificate" do
    before do
      visit "https://www.gov.uk/find-energy-certificate"
      click_on "Start now"
    end

      it "returns page with expected content" do
        expect(page).to have_content "What type of property is the certificate for?"
      end
    end
end
