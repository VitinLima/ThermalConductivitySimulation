##((U-min(U))/(max(U)-min(U)))
scatter3(N(:,1), N(:,2), N(:,3), [], U, 'marker', '*', 'displayname', 'Nodes');
for i = 1:length(N)
	text(N(i,1), N(i,2), N(i,3), [' ', num2str(U(i))]);
end

##for i = 1:length(BC)
##	BCi = BC(i);
##	if strcmp(BCi.type, 'TEMPERATURE')
##		scatter3( ...
##			N(BCi.targets,1), ...
##			N(BCi.targets,2), ...
##			N(BCi.targets,3), ...
##			[], ...
##			BCi.value, ...
##			'marker', 'o', ...
##			'displayname', strjoin({'Temperature ',num2str(BCi.value)}, ''));
##		text( ...
##			median(N(BCi.targets,1)), ...
##			median(N(BCi.targets,2)), ...
##			median(N(BCi.targets,3)), ...
##			num2str(BCi.value));
##	end
##end

colormap(jet);
colorbar;
legend;