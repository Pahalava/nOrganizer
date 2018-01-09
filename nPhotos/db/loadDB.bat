@echo off

echo.
echo *** Initializing nPhotos (part of nOrganizer) ***
echo.
echo|set /p=  ** Preparing Database for nPhotos
sqlite3 nphotos.db < nphotos-schema.sql
echo  ......... Done
echo.

echo|set /p=  ** Loading basic data for the tables
sqlite3 nphotos.db < nphotos-data.sql
echo  ......... Done
echo.
SET /P loadTestData=Would you like to load test data as well (Y/[N])?
IF /I "%loadTestData%" NEQ "Y" GOTO:EOF
echo|set /p=  * Loading test data for the tables
sqlite3 nphotos.db < nphotos-testdata.sql
echo  ......... Done
echo.

pause 
GOTO:EOF

SET /P startDB=Would you like to start DB (Y/[N])?
IF /I "%startDB%" NEQ "Y" GOTO:EOF
echo ** Starting Database
echo.
sqlite3 nphotos.db

@echo on