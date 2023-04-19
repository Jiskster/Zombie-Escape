# Information for Linux users #
## Please read this text       #
! Write commands without $

To compile the .pk3 please make sure
that you have p7zip installed, to
check if it's installed write this:
```
$ 7z
```
And if you get some text then you
rightly has the p7zip installed
## How to install p7zip
On Ubuntu/Debian (Linux Mint, KDE Neon and others) write this command:
```
$ sudo apt install p7zip
```
On Arch-based distros (Manjaro, Endeavour and others) write this command:
```
$ sudo pacman -S p7zip
```
On others if you know how to use your package manager install
``` p7zip ``` package.
## FAQ
Q: I can't open the file with Permission error, what do i do?\
A: Give compiler script run permission with command:
```
$ chmod +x ./build_ZE_linux.bash
```
Q: I have some errors after the end of compilation.\
A: Check the result if it's corrupted, if it's not then this is not a real corruption error.
