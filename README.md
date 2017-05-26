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

## Quality Control of the wind field
Before unfolding the wind field, make sure that xquartz is running. 

Type "soloii" in the terminal, so the variables fields can be displyed in your xquartz. 
```terminal
soloii
```
A window will pop up just like the following image:
![Soloii Display](https://github.com/tingyucha/Edit-NEXRAD-radar-process/blob/master/Soloii_Display.png)
 
Some algorithms perform pretty well in quality control of Doppler velocity. To start with, right click "Editor". 

![Editor Commands](https://github.com/tingyucha/Edit-NEXRAD-radar-process/blob/master/Editor_Commands.png)
The commands of left panel work pretty well in general conditions. Make sure that the commands are in order. It will influence the QC processing if you don't follow the above order. On the other hand, the commands of right panel need  Note that the following three commands are referring to the location of radar, which means that it should calculate according to the local winds near the radar.
```terminal
BB-use-local-wind
ew-wind is [approximate a value near the radar]
ns-wind is [approximate a value near the radar]
```
The above methods can automatically unfold the data. However, you still need to go through all the data manually to make sure the data quality.

To begin with, right click "Examine" button. It will show up like this:
![Examine](https://github.com/tingyucha/Edit-NEXRAD-radar-process/blob/master/Examine.png)
Click on the edit button and manully edit the folded rays. Note that there are some differences between these commands:
1. -Fold and +Fold target to individual point. 
2. -Fold Ray and +Fold Rad target to the whole rays.
3. -Fold Ray > and +Fold Ray > target to the rays after you point a single point.


## Convert all the sweep files to be gridded
After completing editing all wind fields, the data should be converted into cartesian coordinate and be gridded in this step.
1. Run createVolumes.sh in the terminal under the same directory of sweep files[createVolumes.sh](https://github.com/tingyucha/Edit-NEXRAD-radar-process/blob/master/createVolumes.sh)
Run this file can convert all sweep files to cfrad files in the same time.
```terminal
sh createVolumes.sh /DirectoryWhereYouWantPutTheVolumes/
```
Or you can also use one command to convert sweep files to cfrad files:

```terminal
RadxConvert -ag -f swp.* -outdir /DirectoryWhereYouWantPutTheVolumes/
```
Those two methods lead to the same results, so you can choose either one of them to generate cfrad files.

2. Run runsRadx2Grid_script.sh 
Radx2Grid performs coordinate transformations from the polar grid and regrid the radar data to a cartesian coordinate. There are several interpolation methods and gridded parameters that you can choose in the file according to your data.
Before running runsRadx2Grid_script.sh, make sure that download the [Radx2Grid.example.flat.param.txt](https://github.com/tingyucha/Edit-NEXRAD-radar-process/blob/master/Radx2Grid.example.flat.param.txt) and put them in the same directory with cfrad files. 

```terminal
sh runsRadx2Grid_script.sh
```

Also, you can use single command to grid one file:

```terminal
Radx2Grid -f cfrad.yourfile.nc -params Radx2Grid.example.flat.param.txt
```
