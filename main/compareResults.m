fdisp(program.logger, 'Compare results script initiated.');
tic;

FID = fopen([program.working_directory, filesep, "Results", filesep, "Temperature"]);

if FID==-1
  fdisp(program.logger, ['Compare results script finilized. No results to compare. Execution time: ', num2str(toc), ' s']);
  return;
end

UA = -1;

while (l = fgetl(FID)) != -1
	UA++;
end

fseek(FID, 0);

name = fgetl(FID);

UA = zeros(UA,1);
k = 1;

while (l = fgetl(FID)) != -1
	l(l==',') = '.';
	l = strsplit(l, '\t');
	UA(k++) = str2double(l(5));
end

fclose(FID);

fdisp(program.logger, ['Mean error: ', num2str(mean(abs(program.analysis.U-UA)))]);
fdisp(program.logger, ['Std: ', num2str(std(abs(program.analysis.U-UA)))]);

fdisp(program.logger, ['Compare results script finilized. Execution time: ', num2str(toc), ' s']);