## What is Backdoor Controller

Backdoor Controller is a `sethc.exe` replacement that attempts to mask the presence of the [well-known backdoor](https://www.raymond.cc/blog/backdoor-reset-administrator-password-add-new-user-windows-7/). If you replace `sethc.exe` with `cmd.exe` (the normal way of installing the backdoor) you can easily tell the system has been comprimised by pressing the <kbd>SHIFT</kbd> key 5 times.

## What does Backdoor Controller do

By replacing `sethc.exe` with `backdoor-controller.exe` you'll get numerous advantages, for example:

- If you press the <kbd>SHIFT</kbd> key 5 times when a user is logged in, the normal sticky keys window will popup (instead of a command prompt window)
- When you press the <kbd>SHIFT</kbd> key 5 on the Windows login screen, you'll see a non-suspicious looking window popup
  - If you select `No` the window will disappear and nothing will happen
  - If you select `Yes` another window will popup asking you to enter the "threshold", in this window you are able to type codes
    - `cmd` - opens a command prompt window ~ a native CMD.exe process (so you don't face the errors that the old one faces)
    - `admin` - toggles the creation / deletion of a administrator user account
    - `uninstall` - uninstalls the backdoor replacing the modified `sethc.exe` with the original
    - `help` - shows all the available options for Backdoor Controller

## Compiling

In order to get the native Windows popup dialogs & convert the batch file to an executable, I used [Bat To Exe Converter](http://www.f2ko.de/en/b2e.php) by [Fatih Kodak](http://www.f2ko.de/en/b2e.php). It's an awesome project, with loads of examples  & excellent documentation.
## Screenshots
![](https://raw.githubusercontent.com/samdenty99/backdoor-controller/master/screenshots/activate.PNG)

![](https://raw.githubusercontent.com/samdenty99/backdoor-controller/master/screenshots/threshold.PNG)

![](https://raw.githubusercontent.com/samdenty99/backdoor-controller/master/screenshots/cmd.PNG)

![](https://raw.githubusercontent.com/samdenty99/backdoor-controller/master/screenshots/admin.PNG)

![](https://raw.githubusercontent.com/samdenty99/backdoor-controller/master/screenshots/admin2.PNG)

![](https://raw.githubusercontent.com/samdenty99/backdoor-controller/master/screenshots/help.PNG)

[![Analytics](https://ga-beacon.appspot.com/UA-85426772-5/backdoor-controller/?pixel)](https://github.com/igrigorik/ga-beacon)
