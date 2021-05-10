require 'rails_helper'

RSpec.describe 'Instructors', type: :request do
  let(:instructor) { FactoryBot.create(:instructor) }

  describe '#index' do
    it 'responds successfully' do
      get instructors_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    it 'responds successfully' do
      get instructor_path(instructor)
      expect(response).to have_http_status(:success)
    end
  end
end
