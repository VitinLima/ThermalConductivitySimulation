fdisp(program.logger, ['Applying heat flux boundary condition, ', num2str(program.analysis.BoundaryConditions(idx).Magnitude), ' W/mm²']);

for targets_idx = 1:length(program.analysis.BoundaryConditions(idx).Targets)
  Targets = cell2mat(program.analysis.BoundaryConditions(idx).Targets(targets_idx));
  ElementType = cell2mat(program.analysis.BoundaryConditions(idx).ElementType(targets_idx));
  
  if strcmp(ElementType, 'Nodes')
    for i = 1:4
      for j = 1:4
        if j == i
          continue;
        end
        for k = 1:j
          if k == i || k == j
            continue;
          end
          tmpIdx1 = find(ismember(program.analysis.ElementNodeIds(:,i), Targets)&ismember(program.analysis.ElementNodeIds(:,j), Targets)&ismember(program.analysis.ElementNodeIds(:,k), Targets));
          program.analysis.Fku(program.analysis.ElementNodeIds(tmpIdx1,i)) += accumarray(program.analysis.ElementNodeIds(tmpIdx1,i), program.analysis.BoundaryConditions(idx).Magnitude*cell2mat(Sea(i,j,k))(tmpIdx1))(program.analysis.ElementNodeIds(tmpIdx1,i));
        end
      end
    end
  elseif strcmp(ElementType, 'Faces')
    node_ids = Targets(:,3:end)(:);
    face_area = program.analysis.ElementFaceArea(sub2ind(size(program.analysis.ElementFaceArea), Targets(:,1), Targets(:,2)));
    face_area = [face_area; face_area; face_area]/3;
    program.analysis.Fku += accumarray(node_ids, face_area*program.analysis.BoundaryConditions(idx).Magnitude, size(program.analysis.Fku));
  else
    fdisp(program.logger, ['Failed to apply boundary condition: Unknown element Type "', ElementType, '"']);
  end
end