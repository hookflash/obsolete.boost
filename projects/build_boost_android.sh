#!/bin/sh
echo "Please enter your android ndk path:"
echo "For example:/home/astro/android-ndk-r8e"
read Input
echo "You entered:$Input"

echo "----------------- Exporting the android-ndk path ----------------"

#Set path
export PATH=$PATH:$Input:$Input/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin

#create install directories
mkdir -p ./../../build
mkdir -p ./../../build/android
mkdir -p ./android

echo "----------- Building boost 1.53.0 for ANDROID platform -----------------"

#Boost build
pushd `pwd`
mkdir ./../../build/android/boost
cd ./android
rm -rf *
cp -r ./../android-patches/* .

./build-android.sh --verbose --boost=1.53.0 --with-libraries=atomic,random,regex,graph,chrono,thread,signals,filesystem,system,date_time,program_options,iostreams $Input

popd

echo "----------- Installing boost 1.53.0 for ANDROID platform -----------------"
cp -r ./../../boost/projects/android/build/* ./../../build/android/boost/

#clean
rm -rf ./android
