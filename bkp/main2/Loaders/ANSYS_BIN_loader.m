while (l = fgetl(FID)) != -1 || isempty(l)
	if isempty(l)
		continue;
	end
	l = strsplit(l, ',');
  CMD = cell2mat(l(1));
  if strcmp(CMD, 'Nodes')
    disp('Reading nodes');
    N_nodes = str2double(cell2mat(l(2)));
    %[val, count] = fread(FID, N_nodes, 'int');
    [val, count] = fread(FID, [3, N_nodes], 'double');
    program.analysis.Nodes = val';
  end
  if strcmp(CMD, 'Elements')
    disp('Reading elements');
    N_elements = str2double(cell2mat(l(2)));
    [val, count] = fread(FID, N_elements, 'int');
    program.analysis.ElementIds = val';
    C = textscan(FID, '%s', N_elements);
    program.analysis.ElementTypes = C;
    [val, count] = fread(FID, N_elements, 'double');
    program.analysis.ElementAreas = val;
    [val, count] = fread(FID, N_elements, 'double');
    program.analysis.ElementVolumes = val;
    [val, count] = fread(FID, [4, N_elements], 'int');
    program.analysis.ElementNodeIds = val';
    [val, count] = fread(FID, [3, N_elements], 'double');
    program.analysis.ElementCentroids = val';
  end
end
fclose(FID);

fdisp(program.logger, "Step 2: Reading boundary conditions.");

FID = fopen([program.working_directory, filesep, "BoundaryConditions"]);

program.analysis.BoundaryConditions = struct( ...
  'Name', {}, ...
  'GeometrySelection', {}, ...
  'GeometryDefineBy', {}, ...
  'Type', {}, ...
  'Magnitude', {}, ...
  'CoefficientValue', {}, ...
  'TemperatureValue', {}, ...
  'RadiationType', {}, ...
  'ElementType', {}, ...
  'Size', {}, ...
  'Info', {}, ...
  'Targets', {});

while (l = fgetl(FID)) != -1 || isempty(l)
	if isempty(l)
		continue;
	end
	l = strsplit(l, ',');
  CMD = cell2mat(l(1));
  if strcmp(CMD, 'BC')
    program.analysis.BoundaryConditions(end+1).Name = cell2mat(l(2));
  elseif strcmp(CMD, 'GeometrySelection')
    program.analysis.BoundaryConditions(end).GeometrySelection = cell2mat(l(2));
    if strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'GeometryEntities')
      N_geometry_entities = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).Type = {};
      program.analysis.BoundaryConditions(end).Size = {};
      program.analysis.BoundaryConditions(end).Targets = {};
      for i = 1:N_geometry_entities
        l = strsplit(fgetl(FID), ',');
        geometry_type = cell2mat(l(1));
        if strcmp(geometry_type, 'GeoBody')
          program.analysis.BoundaryConditions(end).Type(end+1) = {'Elements'};
        elseif strcmp(geometry_type, 'GeoFace')
          program.analysis.BoundaryConditions(end).Type(end+1) = {'Nodes'};
        elseif strcmp(geometry_type, 'GeoEdge')
          program.analysis.BoundaryConditions(end).Type(end+1) = {'Nodes'};
        elseif strcmp(geometry_type, 'GeoVertex')
          program.analysis.BoundaryConditions(end).Type(end+1) = {'Nodes'};
        end
        N_entities = str2double(cell2mat(l(2)));
        program.analysis.BoundaryConditions(end).Size(end+1) = {N_entities};
        C = textscan(FID, "%d", N_entities);
        program.analysis.BoundaryConditions(end).Targets(end+1) = C;
      end
    elseif strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'MeshElements')
      N_elements = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).Size = N_elements;
      [VAL, COUNT, ERRMSG] = fscanf(FID, "%d", N_elements);
      program.analysis.BoundaryConditions(end).Targets = VAL;
    elseif strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'MeshElementFaces')
      N_faces = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).Size = N_faces;
      C = textscan(FID, "%d,%d,%d %d %d", N_faces);
      program.analysis.BoundaryConditions(end).Targets = cell2mat(C);
    elseif strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'MeshNodes')
      N_nodes = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).Size = N_nodes;
      [VAL, COUNT, ERRMSG] = fscanf(FID, "%d", N_nodes);
      program.analysis.BoundaryConditions(end).Targets = VAL;
    end
  elseif strcmp(CMD, 'Magnitude')
    program.analysis.BoundaryConditions(end).Magnitude = str2double(cell2mat(l(2)));
  elseif strcmp(CMD, 'CoefficientValue')
    program.analysis.BoundaryConditions(end).CoefficientValue = str2double(cell2mat(l(2)));
  elseif strcmp(CMD, 'TemperatureValue')
    program.analysis.BoundaryConditions(end).TemperatureValue = str2double(cell2mat(l(2)));
  elseif strcmp(CMD, 'RadiationType')
    program.analysis.BoundaryConditions(end).RadiationType = str2double(cell2mat(l(2)));
  end
end

fclose(FID);

cd(program.pwd);

fdisp(program.logger, ["Load file script finilized. Execution time: ", num2str(toc), " s"]);