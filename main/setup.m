if program.is_gui
  program.working_directory = uigetdir(pwd, 'Select working directory');
else
  if preSetup
    program.working_directory = argv(){2};
  else
    program.working_directory = argv(){1};
  end
end

if isnumeric(program.working_directory)
  if program.is_gui
    disp('Simulation cancelled.');
    return;
  else
    error('Simulation cancelled.');
  end
end
if !isfolder(program.working_directory)
  if program.is_gui
    disp('No working directory given');
    return;
  else
    error('No working directory given');
  end
end

BTN = questdlg(['Create log file at "', program.working_directory, '"?'], 'Log file');
if strcmp(BTN, 'Yes')
  program.logger = [program.working_directory, filesep, 'log.txt'];
elseif strcmp(BTN, 'No')
  program.logger = 'stdout';
else
  if program.is_gui
    disp('No working directory given');
    return;
  else
    error('Simulation cancelled.');
  end
end

[FNAME, FPATH, ~] = uiputfile([], 'Save program as', [program.working_directory, filesep, 'EngSystem']);
if !isnumeric(FPATH) && !isnumeric(FNAME)
  program.save_path = [FPATH, filesep, FNAME];
else
  program.save_path = -1;
  disp('Simulation will not be saved.');
end

if preSetup
  save([program.working_directory, filesep, 'settings'], '-binary', 'program');
end