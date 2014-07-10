require 'spec_helper'

describe "静的ページの" do

	subject { page }

	describe "ホーム画面は" do
		before { visit root_path }

		it { should have_content('サンプルアプリ') }
		it { should have_title(full_title('')) }
		it { should_not have_title('ホーム') }
	end

  describe "ヘルプ画面は" do
  	before { visit help_path }

  	it { should have_content('ヘルプ') }
		it { should have_title(full_title('ヘルプ')) }
	end

	describe "このサイトについて画面は" do
		before { visit about_path }

		it { should have_content('このサイトについて') }

		it { should have_title(full_title('このサイトについて')) }
	end

	describe "お問い合わせ画面は" do
		before { visit contact_path }
		it { should have_content('お問い合わせ') }
		it { should have_title(full_title('お問い合わせ')) }
	end

end
