call :train NIb_CP 2_9
call :train CI_6K2 5_5
call :train 6K2_VPg 9_0
call :train VPg_NIa 3_7
call :train P1_HC 3_8
call :train NIa_NIb 1_10
call :train P3_6K1 2_8
call :train 6K1_CI 7_2
call :train HC_P3 6_5
goto :eof

:train
md HmmModels\%1_%2
cd HmmModels\%1_%2
rem ..\..\bin\fasthmm.exe train_multiple ..\..\CleavageSitesSampled\%1_%2_train.destino %1_%2_hmm_manifest.txt 15 8
cd ..\..

md HmmModels\%1_%2_balanced
cd HmmModels\%1_%2_balanced
..\..\bin\fasthmm.exe train_multiple ..\..\CleavageSitesSampled\%1_%2_train_balanced.destino %1_%2_hmm_manifest.txt 15 8
cd ..\..

goto :eof