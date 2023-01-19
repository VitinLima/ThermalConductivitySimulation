close all;
clear all;
clc;

##if !yes_or_no("All cleared. Proceed?\n");
##	return;
##end

programPWD = pwd;
problemDir = uigetdir('', 'Select problem directory to run:');

disp('Main script initiated.');
[~, mainStartTime, ~] = cputime;

utd = false;
loadASCIIFile;
##buildFaces;
buildSystem;
buildBoundaryConditions;
solveSystem;
compareResults;

[~, mainStopTime, ~] = cputime;
disp(['Main script finilized. Execution time: ', num2str(mainStopTime - mainStartTime), ' s']);

disp(['Number of nodes: ', num2str(rows(N))]);
disp(['Number of elements: ', num2str(rows(E))]);
disp(['Minimum temperature: ', num2str(min(U))]);
disp(['Maximum temperature: ', num2str(max(U))]);

findExternalFaces;