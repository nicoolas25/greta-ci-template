require "test_helper"

describe Calculator::App do
  include Rack::Test::Methods

  describe "when loading the calculator" do
    before do
      get "/"
    end

    it "has one input field" do
      assert_equal last_response_document.css("input[name='raw_amount']").size, 1
    end

    it "has a button to validate named 'Valider'" do
      button = last_response_document.at_css("button[type='submit']")
      assert button
      assert_equal button.text, "Valider"
    end
  end

  describe "when sending a valid raw_amount" do
    before do
      post "/", "raw_amount" => "100.56"
    end

    it "displays no error" do
      assert_nil last_response_document.at_css(".error")
    end

    it "displays the same amount" do
      assert_includes last_response_document.at_css(".result").text, "100.56"
    end
  end

  def app
    Calculator::App.new
  end

  def last_response_document
    Nokogiri::HTML(last_response.body)
  end
end
