fdisp(program.logger, 'Load analysis script initiated.');
tic;

mesh_file = [program.working_directory, filesep, "Meshing"];
fdisp(program.logger, ["Loading mesh from file ", mesh_file]);
FID = fopen(mesh_file, 'r');

fdisp(program.logger, 'Detecting file format');
l = fgetl(FID);
if strcmp(l, 'ANSYS ASCII')
  fclose(FID);
  fdisp(program.logger, 'Initiating ANSYS ASCII file loader');
  ANSYS_ASCII_loader;
elseif strcmp(l, 'ANSYS BIN')
  fclose(FID);
  fdisp(program.logger, 'Initiating ANSYS Binary file loader');
  ANSYS_BIN_loader;
else
  fdisp(program.logger, 'File format unknown');
  program.status = -1;
  return;
end
