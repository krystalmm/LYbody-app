require 'rails_helper'

RSpec.describe 'Search', type: :system do
  let(:instructor) { FactoryBot.create(:instructor) }

  before do
    FactoryBot.create(:user, firstname: 'search', lastname: 'user')
    instructor_login_as(instructor)
  end

  it 'succeeds search user when submit valid user name' do
    fill_in 'word', with: 'search'
    find('.search-icon').click
    expect(page).to have_content '検索結果'
    expect(page).to have_content 'search　user'
  end

  it 'fails search user when submit invalid user name' do
    fill_in 'word', with: 'b'
    find('.search-icon').click
    expect(page).to have_content '検索結果'
    expect(page).to_not have_content 'search　user'
  end

  it 'succeeds search all user when submit the blank' do
    find('.search-icon').click
    expect(page).to have_content '検索結果'
    expect(page).to have_content 'search　user'
  end
end
