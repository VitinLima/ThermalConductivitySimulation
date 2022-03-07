disp('Compare results script initiated.');
tic;

cd(problemDir);

FID = fopen("NodeResults.txt");

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

cd(programPWD);

disp(['Mean error: ', num2str(mean(abs(U-UA)))]);
disp(['Std: ', num2str(std(abs(U-UA)))]);

disp(['Compare results script finilized. Execution time: ', num2str(toc), ' s']);