CopyBuffer
==========

This is a small app that reads a text file and copies the entry of the text file to the copy buffer of windows.

Use it in conjunction with [WatchFolder](http://leelusoft.blogspot.in/2011/10/watch-4-folder-23.html) and Dynavox Compass Software to get around the lack of computer control currently existing in Compass.

##How-to install

1. Download and run the installer: [CopyBuffer.exe](https://s3-eu-west-1.amazonaws.com/script-exes/CopyBuffer.exe)
2. Open WatchFolder (Start Menu -> CopyBuffer -> WatchFolder)
2. Create your action in WatchFolder. Hit the tab "Watch List" and edit the sample. It should have:
    - The folder to watch is the directory you set in 3. i.e. C:/Users/TobiiUser/Documents/CopyBuffer/WatchFolder
    - "Execute a program or batch or script:" - set to the C:/ProgramFiles/CopyBuffer/CopyBuffer.exe (It should just appear!)
    - Tick "Add changed object name as argument" and select "File Change - file name"
    - If you want a little notification to tell you that it successfully copied the message window text also select "Show desktop alert"
    - Hit Apply.
    - Hit "Watch List" and press start on the top sample.
    - Hit Tray

    ![Imgur](http://i.imgur.com/xI45ZaCm.png)

3. In Compass you now need to create an action. You will find the action "WriteTextToFile" which is in "System". After you choose the file you need to choose where it gets the text from. Hit the blue function button to access the GetMessageWindowText() function. You can copy and paste the following text if you wish - but do remember to use the same file paths as mentioned above:
    ``WriteTextToFile("C:\Users\TobiiUser\Documents\CopyBuffer\CompassCopy.txt",GetMessageWindowText(),FALSE)``

    ![Imgur](http://i.imgur.com/gHEFZ1Fm.png)
    ![Imgur](http://i.imgur.com/wAf1gDOm.png)

##Notes

1. This is a 32 bit build ready for Tobii iSeries devices. IT *WON'T* run on 64 bit machines.
2. Dear Tobii. Please fix. (NB: The main code uses pyperclip - a cross platform paperclip library ;) )
