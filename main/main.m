close all;
clear all;
clc;

program.pwd = fileparts(mfilename('fullpath'));
cd(program.pwd);

if length(argv()) > 0
  if strcmp(argv(){1}, '--gui')
    program.is_gui = true;
    preSetup = false;
    setup;
  elseif strcmp(argv(){1}, 'pre-setup')
    program.is_gui = false;
    preSetup = true;
    setup;
    return;
  else
    load([argv(){1}, filesep, 'settings']);
  end
else
  disp('No working directory given');
  return;
end

if strcmp(program.logger,'stdout')
  program.logger = stdout;
else
  program.logger = fopen(program.logger, 'w');
end
if program.logger==-1
  disp('Invalid log stream');
  disp([program.working_directory, 'log.txt']);
  return;
end

fdisp(program.logger, 'All working fine');

program.pwd = fileparts(mfilename('fullpath'));

fdisp(program.logger, 'Main script initiated.');
[~, mainStartTime, ~] = cputime;

program.utd = false;

cd([program.pwd, filesep, 'Loaders']);
  loadFile;
cd(program.pwd);

elementTypeToElementFaceNodeIndices;
CalculateElementFaceArea;

##buildFaces;
buildSystem;
buildBoundaryConditions;
solveSystem;
##compareResults;

[~, mainStopTime, ~] = cputime;
fdisp(program.logger, ['Main script finilized. Execution time: ', num2str(mainStopTime - mainStartTime), ' s']);

fdisp(program.logger, ['Number of nodes: ', num2str(rows(program.analysis.Nodes))]);
fdisp(program.logger, ['Number of elements: ', num2str(rows(program.analysis.ElementNodeIds))]);
fdisp(program.logger, ['Minimum temperature: ', num2str(min(program.analysis.U))]);
fdisp(program.logger, ['Maximum temperature: ', num2str(max(program.analysis.U))]);

exportResults;

if program.logger != stdout
  fclose(program.logger);
end

if program.save_path != -1
  save(program.save_path, 'program');
end