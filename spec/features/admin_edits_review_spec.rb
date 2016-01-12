require 'rails_helper'

feature "admin edits review" do
  context "visiting piece show page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:admin) { FactoryGirl.create(:admin) }
    let(:piece) { FactoryGirl.create(:piece, user: user) }
    let!(:review) { FactoryGirl.create(:review, piece: piece, user: user) }


    before do
      sign_in_as(admin)
      visit piece_path(piece)
      click_link "Edit Review"
    end

    scenario "admin sees edit form for Review" do
      expect(page).to have_content "Edit Review"

      character_minimum = 500
      title = "Really Good"
      description = "a" * character_minimum
      fill_in 'Title', with: title
      fill_in 'Description', with: description
      click_button "Edit"

      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end
  end
end
