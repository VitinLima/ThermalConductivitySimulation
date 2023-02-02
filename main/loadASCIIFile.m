disp('Load file script initiated.');
tic;

disp("Step 1: Converting comma to dot in Nodes file");
system([programPWD, "\\batScripts\\commaToDot.bat \"", problemDir, "\\Nodes.txt\" ", problemDir, "\\dotNodes.txt\""]);

disp("Step 2: Loading Nodes");
N = dlmread([problemDir, "\\dotNodes.txt"], '\t', 1, 1);

disp("Step 3: Loading Elements");
E = dlmread([problemDir, "\\Elements.txt"], '\t', 1, 2);

disp("Step 4: Reading named selections.");

FID = fopen([problemDir, "\\NamedSelections.cdb"]);

BC = struct('name', {}, 'type', {}, 'value', {}, 'elementType', {}, 'size', {}, 'info', {}, 'targets', {});

while (l = fgetl(FID)) != -1 || isempty(l)
	if isempty(l)
		continue;
	end
	l = strsplit(l, ',');
	BC(end+1).name = cell2mat(l(2));
	BC(end).elementType = cell2mat(l(3));
	BC(end).size = str2double(l(4));
	BC(end).info = fgetl(FID);
  BC(end).targets = cell2mat(textscan(FID, "%f", BC(end).size));
end

fclose(FID);

disp("Step 5: Reading boundary conditions.");

FID = fopen([problemDir, "\\BoundaryConditions.txt"]);

while (l = fgetl(FID)) != -1
	l = strsplit(l, '_');
	k = 0;
	idx = 0;
	while !k
		if strcmp(BC(++idx).name, cell2mat(l(1)))
			k = 1;
		end
	end
	BC(idx).type = cell2mat(l(2));
	if strcmp(BC(idx).type, "INSULATED")
		BC(idx).value = 0;
	elseif strcmp(BC(idx).type, "CONVECTION")
		BC(idx).value = [str2double(cell2mat(l(3))),str2double(cell2mat(l(4)))];
	else
		BC(idx).value = str2double(cell2mat(l(3)));
	end
end

cd(programPWD);

disp(["Load file script finilized. Execution time: ", num2str(toc), " s"]);