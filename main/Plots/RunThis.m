close all;
clc;

figure;
hold on;

idxE = 'all';
##idxE = [27, 29, 28, 17, 26, 4];
idxN = 1:rows(N);
idxBC = 4;

choice = [8];

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