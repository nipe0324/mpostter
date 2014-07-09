require 'spec_helper'

describe "静的ページの" do

	let(:base_title) { "Ruby on Rails チュートリアル サンプルアプリ" }

	describe "ホーム画面は" do
		it "should have the content 'サンプルアプリ'" do
			visit '/static_pages/home'
			expect(page).to have_content('サンプルアプリ')
		end

		it "should have the base title" do
			visit '/static_pages/home'
			expect(page).to have_title("#{base_title}")
		end

		it "should not have the custome page title" do
			visit '/static_pages/home'
			expect(page).not_to have_title("| ホーム")
		end
  end

  describe "ヘルプ画面は" do
  	it "should have the content 'ヘルプ'" do
  		visit '/static_pages/help'
  		expect(page).to have_content('ヘルプ')
	  end

		it "should have the right title" do
			visit '/static_pages/help'
			expect(page).to have_title("#{base_title} | ヘルプ")
		end
	end

	describe "このサイトについて画面は" do
		it "should have the content 'このサイトについて'" do
			visit '/static_pages/about'
			expect(page).to have_content('このサイトについて')
		end

		it "should have the right title" do
			visit '/static_pages/about'
			expect(page).to have_title("#{base_title} | このサイトについて")
		end
	end

	describe "お問い合わせ画面は" do
		it "should have the content 'お問い合わせ'" do
			visit '/static_pages/contact'
			expect(page).to have_content('お問い合わせ')
		end

		it "should have the right title" do
			visit '/static_pages/contact'
			expect(page).to have_title("#{base_title} | お問い合わせ")
		end
	end

end
