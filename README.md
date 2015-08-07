CopyBuffer
==========

This is a small app that reads a text file and copies the entry of the text file to the copy buffer of windows.

It uses [WatchFolder](http://leelusoft.blogspot.in/2011/10/watch-4-folder-23.html) to get around the lack of Copy() function in Tobii Dynavox Compass Software.

##How-to install

1. Download and run the installer: [CopyBuffer.exe](https://s3-eu-west-1.amazonaws.com/script-exes/CopyBuffer.exe)
2. Open WatchFolder (Start Menu -> CopyBuffer -> WatchFolder). Hit minimise (Tray)
3. In Compass you now need to create an action. You will find the action "WriteTextToFile" which is in "System". After you choose the file you need to choose where it gets the text from. Hit the blue function button to access the GetMessageWindowText() function. You can copy and paste the following text if you wish - but do remember to use the same file paths as mentioned above:
    ``WriteTextToFile("C:\Users\TobiiUser\Documents\CopyBuffer\CompassCopy.txt",GetMessageWindowText(),FALSE)``

    ![Imgur](http://i.imgur.com/gHEFZ1Fm.png)
    ![Imgur](http://i.imgur.com/wAf1gDOm.png)

4. Pop "WatchFolder" in your startup folder of windows.

##Notes

1. This is a 32 bit build ready for Tobii iSeries devices. IT *WON'T* run on 64 bit machines.
2. Dear Tobii. Please fix Copy() and Paste() functionality :)
