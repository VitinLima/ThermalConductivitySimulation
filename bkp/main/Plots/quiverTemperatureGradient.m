close all;
clc;

figure;
hold on;

idx = 1:length(E);

Nmx = (N(E(idx,1),1)+N(E(idx,2),1)+N(E(idx,3),1)+N(E(idx,4),1))/4;
Nmy = (N(E(idx,1),2)+N(E(idx,2),2)+N(E(idx,3),2)+N(E(idx,4),2))/4;
Nmz = (N(E(idx,1),3)+N(E(idx,2),3)+N(E(idx,3),3)+N(E(idx,4),3))/4;

Gx = sum(KA.*[U(E(:,1)) U(E(:,2)) U(E(:,3)) U(E(:,4))],2);
Gy = sum(KB.*[U(E(:,1)) U(E(:,2)) U(E(:,3)) U(E(:,4))],2);
Gz = sum(KC.*[U(E(:,1)) U(E(:,2)) U(E(:,3)) U(E(:,4))],2);

quiver3( ...
	Nmx, ...
	Nmy, ...
	Nmz, ...
	Gx, ...
	Gy, ...
	Gz, ...
	'displayname', 'Temperature gradient');

##for i = 1:length(BC)
##	BCi = BC(i);
##	if strcmp(BCi.type, 'TEMPERATURE')
##		plot3( ...
##			N(BCi.targets,1), ...
##			N(BCi.targets,2), ...
##			N(BCi.targets,3), ...
##			'marker', 'o', ...
##			'linestyle', 'none', ...
##			'displayname', strjoin({'Temperature ',num2str(BCi.value)}, ''));
##		text( ...
##			median(N(BCi.targets,1)), ...
##			median(N(BCi.targets,2)), ...
##			median(N(BCi.targets,3)), ...
##			num2str(BCi.value));
##	end
##end

scatter3(N(:,1), N(:,2), N(:,3), [], U, 'marker', '*', 'displayname', 'Nodes');

colormap(jet);
colorbar;
legend;