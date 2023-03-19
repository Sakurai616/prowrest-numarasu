require 'rails_helper'

RSpec.describe "TakeQuizzes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/take_quizzes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
