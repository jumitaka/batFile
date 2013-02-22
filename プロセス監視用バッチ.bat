@echo off
set interval=10
echo プロセス監視用バッチです。
echo メモリ使用量を監視したいプロセスのイメージ名(タスクマネージャ参照)を入力すれば、
echo %interval%秒周期で同一ディレクトリ内のプロセス監視[入力プロセス].txtに追記していきます。
set /P process="監視プロセス設定：%process%"
echo 監視開始 %date% %time%
echo "日付","時間","メモリ(K)">> "プロセス監視["%process%"].csv"
echo "%date%","%time%","監視開始">> "プロセス監視["%process%"].csv"
:LOOP
	for /f "usebackq tokens=5" %%i IN (`tasklist /v /fi ^"imagename eq ^"%process%`) do @set task=%%i
	echo "%date%","%time%","%task%">> "プロセス監視["%process%"].csv"
	timeout %interval% /nobreak >nul
goto :LOOP