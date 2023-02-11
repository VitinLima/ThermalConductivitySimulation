1;

function BF = findBoundaryFaces(E)
  F1 = [ ...
    E(:,[1 2 3]); ...
    E(:,[1 4 2]); ...
    E(:,[2 4 3]); ...
    E(:,[3 4 1])];

  F2 = ~ismember(F1, F1(:,[1 3 2]), 'rows');
  F3 = ~ismember(F1, F1(:,[2 1 3]), 'rows');
  F4 = ~ismember(F1, F1(:,[2 3 1]), 'rows');
  F5 = ~ismember(F1, F1(:,[3 1 2]), 'rows');
  F6 = ~ismember(F1, F1(:,[3 2 1]), 'rows');
  
  BF = F1(F2&F3&F4&F5&F6,:);
end