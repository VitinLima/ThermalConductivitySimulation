close all;
clc;

figure;
hold on;

idxE = 'all';
##idxE = [37, 39, 15, 36, 38, 7];
idxN = 1:rows(program.analysis.Nodes);
idxBC = 4;

choice = [11];

if ischar(idxE)
  if strcmp(idxE, 'all')
    idxE = 1:rows(program.analysis.ElementNodeIds);
  end
end
if ischar(idxN)
  if strcmp(idxN, 'all')
    idxN = 1:rows(program.analysis.NodeIds);
  end
end

findExternalFaces;
for i = 1:length(choice)
	switch(choice(i))
		case 1
			spyVolume;
		case 2
			spyElement;
		case 3
			spySparse;
		case 4
			plotFaces;
		case 5
			plotElements;
		case 6
			plotMesh;
		case 7
			plotMeshGrid;
		case 8
			plotSolution;
		case 9
      scatterElements;
    case 10
			scatterProblem;
		case 11
			scatterSolution;
		case 12
			quiverTemperatureGradient;
		case 13
			quiverHeatFlux;
    case 14
      outlineElements;
	end
end

h = get(gca, 'children');
legH = [];
legL = {};
for i = 1:length(h)
	if strcmp(get(h(i), 'type'), 'text')
		continue;
	end
	l = get(h(i), 'displayname');
	if !isempty(l)
		legH(end+1) = h(i);
		legL(end+1) = l;
	end
end
if !isempty(legH)
	legend(legH, legL);
end
xlabel("x");
ylabel("y");
zlabel("z");
axis equal;