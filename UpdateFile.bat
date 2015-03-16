@echo off

REM 各リポジトリごとの設定内容
REM リモートファイル取得ディレクトリ(git管理ディレクトリ)
REM set repodic=gitdirectory
REM コピー元ディレクトリ
REM set remotedic=\\remotedirectory\hoge
REM コピー先ディレクトリ
REM set copydic=hoge

REM 設定内容
set workNameHead=Work
set masterName=master

pushd %repodic%
if not exist ".git" (
	echo git initを行って下さい。
	pause
)

REM 日付取得
set time_tmp=%time: =0%
set now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%

echo %remotedic% を取得し、
echo %repodic%\%copydic% の%masterName% ブランチにコピーします。

cd %repodic%\%copydic%

REM git statusを実行し、変更ファイルがないか確認
set STATUS=STATUS
for /F "usebackq" %%i in (`git status -s`) do @set STATUS=%%i

if NOT "%STATUS%"=="STATUS" (
	git checkout -b "%workNameHead%%now%"
	git add .
	git commit -a -m "%workNameHead%%now%"
) else (
	echo 編集中ファイルがないため、%workNameHead% ブランチは作成しません。
)

git checkout "%masterName%"

echo %remotedic% の最新取得中です...
robocopy %remotedic% %repodic%\%copydic% /MIR /NP /R:3 /W:3
echo 最新取得完了です。
echo;

REM 最新取得したファイルをコミット
git add .
git commit -a -m "Update %now%."

REM 作業中ブランチに変更
if NOT "%STATUS%"=="STATUS" (
	git checkout "%workNameHead%%now%"
)
pause