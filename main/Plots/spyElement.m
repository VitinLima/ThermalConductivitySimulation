cmap = hsv(10);
cidxE = 1;

scale = 0.1;

# Nodes
plot3(N(E(idxE,:),1), N(E(idxE,:),2), N(E(idxE,:),3), 'color', 'blue', 'marker', '*', 'linestyle', 'none', 'displayname', 'Nodes');
text(N(E(idxE,1),1), N(E(idxE,1),2), N(E(idxE,1),3), ' N1', 'verticalalignment', 'bottom');
text(N(E(idxE,2),1), N(E(idxE,2),2), N(E(idxE,2),3), ' N2', 'verticalalignment', 'bottom');
text(N(E(idxE,3),1), N(E(idxE,3),2), N(E(idxE,3),3), ' N3', 'verticalalignment', 'bottom');
text(N(E(idxE,4),1), N(E(idxE,4),2), N(E(idxE,4),3), ' N4', 'verticalalignment', 'bottom');

for i = 1:4
	for j = 1:4
		if j == i
			continue;
		end
		
		quiver3( ...
			mean([cell2mat(Na(i,j))(idxE,1) Ng(idxE,1)],2).', ...
			mean([cell2mat(Na(i,j))(idxE,2) Ng(idxE,2)],2).', ...
			mean([cell2mat(Na(i,j))(idxE,3) Ng(idxE,3)],2).', ...
			cell2mat(Si(i,j))(idxE,1).', ...
			cell2mat(Si(i,j))(idxE,2).', ...
			cell2mat(Si(i,j))(idxE,3).');
		
		n = find(!sum([i j]'==[1:4]));
		
		for k = 1:4
			if k == i || k == j
				continue;
			end
			plot3( ...
			[Ng(idxE,1) cell2mat(Ne(i,j,k))(idxE,1) cell2mat(Na(i,j))(idxE,1) cell2mat(Ne(i,k,j))(idxE,1) Ng(idxE,1)].', ...
			[Ng(idxE,2) cell2mat(Ne(i,j,k))(idxE,2) cell2mat(Na(i,j))(idxE,2) cell2mat(Ne(i,k,j))(idxE,2) Ng(idxE,2)].', ...
			[Ng(idxE,3) cell2mat(Ne(i,j,k))(idxE,3) cell2mat(Na(i,j))(idxE,3) cell2mat(Ne(i,k,j))(idxE,3) Ng(idxE,3)].');
		end
	end
end