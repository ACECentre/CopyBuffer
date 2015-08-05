CopyBuffer
==========

This is a small app that reads a text file and copies the entry of the text file to the copy buffer of windows.

Use it in conjunction with [WatchFolder](http://leelusoft.blogspot.in/2011/10/watch-4-folder-23.html) and Dynavox Compass Software to get around the lack of computer control currently existing in Compass.

##How-to install

1. Download and run the installer: [CopyBuffer.exe](https://s3-eu-west-1.amazonaws.com/script-exes/CopyBuffer.exe)
2. Create your action in WatchFolder. It should have:
    - The folder to watch is the directory you set in 3. i.e. C:/Users/TobiiUser/Documents/CopyBuffer
    - "Execute a program or batch or script:" - set to the C:/CopyBuffer/CopyBuffer.exe
    - Tick "Add changed object name as argument" and select "File Change - file name"
    - If you want a little notification to tell you that it successfully copied the message window text also select "Show desktop alert"
    - Hit Apply.
    - Hit Tray

    ![Imgur](http://i.imgur.com/xI45ZaCm.png)

3. In Compass you now need to create an action. You can copy and paste the following text if you wish - but do remember to use the same file paths as mentioned above:
    ``WriteTextToFile("C:\Users\TobiiUser\Documents\CopyBuffer\CompassCopy.txt",GetMessageWindowText(),FALSE)``

    ![Imgur](http://i.imgur.com/wAf1gDOm.png)
    ![Imgur](http://i.imgur.com/gHEFZ1Fm.png)

##Notes

1. This is a 32 bit build ready for Tobii iSeries devices. IT *WON'T* run on 64 bit machines.
2. The installer writes registry keys to "Run" the WatchFolder application at boot. I haven't written a delete for the registry keys yet!
