##trisurf([E(:,1) E(:,2) E(:,3)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');
##trisurf([E(:,1) E(:,2) E(:,4)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');
##trisurf([E(:,1) E(:,3) E(:,4)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');
##trisurf([E(:,2) E(:,3) E(:,4)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(E);
  end
else
  idx = idxE;
end

BF = findBoundaryFaces(E(idx,:));
trisurf(BF, N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp', 'linestyle', 'none');

##Um = (U(E(:,1)) + U(E(:,2)) + U(E(:,3)) + U(E(:,4)))/4;
##tetramesh(E, N);

colormap(jet);
colorbar;