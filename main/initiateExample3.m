clear all;
close all;
clc;

example_3_directory = strjoin([strsplit(fileparts(mfilename('fullpath')), filesep)(1:end-1), "examples", "Problem3"], filesep);

## The "--pre-setup" option tells the code that it is configurating some options before the simulation begins
## A file called "settings" will be created in the given directory containing the desired options
## which will be loaded afterwards when the problem has been exported.

system(strjoin({"octave-gui", "--no-gui", "main.m", "\"--pre-setup\"", example_3_directory}, " "));

## In this section the files are written to .txt or .csv files
## The problem to be solved is being exported, including the node positions,
## elements, edges, and boundary conditions and their respective nodes,
## elements or edges.
## Finally, the main script is called once more, giving the name of the
## settings file created in the first steps. This file will be loaded
## and the new files will also be read and the problem will be imported.
## The code will then create the model and solve it numerically through
## the methods configurated.

system(strjoin({"octave-gui", "--no-gui", "main.m", example_3_directory}, " "));
