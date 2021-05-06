require 'rails_helper'

RSpec.describe 'Reviews', type: :system, js: true do
  let(:user) { FactoryBot.create(:user) }
  let(:instructor) { FactoryBot.create(:instructor) }

  context 'when user logged in' do
    before do
      login_as(user)
    end

    it 'succeeds create review when user submit valid review' do
      visit instructor_path(instructor)
      fill_in 'review-textarea', with: 'review content'
      click_button '投稿する'
      aggregate_failures do
        expect(current_path).to eq instructor_path(instructor)
        expect(has_css?('.alert-success')).to be_truthy
        visit current_path
        expect(has_css?('.alert-success')).to be_falsy
        expect(page).to have_content 'review content'
        expect(page).to have_content user.fullname
      end
    end

    it 'fails create review when user submit invalid review' do
      visit instructor_path(instructor)
      fill_in 'review-textarea', with: ' '
      click_button '投稿する'
      aggregate_failures do
        expect(current_path).to eq instructor_path(instructor)
        expect(has_css?('.alert-danger')).to be_truthy
        visit current_path
        expect(has_css?('.alert-danger')).to be_falsy
        expect(page).to_not have_content user.fullname
      end
    end

    it 'succeeds destroy review when correct user' do
      FactoryBot.create(:review, user_id: user.id, instructor_id: instructor.id)
      visit instructor_path(instructor)
      expect(page).to have_content user.fullname
      click_link 'レビューを削除する'
      aggregate_failures do
        expect(current_path).to eq instructor_path(instructor)
        expect(has_css?('.alert-success')).to be_truthy
        visit current_path
        expect(has_css?('.alert-success')).to be_falsy
        expect(page).to_not have_content user.fullname
      end
    end

    it 'fails destroy review when not correct user' do
      other_user = FactoryBot.create(:user)
      FactoryBot.create(:review, user_id: other_user.id, instructor_id: instructor.id)
      visit instructor_path(instructor)
      aggregate_failures do
        expect(page).to have_content other_user.fullname
        expect(page).to_not have_content 'レビューを削除する'
      end
    end
  end

  context 'when user not logged in' do
    it 'fails create and destroy review' do
      visit instructor_path(instructor)
      aggregate_failures do
        expect(page).to_not have_content 'レビューを投稿する'
        expect(page).to_not have_field 'review-textarea'
        expect(page).to_not have_content 'レビューを削除する'
      end
    end
  end
end
