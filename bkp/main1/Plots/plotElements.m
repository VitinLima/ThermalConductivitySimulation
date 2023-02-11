##close all;
##clc;

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(E);
  end
else
  idx = idxE;
end

##trimesh(E(idx,[1,2,3]), N(:,1), N(:,2), N(:,3));
##trimesh(E(idx,[1,3,4]), N(:,1), N(:,2), N(:,3));
##trimesh(E(idx,[1,4,2]), N(:,1), N(:,2), N(:,3));
##trimesh(E(idx,[2,4,3]), N(:,1), N(:,2), N(:,3));

Um = (U(E(:,1)) + U(E(:,2)) + U(E(:,3)) + U(E(:,4)))/4;
maxU = max(U);
minU = min(U);
cmap = jet(64);
cdata = 1 + round(63*((U - minU)/(maxU - minU)));%,:)

##colormap(cmap);

ht = tetramesh(E(idx,:), N, 'facecolor', [0 0 0], 'edgecolor', [.5 .5 .5]);
##h = patch('Faces', E(idx,[1,2,3]), 'Vertices', N, 'edgecolor', [.5 .5 .5]);
##set(h, 'cdata', [1 1 11 22]', 'facevertexcdata', [1 1 11 22]');
##colorbar;
##patch('Faces', E(idx,[1,3,4]), 'Vertices', N);
##patch('Faces', E(idx,[1,4,2]), 'Vertices', N);
##patch('Faces', E(idx,[2,4,3]), 'Vertices', N);