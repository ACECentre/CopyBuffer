import sys
import pyperclip

def getFileContents(sFile):
    f = open (sFile,'r')
    data = f.read()
    f.close()
    return data

sFile = str(sys.argv[1])
data = getFileContents(sFile)
pyperclip.copy(data)
