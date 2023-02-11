FID = fopen([program.working_directory, filesep, 'octTemperature'], 'w');
fprintf(FID, 'Node Number\tTemperature (ºC)\n');
dlmwrite(FID, [program.analysis.NodeIds, program.analysis.U], ',\t', "-append");
fclose(FID);