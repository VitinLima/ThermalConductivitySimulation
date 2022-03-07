disp('Load file script initiated.');
tic;

cd(problemDir);

disp('Step 1: Counting number of nodes.');

FID = fopen("Nodes.txt");

N = -1;

while (l = fgetl(FID)) != -1
	N++;
end

disp('Step 2: Allocating memory and reading node positions.');

fseek(FID, 0);

name = fgetl(FID);

N = zeros(N,3);
k = 1;

while (l = fgetl(FID)) != -1
	l(l==',') = '.';
	l = strsplit(l, '\t');
	N(k++,:) = [str2double(l(2)), str2double(l(3)), str2double(l(4))];
end

fclose(FID);

disp('Step 3: Counting number of elements.');

FID = fopen("Elements.txt");

E = -1;

while (l = fgetl(FID)) != -1
	E++;
end

disp('Step 4: Allocating memory and reading element nodes.');

fseek(FID, 0);

name = fgetl(FID);

E = zeros(E, 4);
k = 1;

while (l = fgetl(FID)) != -1
	l = strsplit(l, '\t');
	E(k++,:) = [str2double(l(3)), str2double(l(4)), str2double(l(5)), str2double(l(6))];
end

fclose(FID);

disp('Step 5: Reading named selections.');

FID = fopen("NamedSelections.cdb");

BC = struct('name', {}, 'type', {}, 'value', {}, 'elementType', {}, 'size', {}, 'targets', {});

while (l = fgetl(FID)) != -1 || isempty(l)
	if isempty(l)
		continue;
	end
	l = strsplit(l, ',');
	BC(end+1).name = cell2mat(l(2));
	BC(end).elementType = cell2mat(l(3));
	BC(end).size = str2double(l(4));
	BC(end).targets = zeros(1,BC(end).size);
	k = 0;
	while k < BC(end).size && (l = fgetl(FID)) != -1
		l = str2double(strsplit(l, ' '));
		BC(end).targets([1:columns(l(2:end))]+k) = l(2:end);
		k+=columns(l(2:end));
	end
end

fclose(FID);

disp('Step 5: Reading boundary conditions.');

FID = fopen('BoundaryConditions.txt');

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

disp(['Load file script finilized. Execution time: ', num2str(toc), ' s']);