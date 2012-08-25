@echo OFF
REM TODO use the call command to set some variables common to both the installer/uninstaller
set SVN_VERSION=1.6.6
set APACHE_VERSION=2.2.11

set BIN=installer\bin

set WAMP="c:\wamp"
set WAMP_SVN=%WAMP%\bin\svn
set WAMP_APACHE_MODULES=%WAMP%\bin\apache\apache%APACHE_VERSION%\modules

set SVN_DIR=svn%SVN_VERSION%
set SVN_BIN=%WAMP_SVN%\%SVN_DIR%\bin

set PATH=%PATH%;%BIN%

echo Welcome to the SVN Addon uninstaller for WampServer 2.0i
echo * The uninstaller will not remove repositories stored in c:\svn
echo * Backup your svn.conf file if you wish to save any changes
echo * Please exit WampServer so all files can be removed
pause

echo 	Uninstalling the Subversion binaries...
rd /S /Q %WAMP_SVN%

echo 	Uninstalling Subversion modules for Apache...
del %WAMP_APACHE_MODULES%\mod_authz_svn.so
del %WAMP_APACHE_MODULES%\mod_dav_svn.so

echo 	Uninstalling SVN configuration files...
del %WAMP%\alias\svn.conf

echo 	Cleaning up enviorment variables...
setenv -d PATH %SVN_BIN%

echo Subversion has uninstalled successfully.

pause
