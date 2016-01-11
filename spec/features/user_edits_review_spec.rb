feature "user edits a piece" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:piece) { FactoryGirl.create(:piece, user: user) }
  let!(:review) { FactoryGirl.create(:review, piece: piece, user: user) }

  context "non-signed-in user cannot edit a review" do
    before do
      visit piece_path(piece)
    end

    scenario "non-signed-in cannot see edit link" do
      expect(page).to_not have_content "Edit Review"
    end

    scenario "non-signed-in is presented with error when visiting edit review path" do
      visit edit_piece_review_path(piece, review)

      expect(page).to have_content "You need to sign in or sign up before continuing."
      expect(page).to_not have_content(piece.title)
    end
  end

  context "signed in user editing own review" do
    before do
      sign_in_as(user)
      visit piece_path(piece)
      click_link "Edit Review"
    end

    scenario "signed in user sucessfully edits own review" do

      expect(page).to have_content "Edit Review"

      title = "Really Good"
      description = "MozartMozartMozartMozartMozartMozartMozartMozartMozartMozartMozartMozartMozartMozartMozartMozartMozart"
      fill_in 'Title', with: title
      fill_in 'Description', with: description
      click_button "Edit"

      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end
  end

  context "signed in user tries to edit someone elses review" do
    let(:user2) { FactoryGirl.create(:user) }

    before do
      sign_in_as(user2)
    end

    scenario "signed in user cannot see edit button for other users review" do
      visit piece_path(piece)
      expect(page).to_not have_content("Edit Review")
    end

    scenario "signed in user is presented with error when visiting edit path for other user's review" do
      visit edit_piece_review_path(piece, review)

      expect(page).to have_content "You can only edit a review you created"
    end
  end
end
