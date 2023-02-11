##close all;
##clc;

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(program.analysis.ElementNodeIds);
  end
else
  idx = idxE;
end

edges = [
  program.analysis.ElementNodeIds(idx, [1, 2]);
  program.analysis.ElementNodeIds(idx, [1, 3]);
  program.analysis.ElementNodeIds(idx, [1, 4]);
  program.analysis.ElementNodeIds(idx, [2, 3]);
  program.analysis.ElementNodeIds(idx, [2, 4]);
  program.analysis.ElementNodeIds(idx, [3, 4])];
line( ...
  [program.analysis.Nodes(edges(:,1), 1) program.analysis.Nodes(edges(:,2), 1)]', ...
  [program.analysis.Nodes(edges(:,1), 2) program.analysis.Nodes(edges(:,2), 2)]', ...
  [program.analysis.Nodes(edges(:,1), 3) program.analysis.Nodes(edges(:,2), 3)]', ...
  'color', 'b');