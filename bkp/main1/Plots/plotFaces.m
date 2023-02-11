for i = 1:4
	for j = 1:4
		if j == i
			continue;
		end
		for k = 1:4
			if k == i || k == j
				continue;
			end
			idx = find(ismember(E(:,i), BC(idxBC).targets)&ismember(E(:,j), BC(idxBC).targets)&ismember(E(:,k), BC(idxBC).targets));
			plot3( ...
				[N(E(idx,i),1), N(E(idx,j),1), N(E(idx,k),1), N(E(idx,i),1)].', ...
				[N(E(idx,i),2), N(E(idx,j),2), N(E(idx,k),2), N(E(idx,i),2)].', ...
				[N(E(idx,i),3), N(E(idx,j),3), N(E(idx,k),3), N(E(idx,i),3)].');
		end
	end
end