@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.3\\bin
call %xv_path%/xelab  -wto f43780a19904474f9f4d9e1aab95c92c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot ALU_TB_behav xil_defaultlib.ALU_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
