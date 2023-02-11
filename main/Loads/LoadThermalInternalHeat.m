for targets_idx = 1:length(program.analysis.BoundaryConditions(idx).Targets)
  Targets = cell2mat(program.analysis.BoundaryConditions(idx).Targets(targets_idx));
  ElementType = cell2mat(program.analysis.BoundaryConditions(idx).ElementType(targets_idx));
  
  if strcmp(ElementType, 'Elements')
    fdisp(program.logger, ['Applying internal heat generation condition, ', num2str(program.analysis.BoundaryConditions(idx).Magnitude), ' W/mm³']);
    for i = 1:4
      program.analysis.Fi += accumarray(program.analysis.ElementNodeIds(Targets,i), program.analysis.ElementVolumes(Targets)*program.analysis.BoundaryConditions(idx).Magnitude/4, size(program.analysis.Fi));
    end
  elseif strcmp(ElementType, 'Nodes')
    fdisp(program.logger, ['Applying internal heat generation condition, ', num2str(program.analysis.BoundaryConditions(idx).Magnitude), ' W/mm³']);
    program.analysis.Fi += accumarray(Targets, VN(Targets)*program.analysis.BoundaryConditions(idx).Magnitude, size(program.analysis.Fi));
  else
    fdisp(program.logger, ['Failed to apply boundary condition: Unknown element Type "', ElementType, '"']);
  end
end