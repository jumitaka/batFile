# 各リポジトリごとの設定内容
# リモートファイル取得ディレクトリ(git管理ディレクトリ)
# $global:repodic="gitdirectory"
# コピー元ディレクトリ
# $global:remotedic="\\remotedirectory\hoge"
# コピー先ディレクトリ
# $global:copydic="hoge"
# robocopy引数
# $global:roboArg="huga"

# 設定内容
$workNameHead = "Work"
$masterName = "master"

pushd $global:repodic
if (-not (Test-Path .git)) {
	echo "git initを行って下さい。"
	return
}

# 日付取得
$now= Get-Date -Format "yyyyMMddHHmmss"

echo "$global:remotedic を取得し、"
echo "$global:repodic\$global:copydic の$masterName ブランチにコピーします。"

pushd $global:repodic\$global:copydic

# git statusを実行し、変更ファイルがないか確認
$status = $false
git status -s | ForEach-Object { $status = $true }

if ($status) {
	git checkout -b "$workNameHead$now"
	git add .
	git commit -a -m "$workNameHead$now"
} else {
	echo 編集中ファイルがないため、ブランチは作成しません。
}

git checkout "$masterName"

echo "$global:remotedic の最新取得中です..."
robocopy $global:remotedic $global:repodic\$global:copydic /MIR /NP /R:3 /W:3 /xj $global:roboArg
echo 最新取得完了です。
echo ""

# 最新取得したファイルをコミット
git add -A
git commit -a -m "Update $now."

# 作業中ブランチに変更
if ($status) {
	git checkout "$global:workNameHead$now"
}
Read-Host "続けるにはENTERキーを押して下さい" 