@echo OFF
REM TODO use the call command to set some variables common to both the installer/uninstaller
set SVN_VERSION=1.7.1
set APACHE_VERSION=2.2.21
set WAMP_VERSION=2.2a

set ADDON=Subversion

set BIN=installer\bin
set TMP=installer\temp

set WAMP=c:\wamp
set WAMP_SVN=%WAMP%\bin\svn
set WAMP_APACHE_MODULES=%WAMP%\bin\apache\apache%APACHE_VERSION%\modules

set SVN_FILE=svn-win32-%SVN_VERSION%
set SVN_DIR=svn%SVN_VERSION%
set SVN_BIN=%WAMP_SVN%\%SVN_DIR%\bin

set SVN_DOWNLOAD=http://downloads.sourceforge.net/project/win32svn/%SVN_VERSION%/%SVN_FILE%.zip

REM choose one of following apache config files for Subversion
set SVN_ALIAS=svn-anonymous-ro-access.conf
REM set SVN_ALIAS=svn-anonymous-rw-access.conf

set PATH=%PATH%;%BIN%

echo Welcome to the %ADDON% Addon installer for WampServer %WAMP_VERSION%

REM set up the temp directory
IF NOT EXIST %TMP% GOTO MKTMP
echo 	Temp directory found from previous install: DELETING
rd /S /Q %TMP%

:MKTMP
echo 	Setting up the temp directory...
mkdir %TMP%

REM download Subversion archive to temp directory
echo 	Downloading %ADDON% binaries to temp directory...
wget.exe -nd -q -P %TMP% %SVN_DOWNLOAD%
if not %ERRORLEVEL%==0 (echo FAIL: could not download %ADDON% binaries& pause& exit 1)

REM unzip the downloaded source files and install them
echo 	Extracting the files from the downloaded archive...
unzip.exe -q %TMP%\%SVN_FILE%.zip -d %TMP%
if not %ERRORLEVEL%==0 (echo FAIL: could not extract downloaded files& pause& exit 1)

REM install the binary files in the WampServer install directory
echo 	Moving the files to the WampServer install directory...
mkdir %WAMP_SVN%
xcopy /E /I /Q  %TMP%\%SVN_FILE% %WAMP_SVN%\%SVN_DIR% > NUL 2>&1
if not %ERRORLEVEL%==0 (echo FAIL: could not move the files& pause& exit 1)

REM install the Subversion modules for Apache
echo 	Installing the %ADDON% modules for Apache...
copy %SVN_BIN%\mod_authz_svn.so %WAMP_APACHE_MODULES% > NUL 2>&1
copy %SVN_BIN%\mod_dav_svn.so %WAMP_APACHE_MODULES% > NUL 2>&1
if not %ERRORLEVEL%==0 (echo FAIL: could not install Apache modules& pause& exit 1)

REM install the apache config file for Subversion
echo 	Installing %ADDON% configuration files...
copy wamp\alias\%SVN_ALIAS% %WAMP%\alias\svn.conf > NUL 2>&1
if not %ERRORLEVEL%==0 (echo FAIL: could not install WampServer alias file& pause& exit 1)

REM add the Subversion bin directory to the PATH so apache can find them
echo 	Setting enviorment variables...
setenv -a PATH %SVN_BIN%

REM create a place to store repositories
echo 	Making directory to store Subversion repositories...
mkdir c:\svn

REM ----------------------- install the language bindings
REM set variables needed to install the Python language bindings
set PYTHON_VERSION=2.7.2
set PYTHON_SERIES=27

set WAMP_PYTHON=%WAMP%\bin\python

set PYBINDINGS_FILE=svn-win32-%SVN_VERSION%_py%PYTHON_SERIES%
set PYTHON_DIR=python%PYTHON_VERSION%
set PYTHON_BIN=%WAMP_PYTHON%\%PYTHON_DIR%
set PYTHON_LIB=%PYTHON_BIN%\Lib\site-packages

set PYBINDINGS_DOWNLOAD=http://downloads.sourceforge.net/project/win32svn/%SVN_VERSION%/%PYBINDINGS_FILE%.zip

REM Python Bindings
:PYTHON
IF NOT EXIST %PYTHON_BIN% GOTO PYTHON_END
echo installing the Python language bindings...

REM download Subversion archive to temp directory
echo 	Downloading Python Bindings to temp directory...
wget.exe -nd -q -P %TMP% %PYBINDINGS_DOWNLOAD%
if not %ERRORLEVEL%==0 (echo WARNING: could not download Python bindings. Skipping...& GOTO PYTHON_END)

REM unzip the downloaded source files and install them
echo 	Extracting the files from the downloaded archive...
unzip.exe -q -o %TMP%\%PYBINDINGS_FILE%.zip -d %TMP%
if not %ERRORLEVEL%==0 (echo WARNING: could not extract Python bindings. Skipping...& GOTO PYTHON_END)

REM install the binary files in the WampServer install directory
echo 	Moving the files to the WampServer install directory...
xcopy /E /I /Q %TMP%\%SVN_FILE%\python %PYTHON_LIB% > NUL 2>&1
if not %ERRORLEVEL%==0 (echo WARNING: could not install Python bindings. Skipping...& GOTO PYTHON_END)

REM TODO: precompile bindings

echo	Python Bindings installed successfully.
:PYTHON_END

REM ----------------------- end install the language bindings

REM clean up temp files
echo 	Cleaning up temp files...
rd /S /Q %TMP%

echo %ADDON% is installed successfully. Please restart WampServer.

pause
