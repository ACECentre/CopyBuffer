import sys

sFile = str(sys.argv[1])
f = open (sFile,'r')
data = f.read()

from Tkinter import Tk
r = Tk()
r.withdraw()
r.clipboard_clear()
r.clipboard_append(data)
r.destroy()
