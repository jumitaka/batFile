@echo off
set interval=10
echo �v���Z�X�Ď��p�o�b�`�ł��B
echo �������g�p�ʂ��Ď��������v���Z�X�̃C���[�W��(�^�X�N�}�l�[�W���Q��)����͂���΁A
echo %interval%�b�����œ���f�B���N�g�����̃v���Z�X�Ď�[���̓v���Z�X].txt�ɒǋL���Ă����܂��B
set /P process="�Ď��v���Z�X�ݒ�F%process%"
echo �Ď��J�n %date% %time%
echo "���t","����","������(K)">> "�v���Z�X�Ď�["%process%"].csv"
echo "%date%","%time%","�Ď��J�n">> "�v���Z�X�Ď�["%process%"].csv"
:LOOP
	for /f "usebackq tokens=5" %%i IN (`tasklist /v /fi ^"imagename eq ^"%process%`) do @set task=%%i
	echo "%date%","%time%","%task%">> "�v���Z�X�Ď�["%process%"].csv"
	timeout %interval% /nobreak >nul
goto :LOOP