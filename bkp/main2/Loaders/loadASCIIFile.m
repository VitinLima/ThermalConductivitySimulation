fdisp(program.logger, 'Load file script initiated.');
tic;

fdisp(program.logger, "Step 1: Converting comma to dot in Nodes file");
system([program.pwd, "\\batScripts\\commaToDot.bat \"", program.working_directory, "\\Nodes.txt\" ", program.working_directory, "\\dotNodes.txt\""]);

fdisp(program.logger, "Step 2: Loading Nodes");
N = dlmread([program.working_directory, "\\dotNodes.txt"], '\t', 1, 1);

fdisp(program.logger, "Step 3: Loading Elements");
E = dlmread([program.working_directory, "\\Elements.txt"], '\t', 1, 2);

fdisp(program.logger, "Step 4: Reading named selections.");

FID = fopen([program.working_directory, "\\NamedSelections.cdb"]);

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

fdisp(program.logger, "Step 5: Reading boundary conditions.");

FID = fopen([program.working_directory, "\\BoundaryConditions.txt"]);

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

cd(program.pwd);

fdisp(program.logger, ["Load file script finilized. Execution time: ", num2str(toc), " s"]);