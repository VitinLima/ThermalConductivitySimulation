FID = fopen([program.working_directory, filesep, "Meshing"], 'r');

program.waitbar = waitbar(0.0);
while (l = fgetl(FID)) != -1 || isempty(l)
	if isempty(l)
		continue;
	end
	l = strsplit(l, ',');
  CMD = cell2mat(l(1));
  if strcmp(CMD, 'Nodes')
    fdisp(program.logger, 'Reading nodes');
    N_nodes = str2double(cell2mat(l(2)));
    waitbar(0.0, program.waitbar, 'Reading node ids');
    [val, count] = fread(FID, N_nodes, 'int');
    program.analysis.NodeIds = val;
    waitbar(0.5, program.waitbar, 'Reading node positions');
    [val, count] = fread(FID, [3, N_nodes], 'double');
    program.analysis.Nodes = 1000*val';
    waitbar(1, program.waitbar, 'Reading nodes completed');
  end
  if strcmp(CMD, 'Elements')
    fdisp(program.logger, 'Reading elements');
    N_elements = str2double(cell2mat(l(2)));
    waitbar(0.0, program.waitbar, 'Reading element ids');
    [val, count] = fread(FID, N_elements, 'int');
    program.analysis.ElementIds = val';
    waitbar(0.1, program.waitbar, 'Reading element types');
    [val, count] = fread(FID, [2, N_elements], 'int');
    program.analysis.ElementTypes = val;
    waitbar(0.3, program.waitbar, 'Reading element areas');
    [val, count] = fread(FID, N_elements, 'double');
    program.analysis.ElementAreas = 1e6*val;
    waitbar(0.5, program.waitbar, 'Reading element volumes');
    [val, count] = fread(FID, N_elements, 'double');
    program.analysis.ElementVolumes = 1e9*val;
    waitbar(0.7, program.waitbar, 'Reading element node ids');
    [val, count] = fread(FID, [4, N_elements], 'int');
    program.analysis.ElementNodeIds = val';
    waitbar(0.9, program.waitbar, 'Reading element centroids position');
    [val, count] = fread(FID, [3, N_elements], 'double');
    program.analysis.ElementCentroids = 1e3*val';
    waitbar(1, program.waitbar);
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

function s = BC_to_string(bc)
  s = ["Reading Boundary condition\n", ...
    strjoin(fieldnames(bc),',')];
##  'Name ', bc.Name, '\n', ...
##  'GeometrySelection ', bc.GeometrySelection, '\n', ...
##  'GeometryDefineBy', bc.GeometryDefineBy, '\n', ...
##  'Type', bc.Type, '\n', ...
##  'Magnitude', num2str(bc.Magnitude), '\n', ...
##  'CoefficientValue', num2str(bc.CoefficientValue), '\n', ...
##  'TemperatureValue', num2str(bc.TemperatureValue), '\n', ...
##  'RadiationType', bc.RadiationType, '\n', ...
##  'ElementType', bc.ElementType, '\n', ...
##  'Size', bc.Size];
end

while (l = fgetl(FID)) != -1 || isempty(l)
	if isempty(l)
		continue;
	end
	l = strsplit(l, ',');
  CMD = cell2mat(l(1));
  if length(program.analysis.BoundaryConditions)>0
    waitbar(0.9, program.waitbar, BC_to_string(program.analysis.BoundaryConditions(end)));
  end
  if strcmp(CMD, 'BC')
    program.analysis.BoundaryConditions(end+1).Name = cell2mat(l(2));
  elseif strcmp(CMD, 'GeometrySelection')
    program.analysis.BoundaryConditions(end).GeometrySelection = cell2mat(l(2));
    if strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'GeometryEntities')
      N_geometry_entities = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).ElementType = {};
      program.analysis.BoundaryConditions(end).Size = {};
      program.analysis.BoundaryConditions(end).Targets = {};
      for i = 1:N_geometry_entities
        l = strsplit(fgetl(FID), ',');
        geometry_type = cell2mat(l(1));
        N_elements = str2double(cell2mat(l(2)));
        if strcmp(geometry_type, 'GeoBody')
          program.analysis.BoundaryConditions(end).ElementType(end+1) = {'Elements'};
          program.analysis.BoundaryConditions(end).Size(end+1) = {N_elements};
          [val, count] = fread(FID, N_elements, 'int');
          program.analysis.BoundaryConditions(end).Targets(end+1) = {val};
        elseif strcmp(geometry_type, 'GeoFace')
          program.analysis.BoundaryConditions(end).ElementType(end+1) = {'Nodes'};
          program.analysis.BoundaryConditions(end).Size(end+1) = {N_elements};
          [val, count] = fread(FID, N_elements, 'int');
          program.analysis.BoundaryConditions(end).Targets(end+1) = {val};
        elseif strcmp(geometry_type, 'GeoEdge')
          program.analysis.BoundaryConditions(end).ElementType(end+1) = {'Nodes'};
          program.analysis.BoundaryConditions(end).Size(end+1) = {N_elements};
          [val, count] = fread(FID, N_elements, 'int');
          program.analysis.BoundaryConditions(end).Targets(end+1) = {val};
        elseif strcmp(geometry_type, 'GeoVertex')
          program.analysis.BoundaryConditions(end).ElementType(end+1) = {'Nodes'};
          program.analysis.BoundaryConditions(end).Size(end+1) = {N_elements};
          [val, count] = fread(FID, N_elements, 'int');
          program.analysis.BoundaryConditions(end).Targets(end+1) = {val};
        end
      end
    elseif strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'MeshElements')
      N_elements = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).ElementType = {'Elements'};
      program.analysis.BoundaryConditions(end).Size = {N_elements};
      [val, count] = fread(FID, N_elements, 'int');
      program.analysis.BoundaryConditions(end).Targets = {val};
    elseif strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'MeshElementFaces')
      N_faces = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).ElementType = {'Faces'};
      program.analysis.BoundaryConditions(end).Size = {N_faces};
      [val, count] = fread(FID, [5, N_faces], 'int');
      val(2,:) += 1;
      program.analysis.BoundaryConditions(end).Targets = {val'};
    elseif strcmp(program.analysis.BoundaryConditions(end).GeometrySelection, 'MeshNodes')
      N_nodes = str2double(cell2mat(l(3)));
      program.analysis.BoundaryConditions(end).ElementType = {'Nodes'};
      program.analysis.BoundaryConditions(end).Size = {N_nodes};
      [val, count] = fread(FID, N_elements, 'int');
      program.analysis.BoundaryConditions(end).Targets = {val};
    end
  elseif strcmp(CMD, 'Type')
    program.analysis.BoundaryConditions(end).Type = cell2mat(l(2));
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
close(program.waitbar);

cd(program.pwd);

fdisp(program.logger, ["Load file script finilized. Execution time: ", num2str(toc), " s"]);