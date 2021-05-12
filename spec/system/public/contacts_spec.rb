require 'rails_helper'

RSpec.describe 'Contacts', type: :system, js: true do
  before do
    visit new_contact_path
  end

  it 'succeeds send contact when submit valid information' do
    fill_in 'contact_name', with: 'contact user'
    fill_in 'contact_email', with: 'contact@example.com'
    fill_in 'contact_message', with: 'contact message'
    click_button '入力内容を確認する'
    aggregate_failures do
      expect(page).to have_content 'contact user'
      expect(page).to have_content 'contact@example.com'
      expect(page).to have_content 'contact message'
    end
    click_button '送信'
    aggregate_failures do
      expect(current_path).to eq root_path
      expect(has_css?('.alert-success')).to be_truthy
      expect(page).to have_content 'お問い合わせを受け付けました。折り返し担当者よりご連絡致しますので、恐れ入りますがしばらくお待ちください。'
      visit current_path
      expect(has_css?('.alert-success')).to be_falsy
    end
  end

  it 'fails send contact when submit invalid information' do
    fill_in 'contact_name', with: ' '
    fill_in 'contact_email', with: ' '
    fill_in 'contact_message', with: ' '
    click_button '入力内容を確認する'
    aggregate_failures do
      expect(current_path).to eq new_contact_path
      expect(page).to have_content '必須項目です'
    end
  end
end
