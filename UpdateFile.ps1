# �e���|�W�g�����Ƃ̐ݒ���e
# �����[�g�t�@�C���擾�f�B���N�g��(git�Ǘ��f�B���N�g��)
# set repodic=gitdirectory
# �R�s�[���f�B���N�g��
# set #otedic=\\#otedirectory\hoge
# �R�s�[��f�B���N�g��
# set copydic=hoge
# robocopy����
# set roboArg=huga

# �ݒ���e
$workNameHead = "Work"
$masterName = "master"

pushd $global:repodic
if (-not (Test-Path .git)) {
	echo "git init���s���ĉ������B"
	Read-Host "������ɂ�ENTER�L�[�������ĉ�����" 
}

# ���t�擾
$now= Get-Date -Format "yyyyMMddHHmmss"

echo $global:remotedic ���擾���A
echo $global:repodic\$global:copydic ��$global:masterName �u�����`�ɃR�s�[���܂��B

pushd $global:repodic\$global:copydic

# git status�����s���A�ύX�t�@�C�����Ȃ����m�F
status = $false
git status -s | ForEach-Object { $status = $true }

if ($status) {
	git checkout -b "$workNameHead$now"
	git add .
	git commit -a -m "$workNameHead$now"
} else {
	echo �ҏW���t�@�C�����Ȃ����߁A%workNameHead% �u�����`�͍쐬���܂���B
}

git checkout "$masterName"

echo $global:remotedic �̍ŐV�擾���ł�...
robocopy $global:remotedic $global:repodic\$global:copydic /MIR /NP /R:3 /W:3 /xj $roboArg
echo �ŐV�擾�����ł��B
echo;

# �ŐV�擾�����t�@�C�����R�~�b�g
git add -A
git commit -a -m "Update $now."

# ��ƒ��u�����`�ɕύX
if ($status) {
	git checkout "%workNameHead%%now%"
}