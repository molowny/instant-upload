require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "works! (now write some real specs)", js: true do
      User.create! name: 'Mariusz'
      visit users_path
      page.should have_content("Mariusz")
    end
  end
end
