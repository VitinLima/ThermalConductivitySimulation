##close all;
##clc;

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(E);
  end
else
  idx = idxE;
end

edges = [
  E(idx, [1, 2]);
  E(idx, [1, 3]);
  E(idx, [1, 4]);
  E(idx, [2, 3]);
  E(idx, [2, 4]);
  E(idx, [3, 4])];
line( ...
  [N(edges(:,1), 1) N(edges(:,2), 1)]', ...
  [N(edges(:,1), 2) N(edges(:,2), 2)]', ...
  [N(edges(:,1), 3) N(edges(:,2), 3)]', ...
  'color', 'b');