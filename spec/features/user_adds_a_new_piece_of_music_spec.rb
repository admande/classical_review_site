require "rails_helper"

feature "user add a new piece of music" do

  context "not-signed-in users" do
    scenario "cannot create a new piece" do
      visit new_piece_path

      expect(page).to have_content "Please sign in to add a piece"
    end
  end

  context "logged in user" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:piece) { FactoryGirl.create(:piece, user: user) }

    before do
      sign_in_as(user)
    end

    scenario "user adds new piece of music successfully" do
      visit new_piece_path
      fill_in 'Title', with: "Marriage of Figaro"
      fill_in 'Composer', with: "Mozart"
      click_button "Add Piece"

      expect(page).to have_content "Piece added successfully"
    end

    scenario "user does not provide proper information" do
      visit new_piece_path
      click_button "Add Piece"
      expect(page).to have_content "Title can't be blank"
    end

    scenario "user provides piece and composer pair already added" do
      visit new_piece_path
      fill_in 'Title', with: piece.title
      fill_in 'Composer', with: piece.composer
      click_button "Add Piece"

      visit new_piece_path
      fill_in 'Title', with: piece.title
      fill_in 'Composer', with: piece.composer
      click_button "Add Piece"

      expect(page).to have_content
      "There should only be one title and composer pair"
    end
  end
end
