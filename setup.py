# call with python setup.py bdist_msi
import sys
from cx_Freeze import setup, Executable


includes = ["sys","pyperclip"]
"""script is the main script base Win32GUI is for windows"""
exe = Executable(script="CopyBuffer.py",base="Win32GUI")
#version is the program version
setup(version="3.0",
     options={"build_exe":{"includes":includes}},
     executables = [exe])
