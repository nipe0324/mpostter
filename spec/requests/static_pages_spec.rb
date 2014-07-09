require 'spec_helper'

describe "静的ページの" do

	describe "ホーム画面は" do
		it "should have the content 'サンプルアプリ'" do
			visit '/static_pages/home'
			expect(page).to have_content('サンプルアプリ')
		end
  end

  describe "ヘルプ画面は" do
  	it "should have the content 'ヘルプ'" do
  		visit '/static_pages/help'
  		expect(page).to have_content('ヘルプ')
	  end
	end

	describe "このサイトについて画面は" do
		it "should have the content 'このサイトについて'" do
			visit '/static_pages/about'
			expect(page).to have_content('このサイトについて')
		end
	end

end
