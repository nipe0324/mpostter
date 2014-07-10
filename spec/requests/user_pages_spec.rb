require 'spec_helper'

describe "ユーザページの" do

	subject { page }

  describe "サインアップ画面の" do
  	before { visit signup_path }

  	it { should have_content('サインアップ') }
  	it { should have_title(full_title('サインアップ')) }
  end
end