# NVIDIA Jetson Documentation 

## Table of Contents
1. [Introduction](#introduction)
2. [Jetson Statss](#jetson-stats)

## Introduction
This document is for how to work with the [Jetson Orin NX 16GB](https://www.seeedstudio.com/reComputer-J4012-p-5586.html). 

## Jetson Stats 

The following is how to install [jetson stats](https://github.com/rbonghi/jetson_stats). First, let us run this command: 
`sudo pip install -U jetson-stats`. If that takes, you can run `jtops` and should see output. In addition, you should
also be able to run the command `jetson_release -v` to see output on hardware, platform, jtop, and more. 

## Jetson Powermode 

For [Jetson powermode](https://docs.nvidia.com/jetson/archives/r35.4.1/DeveloperGuide/text/SD/PlatformPowerAndPerformance/JetsonOrinNanoSeriesJetsonOrinNxSeriesAndJetsonAgxOrinSeries.html#supported-modes-and-power-efficiency), here are the key
powermodes and associated meanings: 

```
0 - "MaxN" (35w)
1 - "10w" (18w)
2 - "15w" (21w)
3 - "20w" (23-24w)

0 - GPUMax NPUMax CPUMax
1 - GPUMin NPUMin CPUMin
2 - GPUMin NPUMax CPUMin
3 - GPUMin NPUMax CPUMax
```

Check the current mode via `sudo /usr/sbin/nvpmodel -q`. 
Change the current mode via `sudo /usr/sbin/nvpmodel -m $ID`. The `$ID` corresponds to a value 0 to 3 as specified above. 
