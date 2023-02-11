close all;
clear all;
clc;

if length(argv()) > 0
  if strcmp(argv(){1}, '--gui')
    program.working_directory = 'C:\\Users\\160047412\\Desktop\\workbench\\cubic test\\cubic test_files\\dp0\\SYS\\MECH\\';
    program.logger = stdout;
  else
    program.working_directory = argv(){1};
    program.logger = fopen([program.working_directory, filesep, 'log.txt'], 'w');
  end
else
  disp('No working directory given');
  return;
end

if !isfolder(program.working_directory)
  disp('No working directory given');
  return;
end

fdisp(program.logger, program.working_directory)
fdisp(program.logger, 'All working fine');

program.pwd = pwd;

fdisp(program.logger, 'Main script initiated.');
[~, mainStartTime, ~] = cputime;

program.utd = false;
cd('Loaders');
  loadFile;
cd(program.pwd);
####buildFaces;
##buildSystem;
##buildBoundaryConditions;
##solveSystem;
##compareResults;
##
##[~, mainStopTime, ~] = cputime;
##fdisp(program.logger, ['Main script finilized. Execution time: ', num2str(mainStopTime - mainStartTime), ' s']);
##
##fdisp(program.logger, ['Number of nodes: ', num2str(rows(N))]);
##fdisp(program.logger, ['Number of elements: ', num2str(rows(E))]);
##fdisp(program.logger, ['Minimum temperature: ', num2str(min(U))]);
##fdisp(program.logger, ['Maximum temperature: ', num2str(max(U))]);
##
##exportResults;
if program.logger != stdout
  fclose(program.logger);
end
return;