require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe '#top' do
    it 'responds successfully' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '#about' do
    it 'responds successfully' do
      get about_path
      expect(response).to have_http_status(:success)
    end
  end
end
