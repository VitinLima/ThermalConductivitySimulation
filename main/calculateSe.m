Se = cell(4,4,4);
Sem = cell(4,4,4);
Sea = cell(4,4,4);
for i = 1:4
	for j = 1:4
		if j == i
			continue;
		end
		for k = 1:4
			if k == i || k == j
				continue;
			end
			Se(i,j,k) = cross( ...
				[program.analysis.Nodes(program.analysis.ElementNodeIds(:,j),1), program.analysis.Nodes(program.analysis.ElementNodeIds(:,j),2), program.analysis.Nodes(program.analysis.ElementNodeIds(:,j),3)]-[program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),1), program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),2), program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),3)], ...
				[program.analysis.Nodes(program.analysis.ElementNodeIds(:,k),1), program.analysis.Nodes(program.analysis.ElementNodeIds(:,k),2), program.analysis.Nodes(program.analysis.ElementNodeIds(:,k),3)]-[program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),1), program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),2), program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),3)], ...
				2)/2/3;
			Sem(i,j,k) = [
				mean( ...
					[
						cell2mat(Na(i,j))(:,1), ...
						cell2mat(Na(i,k))(:,1), ...
						program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),1)
					], 2), ...
				mean( ...
					[
						cell2mat(Na(i,j))(:,2), ...
						cell2mat(Na(i,k))(:,2), ...
						program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),2)
					], 2), ...
				mean( ...
					[
						cell2mat(Na(i,j))(:,3), ...
						cell2mat(Na(i,k))(:,3), ...
						program.analysis.Nodes(program.analysis.ElementNodeIds(:,i),3)
					], 2)
			];
			Sea(i,j,k) = sqrt(
				dot(
					cell2mat(Se(i,j,k)), ...
					cell2mat(Se(i,j,k)), ...
					2)
				);
		end
	end
end

##for i = 1:4
##	idx = find(program.analysis.ElementNodeIds(:,i)==idxN);
##	if isempty(idx)
##		continue;
##	end
##	for j = 1:4
##		if j == i
##			continue;
##		end
##		for k = 1:4
##			if k == i || k == j
##				continue;
##			end
##			quiver3(
##				cell2mat(Sem(i,j,k))(idx,1), ...
##				cell2mat(Sem(i,j,k))(idx,2), ...
##				cell2mat(Sem(i,j,k))(idx,3), ...
##				cell2mat(Se(i,j,k))(idx,1), ...
##				cell2mat(Se(i,j,k))(idx,2), ...
##				cell2mat(Se(i,j,k))(idx,3)
##			);
##		end
##	end
##end