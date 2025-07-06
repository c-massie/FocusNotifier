# Focus Notifier

Focus Notifier Is a KWin script, service, and tool allowing access to information about the currently focused window.

This works for KDE only, and works across Wayland and X11.

This was intended to facillitate scripting with tools such as [ydotool](https://github.com/ReimuNotMoe/ydotool). (e.g. this will allow you to fire different input with ydotool depending on which program is in focus.)

## Installation

This is available [through the KDE store](https://store.kde.org/p/2300097) and should be able to be installed through the "Get New Scripts" button in "Window Management -> KWin Scripts" in the system settings. You may also install the kwin script manually by downloading this folder and placing it in `~/.local/share/kwin/scripts/`.

Once installed, it should be enabled through the "Window Management -> KWin Scripts" view in the system settings.

Once installed and enabled, navigate to `~/.local/share/kwin/scripts/` and run the install.sh file. This will install the service and the `activewindow` command.

To uninstall, navigate to `~/.local/share/kwin/scripts/` run the uninstall.sh file, and disable and possibly delete the KWin script through the "Window Management -> KWin Scripts" view in the system settings.

## How to use

Once installed, you should be able to run the command `activewindow`.

`activewindow` has the following subcommands:

- `help`
- `get`
- - `pid` (the process ID)
- - `pname` (the process name)
- - `name` (the window name)
- - `class` (the window class)
- - `caption` (the window's titlebar text, if applicable)
- `addchangelistener <bash script filepath>`
- `removechangelistener <bash script filepath>`
- `clearchangelisteners`

`addchangelistener` and `removechangelistener` register and deregister bash scripts at the given path to be executed when the active window changes. `clearchangelisteners` deregisters all bash scripts.

## How it works

The KWin script listens to when focus is changed. It sends this information over DBus, which is then listened to by the listener script, which is run as a systemd service. The listener script stores this information in temp files, which can then be retrieved using the `activewindow` command.

The commands to manage listeners store absolute filepaths in ~/.config/FocusNotifier/listeners.txt. When the active window changes, each extant file referenced in that list is executed sequentially (using `bash <file>`) after information about the active window has been saved. (Meaning you can use the `activewindow` command in those scripts)
