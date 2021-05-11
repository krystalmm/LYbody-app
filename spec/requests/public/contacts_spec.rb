require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  describe '#new' do
    it 'responds successfully' do
      get new_contact_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#confirm' do
    it 'responds successfully with valid information' do
      post confirm_path, params: { contact: FactoryBot.attributes_for(:contact) }
      expect(response).to have_http_status(:success)
    end

    it 'render new with invalid information' do
      post confirm_path, params: { contact: {
        name: ' ', email: 'invalid@user', message: ' '
      } }
      expect(response.body).to include 'お問い合わせフォーム'
    end
  end

  describe '#back' do
    it 'responds successfully' do
      post back_path, params: { contact: FactoryBot.attributes_for(:contact) }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'succeeds create contact with valid information' do
      aggregate_failures do
        expect do
          post contacts_path, params: { contact: FactoryBot.attributes_for(:contact) }
        end.to change(Contact, :count).by(1)
        expect(response).to redirect_to root_path
        expect(ActionMailer::Base.deliveries.size).to eq(1)
      end
    end

    it 'fails create contact with invalid information' do
      aggregate_failures do
        expect do
          post contacts_path, params: { contact: {
            name: ' ', email: 'invalid@user', message: ' '
          } }
        end.to change(Contact, :count).by(0)
        expect(response.body).to include 'お問い合わせフォーム'
        expect(ActionMailer::Base.deliveries.size).to eq(0)
      end
    end
  end
end
