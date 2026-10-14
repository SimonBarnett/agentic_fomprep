# How To - Reset Skoprio Datalogic X3

- **Source:** `How To - Reset Skoprio Datalogic X3.docx`

Reset Skorpio Datalogic X3

Warm Boot: A warm boot closes all applications, clears the working RAM, but preserves the file system and registry. If an application, "hangs" initiate a warm boot to terminate the application.

To perform a warm boot, press and hold the following keys simultaneously:

Cold Boot: A cold boot is a complete reset of the Skorpio in which all applications are forcibly closed and RAM is completely cleared. Registry is restored from persistent memory if a saved copy is available (see 3.7.2) and RAM file system completely erased. You will lose any applications and data (registry too) which are not stored in persistent flash memory. A cold boot is necessary when the Windows CE operating system locks up and the warm boot command does not work.

I suggested both of the warm and cold reboots and if it is still not working, as per your screenshot attached.

There is a clean boot you can still do, however it will wipe everything, all the software etc.

To perform a cold boot, do the following steps:

1. Turn off the Skorpio X3 by pressing the ON/OFF Power button.

2. Pull the battery latch down and remove the battery pack.

3. Simultaneously press the SCAN key and the Reset button in the battery compartment.

4. Insert the battery pack.

5. Turn on the Skorpio X3 by pressing the ON/OFF Power button.

Clean Boot: A clean boot is a cold boot that causes the device to be restored to factory configuration. The Skorpio will reset to its factory configuration, clear the working RAM and initialize the file system. You will lose any applications and data stored in persistent flash memory. At the next startup the system will ask to recalibrate the touch screen.

1. Perform a cold boot.

2. Quickly release all the keys when the screen goes black.

3. Within 1 second, press and hold down [ESC]+[0] keys until the left orange LED starts blinking.

4. Release [ESC] and [0] keys.

5. Enter 1 to proceed with the clean boot sequence. Enter 0 to cancel the clean boot and proceed with a cold boot.
