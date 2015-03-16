@echo off

REM �e���|�W�g�����Ƃ̐ݒ���e
REM �����[�g�t�@�C���擾�f�B���N�g��(git�Ǘ��f�B���N�g��)
REM set repodic=gitdirectory
REM �R�s�[���f�B���N�g��
REM set remotedic=\\remotedirectory\hoge
REM �R�s�[��f�B���N�g��
REM set copydic=hoge

REM �ݒ���e
set workNameHead=Work
set masterName=master

pushd %repodic%
if not exist ".git" (
	echo git init���s���ĉ������B
	pause
)

REM ���t�擾
set time_tmp=%time: =0%
set now=%date:/=%%time_tmp:~0,2%%time_tmp:~3,2%%time_tmp:~6,2%

echo %remotedic% ���擾���A
echo %repodic%\%copydic% ��%masterName% �u�����`�ɃR�s�[���܂��B

cd %repodic%\%copydic%

REM git status�����s���A�ύX�t�@�C�����Ȃ����m�F
set STATUS=STATUS
for /F "usebackq" %%i in (`git status -s`) do @set STATUS=%%i

if NOT "%STATUS%"=="STATUS" (
	git checkout -b "%workNameHead%%now%"
	git add .
	git commit -a -m "%workNameHead%%now%"
) else (
	echo �ҏW���t�@�C�����Ȃ����߁A%workNameHead% �u�����`�͍쐬���܂���B
)

git checkout "%masterName%"

echo %remotedic% �̍ŐV�擾���ł�...
robocopy %remotedic% %repodic%\%copydic% /MIR /NP /R:3 /W:3
echo �ŐV�擾�����ł��B
echo;

REM �ŐV�擾�����t�@�C�����R�~�b�g
git add .
git commit -a -m "Update %now%."

REM ��ƒ��u�����`�ɕύX
if NOT "%STATUS%"=="STATUS" (
	git checkout "%workNameHead%%now%"
)
pause