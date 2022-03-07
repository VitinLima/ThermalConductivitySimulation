trisurf([E(:,1) E(:,2) E(:,3)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');
trisurf([E(:,1) E(:,2) E(:,4)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');
trisurf([E(:,1) E(:,3) E(:,4)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');
trisurf([E(:,2) E(:,3) E(:,4)], N(:,1), N(:,2), N(:,3), U, 'facecolor', 'interp');

colormap(jet);
colorbar;