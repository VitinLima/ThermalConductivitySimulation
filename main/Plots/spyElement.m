cmap = hsv(10);
cidxE = 1;

scale = 0.1;

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(E);
  end
else
  idx = idxE;
end

# Nodes
plot3(N(E(idx,:),1), N(E(idx,:),2), N(E(idx,:),3), 'color', 'blue', 'marker', '*', 'linestyle', 'none', 'displayname', 'Nodes');
text(N(E(idx,1),1), N(E(idx,1),2), N(E(idx,1),3), ' N1', 'verticalalignment', 'bottom');
text(N(E(idx,2),1), N(E(idx,2),2), N(E(idx,2),3), ' N2', 'verticalalignment', 'bottom');
text(N(E(idx,3),1), N(E(idx,3),2), N(E(idx,3),3), ' N3', 'verticalalignment', 'bottom');
text(N(E(idx,4),1), N(E(idx,4),2), N(E(idx,4),3), ' N4', 'verticalalignment', 'bottom');

for i = 1:4
	for j = 1:4
		if j == i
			continue;
		end
		
		quiver3( ...
			mean([cell2mat(Na(i,j))(idx,1) Ng(idx,1)],2).', ...
			mean([cell2mat(Na(i,j))(idx,2) Ng(idx,2)],2).', ...
			mean([cell2mat(Na(i,j))(idx,3) Ng(idx,3)],2).', ...
			cell2mat(Si(i,j))(idx,1).', ...
			cell2mat(Si(i,j))(idx,2).', ...
			cell2mat(Si(i,j))(idx,3).');
		
		n = find(!sum([i j]'==[1:4]));
		
		for k = 1:4
			if k == i || k == j
				continue;
			end
			plot3( ...
			[Ng(idx,1) cell2mat(Ne(i,j,k))(idx,1) cell2mat(Na(i,j))(idx,1) cell2mat(Ne(i,k,j))(idx,1) Ng(idx,1)].', ...
			[Ng(idx,2) cell2mat(Ne(i,j,k))(idx,2) cell2mat(Na(i,j))(idx,2) cell2mat(Ne(i,k,j))(idx,2) Ng(idx,2)].', ...
			[Ng(idx,3) cell2mat(Ne(i,j,k))(idx,3) cell2mat(Na(i,j))(idx,3) cell2mat(Ne(i,k,j))(idx,3) Ng(idx,3)].');
		end
	end
end