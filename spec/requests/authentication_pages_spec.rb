require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe "sign in" do
		before { visit signin_path }


		describe "with invalid information" do
			let(:user) { FactoryGirl.create(:user) }
			before { click_button "サインイン" }

			it { should have_title('サインイン') }
      it { should have_error_message('間違って') }

			it { should_not have_link('ユーザ一覧',		href: users_path) }
			it { should_not have_link('プロフィール', href: user_path(user)) }
			it { should_not have_link('設定', 				href: edit_user_path(user)) }
			it { should_not have_link('サインアウト', href: signout_path) }
			it { should have_link('サインイン', href: signin_path) }

			describe "after visiting another page" do
				before { click_link "ホーム" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before { valid_signin(user) }

			it { should have_title(user.name) }
			it { should have_link('ユーザ一覧',		href: users_path) }
			it { should have_link('プロフィール', href: user_path(user)) }
			it { should have_link('設定', 				href: edit_user_path(user)) }
			it { should have_link('サインアウト', href: signout_path) }
			it { should_not have_link('サインイン', href: signin_path) }

			describe "followed by signout" do
				before { click_link "サインアウト" }
				it { should have_link('サインイン') }
			end

		end

	end

	describe "authorization" do
		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "in the Users controller" do
				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title('サインイン') }
				end

				describe "submitting to the update action" do
					before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
				end

				describe "visiting the user index" do
					before { visit users_path }
					it { should have_title('サインイン') }
				end
			end

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					sign_in user
				end

				describe "after signing in" do
					it "should render the desired protected page" do
						expect(page).to have_title('ユーザ更新')
					end
				end
			end

		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the Users#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match(full_title('ユーザ更新')) }
				specify { expect(response).to redirect_to(root_url) }
			end

			describe "submitting a PATCH request to the User#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_path) }
			end

		end

		describe "as non-admin user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) { FactoryGirl.create(:user) }

			before { sign_in non_admin, no_capybara: true }

			describe "submitting a DELETE request to the Users#destroy action" do
				before { delete user_path(user) }
				specify { expect(response).to redirect_to(root_path) }
			end
		end

		describe "as admin user" do
			let(:admin) { FactoryGirl.create(:admin) }

			before { sign_in admin, no_capybara: true }

			describe "submitting a DELETE request to the User#destroy action" do
				before { delete user_path(admin) }
				specify { expect(response).to redirect_to(users_url) }
			end
		end

	end

end
