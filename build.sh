#!/bin/bash
# An extremely primitive Asteroids build script for Windows x86 and x64.

eval $"zip -9 -r Asteroids.love . -x *.git/* /Builds/* build.sh"

eval $"cp Asteroids.love Builds/love-win32"
eval $"cp Asteroids.love Builds/love-win64"

rm Asteroids.love

eval $"cd Builds/love-win32"
eval $"cat love.exe Asteroids.love > Asteroids.exe"
eval $"zip -9 -r Asteroids_x86 Asteroids.exe *.dll license.txt"
eval $"mv Asteroids_x86.zip ../Windows/x86/"

rm Asteroids.love
rm Asteroids.exe
cd ../..

eval $"cd Builds/love-win64"
eval $"cat love.exe Asteroids.love > Asteroids.exe"
eval $"zip -9 -r Asteroids_x64 Asteroids.exe *.dll license.txt"
eval $"mv Asteroids_x64.zip ../Windows/x64/"

rm Asteroids.love
rm Asteroids.exe

