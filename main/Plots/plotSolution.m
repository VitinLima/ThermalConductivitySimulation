##trisurf([program.analysis.ElementNodeIds(:,1) program.analysis.ElementNodeIds(:,2) program.analysis.ElementNodeIds(:,3)], program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3), program.analysis.U, 'facecolor', 'interp');
##trisurf([program.analysis.ElementNodeIds(:,1) program.analysis.ElementNodeIds(:,2) program.analysis.ElementNodeIds(:,4)], program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3), program.analysis.U, 'facecolor', 'interp');
##trisurf([program.analysis.ElementNodeIds(:,1) program.analysis.ElementNodeIds(:,3) program.analysis.ElementNodeIds(:,4)], program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3), program.analysis.U, 'facecolor', 'interp');
##trisurf([program.analysis.ElementNodeIds(:,2) program.analysis.ElementNodeIds(:,3) program.analysis.ElementNodeIds(:,4)], program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3), program.analysis.U, 'facecolor', 'interp');

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(program.analysis.ElementNodeIds);
  end
else
  idx = idxE;
end

BF = findBoundaryFaces(program.analysis.ElementNodeIds(idx,:));
trisurf(BF, program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3), program.analysis.U, 'facecolor', 'interp');%, 'linestyle', 'none');

##Um = (program.analysis.U(program.analysis.ElementNodeIds(:,1)) + program.analysis.U(program.analysis.ElementNodeIds(:,2)) + program.analysis.U(program.analysis.ElementNodeIds(:,3)) + program.analysis.U(program.analysis.ElementNodeIds(:,4)))/4;
##tetramesh(program.analysis.ElementNodeIds, program.analysis.Nodes);

colormap(jet);
colorbar;