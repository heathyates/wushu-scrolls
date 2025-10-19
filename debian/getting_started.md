# Getting Started with Debian Packages

## Introduction
Debian packaging allows developers to distribute software in a structured and maintainable way using `.deb` files. This guide walks you through setting up your environment, preparing a package, and using `dpkg-buildpackage` to generate a Debian package.

## Prerequisites
Ensure that your system is running a Debian-based distribution (such as Debian or Ubuntu) and that you have the necessary tools installed.

## Quick Start 
First run `lsb_release -a` to figure out what linux distribution you have. Second, make sure you update everything with `sudo apt update & sudo apt upgrade`. 


### Install Essential Packaging Tools for Debian 
The following is a quick guide to getting going. Run `sudo apt update && sudo apt install dpkg-dev devscripts build-essential fakeroot`. 
Please be sure to use `Y` to the prompt(s).

1. dpkg-dev - This provides the packing tools including `dpkg-buildpackage`
2. devscripts - This is a collection of scripts helpful for packaging tasks 
3. build-essential - This includes compilers and essential build tools (like GCC and Make)
4. fakeroot - Simulates a root environment, which is convenient for building a package without actual root priviledges 

## Installation of a debian package
If you are in the root of a project or source code that can create a debian package, run this command: 
```
dpkg-buildpackage -us -uc
```

## Unmet dependencies 
This is such a common and sometimes annoying exception with debian packages. Here is a manual fix. 

Suppose, for example, you see the following exception when installing a package:
```
dpkg-checkbuilddeps: error: Unmet build dependencies: debhelper (>= 12)
```

Here is how to move past it: 
```
sudo apt update
sudo apt install debhelper
```

