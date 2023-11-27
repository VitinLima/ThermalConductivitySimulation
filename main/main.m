close all;
clear all;
clc;

## A working directory must be passed in the input arguments (argv)
## This directory is used for temporary files, exporting the problem
## to be solved and importing back the solution

function program = new_program()
  program = struct();

  program.pwd = fileparts(mfilename('fullpath'));
  cd(program.pwd);

  program.is_gui = false;
  program.preSetup = false;
  program.save_path = -1;
  program.direct_solve = true;
  program.logger_type = 'stdout';
  program.logger_file = -1;
  program.setup_ok = false;
end

program = new_program();

if length(argv()) > 0
  if strcmp(argv(){1}, '--gui')
    program.is_gui = true;
    preSetup = false;
    setup;
  elseif strcmp(argv(){1}, '--pre-setup')
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

if strcmp(program.logger_type,'stdout')
  program.logger = stdout;
elseif strcmp(program.logger_type,'file')
  program.logger = fopen(program.logger_file, 'w');
end
if program.logger==-1
  disp('Invalid log stream');
  disp([program.working_directory, 'log.txt']);
  return;
end

try
  if program.setup_ok
    fdisp(program.logger, 'All working fine');
  else
    fdisp(program.logger, 'Setup was cancelled');
    if strcmp(program.logger_type, 'file')
      fclose(program.logger);
    endif
    return;
  end

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
catch
  le = lasterror;
  fdisp(program.logger, ["error: ", le.message]);
##  fdisp(program.logger, le.identifier);
  fdisp(program.logger, "error: called from");
  for i = 1:length(le.stack)
    lei = le.stack(i);
    error_message = ["    ", lei.name, " at line ", num2str(lei.line), " column ", num2str(lei.column)];
    fdisp(program.logger, error_message);
  end
  if strcmp(program.logger_type, 'file')
    fclose(program.logger);
  endif
end_try_catch
