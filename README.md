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

Automatically force full composition pipeline
---
The Nvidia `ForceFullCompositionPipeline` option can help alleviate screen tearing and make graphics generally feel smoother. This can be enabled in nvidia-settings, but I've found that saving the settings to an `xorg.conf` file prevents the laptop's internal display from being detected/used when the laptop is restarted. A somewhat hackey work-around is to take the `.force_full_composition.sh` script in this repository and set it to run on startup using Ubuntu's startup applications utility.

Other fixes
===
Fixes for miscellaneous issues that don't fit into another category

Slow sudo
---
If you change your hostname (the name of your device), `sudo` can become slow. The fix is to edit `/etc/hosts` so that the second line has your new hostname instead of the old one. You can find your hostname using the `hostnaame` command.

Firefox hardware acceleration (Nvidia)
--- 
I had some trouble getting Firefox to actually use hardware acceleration; even when "use hardware acceleration when available" was checked in the preferences, it wasn't actually using it. The only solution I've found so far is to *force* it to use hardware acceleration by going to `about:config`, searching for `layers.acceleration.force-enable`, and setting it to `true` using the button on the right with the arrows. After this, you can restart Firefox and make sure it appears in the list of processes given by `nvidia-smi`. Once hardware acceleration was enabled successfully, screen tearing when scrolling and choppiness during video playback were greatly reduced.

Lag when using external display on laptop with DGPU
---
I encountered a lot of GUI lag when using *only* an external display, with the lid of the laptop closed. Setting the graphics to use only the DGPU rather than hybrid graphics seemed to fix this. Interestingly, this has only been an issue on one of the two Ubuntu laptops with Nvidia grpahics that I have owned.

Better audio with bluetooth headsets
---
In order to use a high quality codec while still receiving microphone input, replace PulseAudio with PipeWire. Follow the directions here https://askubuntu.com/questions/1339765/replacing-pulseaudio-with-pipewire-in-ubuntu-20-04

Gnome customizations
===
* **gnome-tweaks** - I use this to add the day of the week to the clock in the status bar and a percentage next to the battery indicator.
* **system76-power** - GUI graphics switching. This comes by default in System76 Pop!\_OS, but can be manually installed as a package and Gnome extension in Ubuntu.
* **pop shell** - More capable window tiling manager for Gnome. Comes with Pop!\_OS by default, but can be instaled manually as a Gnome extension by following the instructions in its git repository.

Other customizations
===
Bashrc customizations
---
The last line of my `.bashrc` is `source .my_bashrc`. `.my_bashrc` has comand aliases, xbindkeys setup, and any other customizations I would want in my bashrc. This way, I can back up, transfer, and restore them easily without having to worry about the rest of the bashrc.

Show thumbnails for raw images 
---
Note that this will make Nautilus slower when loading thubnails. Set the contents of `/usr/share/thumbnailers/gdk-pixbuf-thumbnailer.thumbnailer` to those of the file by the same name in this repo. (Thumbnailer config from https://gist.github.com/h4cc/13450db3d4a7457f9b38)

Disable Logitech C920 (or other webcam) autofocus when plugged in
---
This is easy to do from the terminal using `v4l2-ctl`, but it's a pain to have to do it every time. Place the files `c920.rules` in `/etc/udev/rules.d` and `c920_focus.sh` in `/usr/local/bin`. Make `c920_focus.sh` executable. Autofocus occasionally comes back on; run `c920_focus.sh` manually to fix when needed.

Fingerprint authentication for sudo
---
If your laptop has a fingerprint sensor and you would like to be able to use it to authenticate when using `sudo`, run `sudo pam-auth-update` and mark the fingerprint sensor option.

Useful tools
===
Small utilities and other odds and ends.
* **rsync** (installed by default) - backup and sync utility 
* **terminator** - a better terminal that lets you have multiple terminals in one window 
* **lm-sensors** - `sensors` command lets you easily view CPU thermal information (and fan speed on some systems).
* **htop** - terimal-based system resource utilization monitor and process manager. Better than `top`
* **xbindkeys** - for creating key commands and macros. I use it for remapping extra mouse buttons. `.xbindkeysrc` has my remaps for the two extra buttons on my Logitech MX Master 3s to copy and paste. (Note: my particular xbindkeys commands require `xautomation` to be installed.)
* **xclip** - terminal interface for clipboard. See the alias in `.my_bashrc` for how to make it use the system clipboard
* **GParted** - disk partition management 
* **v4l-utils** - `v4l2-ctl` can be used to control webcam drivers 

Handy apps
=== 
Free applications for common needs.
* **Okular** - better PDF viewer
* **VLC Media Player** - play a variety of different multimedia formats
* **Nomacs** - image viewer that supports more file formats than the stock one. Downside: no color management, so images may look a bit different than expected
* **GIMP** - capable raster graphics and photo editing program
* **RawTherapee** - raw image processing and conversion. Uses side-car files and doesn't modify original images.
