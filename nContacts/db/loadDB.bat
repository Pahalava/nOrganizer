@echo off

echo.
echo *** Initializing nContacts (part of nOrganizer) ***
echo.
echo|set /p=  ** Preparing Database for nContacts
sqlite3 ncontacts.db < ncontacts-schema.sql
echo  ......... Done
echo.

echo|set /p=  ** Loading basic data for the tables
sqlite3 ncontacts.db < ncontacts-data.sql
echo  ......... Done
echo.
SET /P loadTestData=Would you like to load test data as well (Y/[N])?
IF /I "%loadTestData%" NEQ "Y" GOTO:EOF
echo|set /p=  * Loading test data for the tables
sqlite3 ncontacts.db < ncontacts-testdata.sql
echo  ......... Done
echo.

pause 
GOTO:EOF

SET /P startDB=Would you like to start DB (Y/[N])?
IF /I "%startDB%" NEQ "Y" GOTO:EOF
echo ** Starting Database
echo.
sqlite3 ncontacts.db

@echo on