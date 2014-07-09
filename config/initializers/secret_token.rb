# このファイルを修正したら、サーバの再起動をしてください。

# 秘密鍵は、サイン済みのクッキーの完全性を確認するために使われます。
# この秘密鍵が変わった場合、すべてのサイン済みだったクッキーは無効になります。

# 少なくとも30文字以上でランダム値、一般的な単語ではなく、辞書攻撃に
# 無防備ではないようにしてください。
# 'rake secret'コマンドで秘密鍵を生成することができます。

# コードをGitHubなどのパブリックな場所で共有する場合は、
# secret_key_baseは公開しないように注意してください。
require 'securerandom'

def secure_token
	token_file = Rails.root.join('.secret')
	if File.exist?(token_file)
		# 存在するトークンを利用する
		File.read(token_file).chomp
	else
		# 新しいトークンを作成し、トークンファイルに保存する
		token = SecureRandom.hex(64)
		File.write(token_file, token)
		token
	end
end

SampleApp::Application.config.secret_key_base = secure_token