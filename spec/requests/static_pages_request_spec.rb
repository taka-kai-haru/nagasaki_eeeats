require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it "正常にレスポンスを返すこと" do
      get root_url
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "#about" do
    it "正常にレスポンスを返すこと" do
      get about_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
