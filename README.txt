Subversion Add-on for WampServer Version 2.0i

Apache version: 2.2.11

About:
 This is an addon for WampServer 2.0i that enables access to SVN repositories stored in c:\svn

Download locations for Subversion Zip file:
 * http://subversion.tigris.org/servlets/ProjectDocumentList?folderID=8637&expandFolder=8637&folderID=469

 * 1.5.6 - http://subversion.tigris.org/files/documents/15/45230/svn-win32-1.5.6.zip
 * 1.6.6 - http://subversion.tigris.org/files/documents/15/46880/svn-win32-1.6.6.zip

Manual install instructions:
 (assumes wamp is already installed and working)

 1. download one of the zip files listed above
 2. extract the files to a temporary directory
 3. inside of the folder that was extracted you should see a directory named
    svn-win32-%VERSION%
 4. rename this folder to svn%VERSION% and move it to c:\wamp\bin\svn
 5. add c:\wamp\bin\svn\svn%VERSION%\bin to your %PATH%
    (a logoff or reboot maybe required)
 6. copy mod_authz_svn.so and mod_dav_svn.so from c:\wamp\bin\svn\svn%VERSION%\bin
    to c:\wamp\bin\apache\apache2.2.11\modules
 7. copy one of the template svn.conf files to c:\wamp\alias and edit as needed
 8. create the folder c:\svn if it doesn't already exist
 9. copy or create any svn repositories to that directory if needed
 10. restart Wamp

 * NOTE: you could use one of the subversion installers. Zip files are used
   so files can be kept consistant with Wamp naming conventions and install
   locations

Using the Installer:
 usage: installer.bat

 Currently the installer is a work in progress. For installer to work first do the following
 1. create a folder called "temp" in the "installer" directory
 2. manually download the binary files for svn
 3. run the installer
 4. restart wampserver (may even need to log out or reboot first)


TODO:
 * section on troubleshooting
 * integration with wampserver manager menu on systray
 * SSL encryption
 * virtual hosting (svn.*)
 * improved logging (http://svnbook.red-bean.com/en/1.5/svn.serverconfig.httpd.html)
 * user authentication

FIXME:
 * spelling/capitalization check on all files
