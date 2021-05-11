require 'rails_helper'

RSpec.describe 'Search', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }

  describe '#search' do
    before { sign_in instructor }

    it 'responds successfully' do
      get instructors_search_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'before_action: :authenticate_instructor' do
    it 'redirects search when not logged in' do
      get instructors_search_path
      expect(response).to redirect_to new_instructor_session_path
    end
  end
end
