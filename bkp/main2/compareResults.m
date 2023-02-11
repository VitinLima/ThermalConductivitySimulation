fdisp(program.logger, 'Compare results script initiated.');
tic;

cd(program.working_directory);

FID = fopen("NodeResults.txt");

if FID==-1
  fdisp(program.logger, ['Compare results script finilized. No results to compare. Execution time: ', num2str(toc), ' s']);
  cd(program.pwd);
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

cd(program.pwd);

fdisp(program.logger, ['Mean error: ', num2str(mean(abs(U-UA)))]);
fdisp(program.logger, ['Std: ', num2str(std(abs(U-UA)))]);

fdisp(program.logger, ['Compare results script finilized. Execution time: ', num2str(toc), ' s']);