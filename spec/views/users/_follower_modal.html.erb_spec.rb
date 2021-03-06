require 'spec_helper'

describe 'users/_follower_modal.html.erb', type: :view do
  let(:frank) { FactoryGirl.create(:user, display_name: "Frank") }
  let(:page) { Capybara::Node::Simple.new(rendered) }

  before do
    assign :user, view_user
    allow(controller).to receive(:current_user).and_return(current_user)
    assign :followers, followers
    render
  end

  context "when followers" do
    let(:view_user) {}
    let(:current_user) {}
    let(:followers) { [frank] }

    it "draws user list" do
      expect(page).to have_link "Frank", href: "/users/#{frank.to_param}"
    end
  end

  context "when no followers" do
    let(:followers) { [] }
    let(:view_user) { frank }

    context "when logged in " do
      context "when current user has no followers" do
        let(:current_user) { frank }

        it "indicates the lack of followers for you" do
          expect(page).to have_text "No one is following you."
        end
      end

      context "when another user has no followers" do
        let(:current_user) { stub_model(User) }

        it "indicates the lack of followers for this user" do
          expect(page).to have_text "No one is following this user."
        end
      end
    end

    context "when not logged in" do
      let(:current_user) {}

      it "indicates the lack of followers for this user" do
        expect(page).to have_text "No one is following this user."
      end
    end
  end
end
