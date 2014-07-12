require 'spec_helper'

describe "User pages" do

	subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title("ユーザ一覧") }
    it { should have_content("ユーザ一覧") }

    describe "pagination" do
      before(:all)  { 30.times { FactoryGirl.create(:user) } }
      after(:all)   { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('削除') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('削除', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect do
            click_link('削除', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('削除', href: user_path(admin)) }
      end

    end

  end

  describe "prifile view" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.name) }
  	it { should have_title(user.name) }
  end

  describe "sign up" do
    before { visit signup_path }

    it { should have_content('サインアップ') }
    it { should have_title(full_title('サインアップ')) }

    let(:submit) { "アカウント作成" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('サインアップ') }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before { valid_signup }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('サインアウト') }
        it { should have_title(user.name) }
        it { should have_success_message("ようこそ") }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("プロフィールの更新") }
      it { should have_title("ユーザ更新") }
      it { should have_link('更新', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "ユーザ更新" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "新しい名前" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",       with: new_name
        fill_in "Email",      with: new_email
        fill_in "Password",   with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "ユーザ更新"
      end

      it { should have_title(new_name) }
      it { should have_success_message('更新') }
      it { should have_link('サインアウト', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
          password_confirmation: user.password } }
        end
        before do
          sign_in user, no_capybara: true
          patch user_path(user), params
        end
        specify { expect(user.reload).not_to be_admin }
    end

  end

end