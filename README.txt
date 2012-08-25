Subversion Add-on for WampServer Version 2.2a

Apache version: 2.2.21

About:
 This is an addon for WampServer 2.2a that enables access to Subversion repositories stored in c:\svn

Where to download Subversion:
 The binaries we currently use for the installer are from the Subversion for Windows project on
 sourceforge.net - http://sourceforge.net/projects/win32svn/

Required Addons:

Optionally Required:
 * Python (for language bindings)

Manual install instructions:
 (assumes wamp is already installed and working)

 1. download the zip file listed above
 2. extract the files to a temporary directory
 3. inside of the folder that was extracted you should see a directory named
    svn-win32-%VERSION%
 4. rename this folder to svn%VERSION% and move it to c:\wamp\bin\svn
 5. add c:\wamp\bin\svn\svn%VERSION%\bin to your %PATH%
    (a logoff or reboot maybe required)
 6. copy mod_authz_svn.so and mod_dav_svn.so from c:\wamp\bin\svn\svn%VERSION%\bin
    to c:\wamp\bin\apache\apache2.2.21\modules
 7. copy one of the template svn.conf files to c:\wamp\alias and edit as needed
 8. create the folder c:\svn if it doesn't already exist
 9. copy or create any svn repositories to that directory if needed
 10. restart Wamp

 * NOTE: you could use one of the subversion installers. Zip files are used
   so files can be kept consistant with Wamp naming conventions and install
   locations. The Subversion for windows project currently does not offer zip
   files for versions of Subversion prior to 1.6.11. If you wish to use an
   earlier version you will have to use the MSI installer instead.

Using the Installer:
 usage: installer.bat


TODO:
 * section on troubleshooting
 * integration with wampserver manager menu on systray
 * SSL encryption
 * virtual hosting (svn.*)
 * improved logging (http://svnbook.red-bean.com/en/1.5/svn.serverconfig.httpd.html)
 * user authentication

FIXME:
 * spelling/capitalization check on all files
