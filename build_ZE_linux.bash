#!/bin/bash
# WARNING! THIS VERSION IS EARLY AND MAY NOT WORK PROPERLY!
echo "ZE pk3 Compiler for Linux by Vasyan | Early version"
## Variables
export zename="ZGL_ZombieEscape"
export zeversion="2.3"
export zepk3="$zename-v$zeversion.pk3"
export verbose=1
export delump=0
export cdir=$PWD

## Preparing
if [ $verbose == 1 ]
then
echo "Current directory: $PWD"
echo "Compiled PK3 Location: $PWD/bin/$zepk3"
echo "src directory: $PWD/src/"
echo "Tools should be installed on your system (p7zip)"
fi

echo "Testing for installed p7zip"
/usr/bin/7z
if [ $? == 0 ]
then
echo "The p7zip is installed,"
echo "ZE is ready to compile"
else
echo "You have not p7zip installed,"
echo "You can install it by p7zip package"
exit 1
fi

## The main compile part
echo "Packing ./src/ into ./bin/$zepk3"
7z u -tzip "$PWD/bin/$zepk3" -r "$PWD/src/*" -mx5 -up0q0r2x1y2z1
## Textures
echo "Reordering TEXTURES files..."
if [ $verbose == 1 ]
then
echo "Working directory: $PWD"
fi

if [[ "./textures.txt" ]]
then
rm ./textures.txt
fi
7z x "$PWD/bin/$zepk3" TEXTURES.* -y
7z d "$PWD/bin/$zepk3" TEXTURES.*
7z a "$PWD/bin/$zepk3" TEXTURES.*
rm -f TEXTURES.*
cd $cdir/src/
if [ $verbose == 1 ]
then
echo "Working directory: $PWD"
fi
cd $cdir/tools
if [ $verbose == 1 ]
then
echo "Working directory: $PWD"
fi
# Deleted some unimportant things.
#7z rn "$cdir/bin/$zepk3" @textures.txt
#rm textures.txt
echo Done!
exit 0
