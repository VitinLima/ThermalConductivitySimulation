fdisp(program.logger, ['Applying temperature boundary condition, ', num2str(program.analysis.BoundaryConditions(idx).Magnitude), ' ºC']);

for targets_idx = 1:length(program.analysis.BoundaryConditions(idx).Targets)
  Targets = cell2mat(program.analysis.BoundaryConditions(idx).Targets(targets_idx));
  ElementType = cell2mat(program.analysis.BoundaryConditions(idx).ElementType(targets_idx));
  
  if strcmp(ElementType, 'Elements')
    for i = 1:4
      node_ids = program.analysis.ElementNodeIds(Targets,i);
      program.analysis.U(node_ids) = program.analysis.BoundaryConditions(idx).Magnitude;
      
      program.analysis.solvedU(node_ids) = true;
      program.analysis.solvedF(node_ids) = false;
    end
  elseif strcmp(ElementType, 'Nodes')
    program.analysis.U(Targets) = program.analysis.BoundaryConditions(idx).Magnitude;
    
    program.analysis.solvedU(Targets) = true;
    program.analysis.solvedF(Targets) = false;
  elseif strcmp(ElementType, 'Faces')
    node_ids = Targets(:,3:end)(:);
    program.analysis.U(node_ids) = program.analysis.BoundaryConditions(idx).Magnitude;
    
    program.analysis.solvedU(node_ids) = true;
    program.analysis.solvedF(node_ids) = false;
  else
    fdisp(program.logger, ['Failed to apply boundary condition: Unknown element Type "', ElementType, '"']);
  end
end