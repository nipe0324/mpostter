require 'spec_helper'

describe "Static pages" do

	it "should have the right links on the layout" do
		visit root_path
		click_link "このサイトについて"
		expect(page).to have_title(full_title('このサイトについて'))
		click_link "ヘルプ"
		expect(page).to have_title(full_title('ヘルプ'))
		click_link "お問い合わせ"
		expect(page).to have_title(full_title('お問い合わせ'))
		click_link "ホーム"
		click_link "サインアップ"
		expect(page).to have_title(full_title('サインアップ'))
		click_link "サンプルアプリ"
		expect(page).to have_title(full_title(''))
	end


	subject { page }

	shared_examples_for "全ての静的ページ" do
		it { should have_content(heading) }
		it { should have_title(full_title(page_title)) }
	end


	describe "Home page" do
		before { visit root_path }
		let(:heading)			{ 'サンプルアプリ' }
		let(:page_title)	{ '' }

		it_should_behave_like "全ての静的ページ"
		it { should_not have_title('ホーム') }

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text:item.content)
				end
			end
		end
	end


  describe "ヘルプ画面は" do
  	before { visit help_path }
		let(:heading)			{ 'ヘルプ' }
		let(:page_title)	{ 'ヘルプ' }

		it_should_behave_like "全ての静的ページ"
	end


	describe "このサイトについて画面は" do
		before { visit about_path }
		let(:heading)			{ 'このサイトについて' }
		let(:page_title)	{ 'このサイトについて' }

		it_should_behave_like "全ての静的ページ"
	end


	describe "お問い合わせ画面は" do
		before { visit contact_path }
		let(:heading)			{ 'お問い合わせ' }
		let(:page_title)	{ 'お問い合わせ' }

		it_should_behave_like "全ての静的ページ"
	end

end
