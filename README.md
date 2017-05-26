# Editing Procedure of NEXRAD radar data
## Prerequisite
Prior to working, make sure that the following packages are installed:
- [Latest Radx Package](https://github.com/NCAR/lrose-core/releases/tag/radx-20170315)

Radx is a package for handling radar and lidar data in radial/polar coordinates
([Instructions from NCAR](https://www.eol.ucar.edu/software/radx))
```terminal
cd Downloads/radx-20160327.macosx_x64 
sudo ./install_bin_release
```
- [Xquartz](https://www.xquartz.org/)
- [Soloii Binary file]()
([Overview of Soloii](http://radarmet.atmos.colostate.edu/software/soloii/index.html))

Before you run it, put the following command in a Terminal so that it can recognize the display:
```terminal
export DISPLAY=:0
```

## Convert data format
We have to convert the format of raw data (ar2v file) to sweep files by performing the command of RadxConvert before running soloii.
```terminal
RadxConvert -dorade -f name.ar2v
```

To show all the commands that we can use inside the Radx package, we can run:
```terminal
RadxConvert -h |more
```

## Unfold the wind field
Before unfolding the wind field, make sure that xquartz is running. 
Type "soloii" in the terminal, so the variables fields can be displyed in your xquartz. 
```terminal
soloii
```
Some algorithms perform pretty well in quality control. To start with, right click "Editor". 


