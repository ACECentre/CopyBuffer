CopyBuffer
==========

This is a small app that reads a text file and copies the entry of the text file to the copy buffer of windows.

It's a (very) small python script that reads the contents of a text file and puts it into the operating systems copy buffer. To make this all work nicely Dynavox Compass needs to write to a text file - and that text file is monitored by a application called [WatchFolder](http://leelusoft.blogspot.in/2011/10/watch-4-folder-23.html). Its a bit messy but once its setup it should be reliable!!

## How-to install

1. Download and run the installer: [CopyBuffer.exe](https://s3-eu-west-1.amazonaws.com/script-exes/CopyBuffer.exe)
2. Open WatchFolder (Start Menu -> CopyBuffer -> WatchFolder). Hit minimise (Tray)
3. In Compass you now need to create the "Copy Workspace" action. Find an empty cell and modify that cell by adding an action. You need the  "WriteTextToFile" action which is in "System". Once selected it will ask you to select a file. Select
``C:\Users\TobiiUser\Documents\CopyBuffer\CompassCopy.txt``
You then select what text gets written. To do this you need to another (sub) action; Hit the blue function button to access the GetMessageWindowText() function (just search for it). The last part you need to set to "False".
So your whole action should be:

    ``WriteTextToFile("C:\Users\TobiiUser\Documents\CopyBuffer\CompassCopy.txt",GetMessageWindowText(),FALSE)``

    ![Imgur](http://i.imgur.com/gHEFZ1Fm.png)
    ![Imgur](http://i.imgur.com/wAf1gDOm.png)

4. Create a shortcut to "WatchFolder" to your startup folder of windows. (For some reason the installer isn't creating this shortcut reliably..)

## Notes

1. This is a 32 bit build ready for Tobii iSeries devices. IT *WON'T* run on 64 bit machines.
2. Dear Tobii. Please fix Copy() and Paste() functionality :)
