##Na = cell(4,4);
##for i = 1:4
##	for j = 1:4
##		if i == j
##			continue;
##		end
##		Na(i,j) = [
##			mean([N(E(:,i), 1), N(E(:,j), 1)],2), ...
##			mean([N(E(:,i), 2), N(E(:,j), 2)],2), ...
##			mean([N(E(:,i), 3), N(E(:,j), 3)],2)
##		];
##	end
##end
##Ne = cell(4,4,4);
##for i = 1:4
##	for j = 1:4
##		for k = 1:4
##			if i == j || j == k || k == i
##				continue;
##			end
##			Ne(i,j,k) = [
##				mean([N(E(:,i), 1), N(E(:,j), 1), N(E(:,k), 1)],2), ...
##				mean([N(E(:,i), 2), N(E(:,j), 2), N(E(:,k), 2)],2), ...
##				mean([N(E(:,i), 3), N(E(:,j), 3), N(E(:,k), 3)],2)
##			];
##		end
##	end
##end
##Ng = [
##	mean([N(E(:,1), 1), N(E(:,2), 1), N(E(:,3), 1), N(E(:,4), 1)],2), ...
##	mean([N(E(:,1), 2), N(E(:,2), 2), N(E(:,3), 2), N(E(:,4), 2)],2), ...
##	mean([N(E(:,1), 3), N(E(:,2), 3), N(E(:,3), 3), N(E(:,4), 3)],2)
##];

plot3( ...
	N(idxN,1), ...
	N(idxN,2), ...
	N(idxN,3), ...
	'linestyle', 'none', ...
	'marker', '*', ...
	'color', 'blue', ...
	'displayname', 'node');

for i = 1:4
	idx = E(:,i) == idxN;
	
	if isempty(find(idx))
		continue;
	end
	
	j1 = 1 + mod(i, 4);
	j2 = 1 + mod(i+1, 4);
	j3 = 1 + mod(i+2, 4);
	
	plot3( ...
		[
			cell2mat(Na(i,j1))(idx,1);
			cell2mat(Na(i,j2))(idx,1);
			cell2mat(Na(i,j3))(idx,1)
		].', ...
		[
			cell2mat(Na(i,j1))(idx,2);
			cell2mat(Na(i,j2))(idx,2);
			cell2mat(Na(i,j3))(idx,2)
		].', ...
		[
			cell2mat(Na(i,j1))(idx,3);
			cell2mat(Na(i,j2))(idx,3);
			cell2mat(Na(i,j3))(idx,3)
		].', ...
		'linestyle', 'none', ...
		'marker', '*', ...
		'color', 'cyan', ...
		'displayname', 'Na');
	
	plot3( ...
		[
			cell2mat(Ne(i,j1,j2))(idx,1);
			cell2mat(Ne(i,j1,j3))(idx,1);
			cell2mat(Ne(i,j2,j3))(idx,1)
		].', ...
		[
			cell2mat(Ne(i,j1,j2))(idx,2);
			cell2mat(Ne(i,j1,j3))(idx,2);
			cell2mat(Ne(i,j2,j3))(idx,2)
		].', ...
		[
			cell2mat(Ne(i,j1,j2))(idx,3);
			cell2mat(Ne(i,j1,j3))(idx,3);
			cell2mat(Ne(i,j2,j3))(idx,3)
		].', ...
		'linestyle', 'none', ...
		'marker', '*', ...
		'color', 'yellow', ...
		'displayname', 'Ne');
	
	plot3( ...
		Ng(idx,1), ...
		Ng(idx,2), ...
		Ng(idx,3), ...
		'linestyle', 'none', ...
		'marker', '*', ...
		'color', 'red', ...
		'displayname', 'Ng');
	
	plot3( ...
		[
			N(E(idx, i),1) cell2mat(Na(i,j1))(idx,1);
			N(E(idx, i),1) cell2mat(Na(i,j2))(idx,1);
			N(E(idx, i),1) cell2mat(Na(i,j3))(idx,1)
		].', ...
		[
			N(E(idx, i),2) cell2mat(Na(i,j1))(idx,2);
			N(E(idx, i),2) cell2mat(Na(i,j2))(idx,2);
			N(E(idx, i),2) cell2mat(Na(i,j3))(idx,2)
		].', ...
		[
			N(E(idx, i),3) cell2mat(Na(i,j1))(idx,3);
			N(E(idx, i),3) cell2mat(Na(i,j2))(idx,3);
			N(E(idx, i),3) cell2mat(Na(i,j3))(idx,3)
		].', ...
		'color', 'blue');
	
	plot3( ...
		[
			cell2mat(Na(i,j1))(idx,1) cell2mat(Ne(i,j1,j2))(idx,1);
			cell2mat(Na(i,j1))(idx,1) cell2mat(Ne(i,j1,j3))(idx,1);
			cell2mat(Na(i,j2))(idx,1) cell2mat(Ne(i,j2,j3))(idx,1);
			cell2mat(Na(i,j2))(idx,1) cell2mat(Ne(i,j2,j1))(idx,1);
			cell2mat(Na(i,j3))(idx,1) cell2mat(Ne(i,j3,j1))(idx,1);
			cell2mat(Na(i,j3))(idx,1) cell2mat(Ne(i,j3,j2))(idx,1)
		].', ...
		[
			cell2mat(Na(i,j1))(idx,2) cell2mat(Ne(i,j1,j2))(idx,2);
			cell2mat(Na(i,j1))(idx,2) cell2mat(Ne(i,j1,j3))(idx,2);
			cell2mat(Na(i,j2))(idx,2) cell2mat(Ne(i,j2,j3))(idx,2);
			cell2mat(Na(i,j2))(idx,2) cell2mat(Ne(i,j2,j1))(idx,2);
			cell2mat(Na(i,j3))(idx,2) cell2mat(Ne(i,j3,j1))(idx,2);
			cell2mat(Na(i,j3))(idx,2) cell2mat(Ne(i,j3,j2))(idx,2)
		].', ...
		[
			cell2mat(Na(i,j1))(idx,3) cell2mat(Ne(i,j1,j2))(idx,3);
			cell2mat(Na(i,j1))(idx,3) cell2mat(Ne(i,j1,j3))(idx,3);
			cell2mat(Na(i,j2))(idx,3) cell2mat(Ne(i,j2,j3))(idx,3);
			cell2mat(Na(i,j2))(idx,3) cell2mat(Ne(i,j2,j1))(idx,3);
			cell2mat(Na(i,j3))(idx,3) cell2mat(Ne(i,j3,j1))(idx,3);
			cell2mat(Na(i,j3))(idx,3) cell2mat(Ne(i,j3,j2))(idx,3)
		].', ...
		'color', 'cyan');
		
	plot3( ...
		[
			cell2mat(Ne(i,j1,j2))(idx,1) Ng(idx,1);
			cell2mat(Ne(i,j1,j3))(idx,1) Ng(idx,1);
			cell2mat(Ne(i,j2,j3))(idx,1) Ng(idx,1)
		].', ...
		[
			cell2mat(Ne(i,j1,j2))(idx,2) Ng(idx,2);
			cell2mat(Ne(i,j1,j3))(idx,2) Ng(idx,2);
			cell2mat(Ne(i,j2,j3))(idx,2) Ng(idx,2)
		].', ...
		[
			cell2mat(Ne(i,j1,j2))(idx,3) Ng(idx,3);
			cell2mat(Ne(i,j1,j3))(idx,3) Ng(idx,3);
			cell2mat(Ne(i,j2,j3))(idx,3) Ng(idx,3)
		].', ...
		'color', 'yellow');
end