CopyBuffer
==========

This is a small app that reads a text file and copies the entry of the text file to the copy buffer of windows.

Use it in conjunction with [WatchFolder](http://leelusoft.blogspot.in/2011/10/watch-4-folder-23.html) and Dynavox Compass Software to get around the lack of computer control currently existing in Compass.

##How-to install

1. Download the [CopyBuffer.exe](https://s3-eu-west-1.amazonaws.com/script-exes/CopyBuffer.exe) - Place in a suitable directory e.g. C:/CopyBuffer
2. Download WatchFolder (the [portable version](http://leelusoft.altervista.org/alterpages/files/W4F25Free.zip) is fine - by all means place it in the same directory as CopyBuffer as above). 
3. Create a Directory in My Documents "CopyBuffer" and write a text file called "CompassCopy.txt" in there. It doesn't need to have anything in it. i.e.
    ``C:\Users\TobiiUser\Documents\CopyBuffer\CompassCopy.txt``
4. Create your action in WatchFolder. It should have:
    - The folder to watch is the directory you set in 3. i.e. C:/Users/TobiiUser/Documents/CopyBuffer
    - "Execute a program or batch or script:" - set to the C:/CopyBuffer/CopyBuffer.exe 
    - Tick "Add changed object name as argument" and select "File Change - file name"
    - If you want a little notification to tell you that it successfully copied the message window text also select "Show desktop alert"
    - Hit Apply. 
    - Hit Tray
    
    ![Imgur](http://i.imgur.com/xI45ZaCm.png)
    
5. In Compass you now need to create an action. You can copy and paste the following text if you wish - but do remember to use the same file paths as mentioned above:
    ``WriteTextToFile("C:\Users\TobiiUser\Documents\CopyBuffer\CompassCopy.txt",GetMessageWindowText(),FALSE)``
    
    ![Imgur](http://i.imgur.com/wAf1gDOm.png)
    ![Imgur](http://i.imgur.com/gHEFZ1Fm.png)
    
##Notes

1. This is a 32 bit build ready for Tobii iSeries devices. There is also a [64 bit version](https://s3-eu-west-1.amazonaws.com/script-exes/CopyBuffer64.exe) but I haven't tested this much.
2. I will make this into its own service/installer to remove all the steps above.. If we need to. 
