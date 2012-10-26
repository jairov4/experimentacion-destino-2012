call :test NIb_CP 2_9
call :test CI_6K2 5_5
call :test 6K2_VPg 9_0
call :test VPg_NIa 3_7
call :test P1_HC 3_8
call :test NIa_NIb 1_10
call :test P3_6K1 2_8
call :test 6K1_CI 7_2
call :test HC_P3 6_5
goto :eof

:test
md OilModels\%1_%2
cd OilModels\%1_%2
rem ..\..\bin\fastoil.exe test_multiple ..\..\CleavageSitesSampled\%1_%2_test.destino %1_%2_oil_manifest.txt %1_%2_oil_test_report.txt
cd ..\..

md OilModels\%1_%2_balanced
cd OilModels\%1_%2_balanced
..\..\bin\fastoil.exe test_multiple ..\..\CleavageSitesSampled\%1_%2_test.destino %1_%2_oil_manifest.txt %1_%2_oil_test_report.txt
cd ..\..

goto :eof