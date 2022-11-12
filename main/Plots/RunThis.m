close all;
##clc;

figure;
hold on;

idxE = 1:rows(E);
##idxE = [23, 18, 25, 30, 5, 14];
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
			plotElement;
		case 6
			plotMesh;
		case 7
			plotMeshGrid;
		case 8
			plotSolution;
		case 9
			scatterProblem;
		case 10
			scatterSolution;
		case 11
			quiverTemperatureGradient;
		case 12
			quiverHeatFlux;
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