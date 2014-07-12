require 'spec_helper'

describe "認証機能の" do

	subject { page }

	describe "サインイン実施" do
		before { visit signin_path }


		describe "with invalid information" do
			before { click_button "サインイン" }

			it { should have_title('サインイン') }
      it { should have_error_message('間違って') }

			describe "after visiting another page" do
				before { click_link "ホーム" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before { valid_signin(user) }

			it { should have_title(user.name) }
			it { should have_link('プロフィール', href: user_path(user)) }
			it { should have_link('サインアウト', href: signout_path) }
			it { should_not have_link('サインイン', href: signin_path) }

			describe "followed by signout" do
				before { click_link "サインアウト" }
				it { should have_link('サインイン') }
			end

		end

	end

end
