@echo OFF
REM TODO use the call command to set some variables common to both the installer/uninstaller
set SVN_VERSION=1.7.0
set APACHE_VERSION=2.2.21

set BIN=installer\bin
set TMP=installer\temp

set WAMP="c:\wamp"
set WAMP_SVN=%WAMP%\bin\svn
set WAMP_APACHE_MODULES=%WAMP%\bin\apache\apache%APACHE_VERSION%\modules

set SVN_FILE=svn-win32-%SVN_VERSION%
set SVN_DIR=svn%SVN_VERSION%
set SVN_BIN=%WAMP_SVN%\%SVN_DIR%\bin

set DOWNLOAD=http://downloads.sourceforge.net/project/win32svn/%SVN_VERSION%/%SVN_FILE%.zip

REM choose one of following apache config files for svn
set SVN_ALIAS=svn-anonymous-ro-access.conf
REM set SVN_ALIAS=svn-anonymous-rw-access.conf

set PATH=%PATH%;%BIN%

echo Welcome to the SVN Addon installer for WampServer 2.2a

REM set up the temp directory
IF NOT EXIST %TMP% GOTO MKTMP
echo 	Temp directory found from previous install: DELETING
rd /S /Q %TMP%

:MKTMP
echo 	Setting up the temp directory...
mkdir %TMP%

REM download subversion archive to temp directory
echo 	Downloading svn binaries to temp directory...
%BIN%\wget.exe -nd -q -P %TMP% %DOWNLOAD%

REM unzip the downloaded source files and install them
echo 	Extracting the files from the downloaded archive...
unzip.exe -q %TMP%\%SVN_FILE%.zip -d %TMP%
ren %TMP%\%SVN_FILE% %SVN_DIR%

REM install the binary files in the WampServer install directory
echo 	Moving the files to the WampServer install directory...
mkdir %WAMP_SVN%
move %TMP%\%SVN_DIR% %WAMP_SVN%

REM install the SVN modules for Apache
echo 	Installing the Subversion modules for Apache...
copy %SVN_BIN%\mod_authz_svn.so %WAMP_APACHE_MODULES%
copy %SVN_BIN%\mod_dav_svn.so %WAMP_APACHE_MODULES%

REM install the apache config file for SVN
REM FIXME: may be able to skip moving to%TMP% and just copy to %WAMP_ALIAS%
REM FIXME: and rename during that copy command
echo 	Installing SVN configuration files...
copy wamp\alias\%SVN_ALIAS% %TMP%
ren %TMP%\%SVN_ALIAS% svn.conf
move %TMP%\svn.conf %WAMP%\alias

REM add the SVN bin directory to the PATH so apache can find them
echo 	Setting enviorment variables...
setenv -a PATH %SVN_BIN%

REM create a place to store repositories
echo 	Making directory to store SVN repositories...
mkdir c:\svn

REM clean up temp files
echo 	Cleaning up temp files...
rd /S /Q %TMP%

echo Subversion is installed successfully. Please restart WampServer.

pause
