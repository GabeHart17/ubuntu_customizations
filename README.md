# About this repo
I run Ubuntu as my daily driver OS on latops. Here are some ways I make it work best for me. My laptops have Intel CPUs and NVIDIA GTX graphics. This is a log of tips, tricks, tools, and fixes that I want to remember for reference when setting up systems in the future. **NOTE: Any file in this repo with a name like `dot_xyz` is a dotfile and should be renamed to `.xyz` when used.**

BIOS fixes
===
Some quick things to check when troubleshooting boot issues.
* Make sure Secure Boot is disabled. Otherwise, you won't be able to boot from the installer USB.
* GRUB should come first in the boot order. If you are dual booting and want to boot to Windows, you'll be able to select it from GRUB.

Nvidia drivers
===
Using Nvidia's drivers
---
For the time being, I've found Nvidia's proprietary drivers to work better than Noveau. To use Nvidia's drivers, open **Software & Updates** and go to the **Additional Drivers** tab. Select the correct driver, apply changes, and restart.

Crashes caused by driver issues
---
When you first install Ubuntu, it may crash after booting up or fail to fully boot correctly due to missing graphics drivers. To fix this, enter the GRUB menu on start, boot to recovery mode (which should start correctly), and install the drivers.

Screen tearing
---
I have found some screen tearing problems when using Nvidia graphics. To check for screen tearing, try dragging a window sideways really fast. This can be fixed by enabling *kernel modesetting*. To check if kernel modesetting is enabled, `sudo cat /sys/module/nvidia_drm/parameters/modeset`. It will say `Y` if it is enabled and `N` if it isn't. To enable it, follow these steps:
1. Create or edit the file `/lib/modprobe.d/nvidia-kms.conf`, and change its contents to `options nvidia-drm modeset=1`.
2. `sudo update-initramfs -u`
3. Restart

Gnome customizations
===
* **gnome-tweaks** - I use this to add the day of the week to the clock in the status bar and a percentage next to the battery indicator.

Other customizations
===
Bashrc customizations
---
The last line of my `.bashrc` is `source .my_bashrc`. `.my_bashrc` has comand aliases, xbindkeys setup, and any other customizations I would want in my bashrc. This way, I can back up, transfer, and restore them easily without having to worry about the rest of the bashrc.

Show thumbnails for raw images 
---
Note that this will make Nautilus slower when loading thubnails. Set the contents of `/usr/share/thumbnailers/gdk-pixbuf-thumbnailer.thumbnailer` to those of the file by the same name in this repo. (Thumbnailer config from https://gist.github.com/h4cc/13450db3d4a7457f9b38)

Disable Logitech C920 autofocus when plugged in
---
This is easy to do from the terminal using `v4l2-ctl`, but it's a pain to have to do it every time. Place the files `c920.rules` in `/etc/udev/rules.d` and `c920_focus.sh` in `/usr/local/bin`. Make `c920_focus.sh` executable. Autofocus occasionally comes back on; run `c920_focus.sh` manually to fix when needed.

Useful tools
===
Small utilities and other odds and ends.
* **rsync** (installed by default) - backup and sync utility. 
* **terminator** - a better terminal that lets you have multiple terminals in one window. 
* **lm-sensors** - `sensors` command lets you easily view CPU thermal information (and fan speed on some systems).
* **htop** - terimal-based system resource utilization monitor and process manager. Better than `top`.
* **xbindkeys** - for creating key commands and macros. I use it for remapping extra mouse buttons. `.xbindkeysrc` has my remaps for the two extra buttons on my Logitech MX Master 3s to copy and paste.
* **xclip** - terminal interface for clipboard. See the alias in `.my_bashrc` for how to make it use the system clipboard.
* **GParted** - disk partition management
* **v4l-utils** - `v4l2-ctl` can be used to control webcam drivers

Handy apps
=== 
Free applications for common needs.
* **Okular** - better PDF viewer
* **VLC Media Player** - play a variety of different multimedia formats
* **Nomacs** - image viewer that supports more file formats than the stock one. Downside: no color management, so images may look a bit different than expected
