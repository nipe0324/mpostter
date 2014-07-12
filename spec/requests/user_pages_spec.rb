require 'spec_helper'

describe "ユーザページの" do

	subject { page }

  describe "サインアップ画面の" do
  	before { visit signup_path }

  	it { should have_content('サインアップ') }
  	it { should have_title(full_title('サインアップ')) }
  end

  describe "プロフィール画面の" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.name) }
  	it { should have_title(user.name) }
  end


  describe "サインアップ動作" do

    before { visit signup_path }

    let(:submit) { "アカウント作成" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",             with: "Example User"
        fill_in "Email",            with: "user@example.com"
        fill_in "Password",         with: "foobar"
        fill_in "Confirmation",     with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end

  end

end