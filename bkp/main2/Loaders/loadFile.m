fdisp(program.logger, 'Load analysis script initiated.');
tic;

fdisp(program.logger, "Loading mesh");
FID = fopen([program.working_directory, filesep, "Meshing"], 'r');

fdisp(program.logger, 'Detecting file format');
l = fgetl(FID);
if strcmp(l, 'ANSYS ASCII')
  fdisp(program.logger, 'Initiating ANSYS ASCII file loader');
  ANSYS_ASCII_loader;
elseif strcmp(l, 'ANSYS BIN')
  fdisp(program.logger, 'Initiating ANSYS Binary file loader');
  ANSYS_BIN_loader;
else
  fdisp(program.logger, 'File format unknown');
  program.status = -1;
  return;
end