What's this?
===
These are things I need to look into more, or notes on things I have researched. Got info on somethign in this document? Let me know!

Tools and Settings
===

Kernel DMA Protection
---
* bios option (on my thinkpad)
* related to security flaw in Thunderbolt that allows "direct memory access" (DMA) with physical access
* enabling DMA protection disables some other bios options, including:
  * Intel virtualization options
  * Thunderbolt security modes

`boltctl`
---
* command line tool for managing Thunderbolt devices

Occurrences
===

Display Changes With Update on 2021-06-02
---
What happened:
* many packages had updates (ubuntu 20.04 LTS)
  * moved from kernel 5.8 to 5.10 according to `/var/log/apt/history.log`
* external display stopped being recognized over USB-C
* black screen after waking from suspend (such as closing and opening lid)
* machine would freeze when USB-C display plugged in
  * occasional mouse movements would be registered
  * no other input would be registered

Actions taken:
* moved to Nvidia driver version 465 from 460
  * fixed black screen after suspend
  * fixed freezing
  * have not tested to see if black screen is also fixed when on integrated graphics
* changed grub settings to show grub menu and startup messages
* switched to using external monitor over HDMI
  * X1 Extreme has 4k 60Hz available over HDMI, so no problem
  * more bandwidth available for monitor's USB hub over USB connection, mouse can operate through monitor hub effectively
  * **did not solve USB display problem, but for now, this is actually a better configuration**

Still need to investigate:
* can something be done to connect to monitor using `boltctl` after it is plugged in?
* what are the effects of changing Thunderbolt 3 security modes in bios?
