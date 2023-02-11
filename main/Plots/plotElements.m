##close all;
##clc;

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(program.analysis.ElementNodeIds);
  end
else
  idx = idxE;
end

##trimesh(program.analysis.ElementNodeIds(idx,[1,2,3]), program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3));
##trimesh(program.analysis.ElementNodeIds(idx,[1,3,4]), program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3));
##trimesh(program.analysis.ElementNodeIds(idx,[1,4,2]), program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3));
##trimesh(program.analysis.ElementNodeIds(idx,[2,4,3]), program.analysis.Nodes(:,1), program.analysis.Nodes(:,2), program.analysis.Nodes(:,3));

Um = (program.analysis.U(program.analysis.ElementNodeIds(:,1)) + program.analysis.U(program.analysis.ElementNodeIds(:,2)) + program.analysis.U(program.analysis.ElementNodeIds(:,3)) + program.analysis.U(program.analysis.ElementNodeIds(:,4)))/4;
maxU = max(program.analysis.U);
minU = min(program.analysis.U);
cmap = jet(64);
cdata = 1 + round(63*((program.analysis.U - minU)/(maxU - minU)));%,:)

##colormap(cmap);

ht = tetramesh(program.analysis.ElementNodeIds(idx,:), program.analysis.Nodes, 'facecolor', [0 0 0], 'edgecolor', [.5 .5 .5]);
##h = patch('Faces', program.analysis.ElementNodeIds(idx,[1,2,3]), 'Vertices', program.analysis.Nodes, 'edgecolor', [.5 .5 .5]);
##set(h, 'cdata', [1 1 11 22]', 'facevertexcdata', [1 1 11 22]');
##colorbar;
##patch('Faces', program.analysis.ElementNodeIds(idx,[1,3,4]), 'Vertices', program.analysis.Nodes);
##patch('Faces', program.analysis.ElementNodeIds(idx,[1,4,2]), 'Vertices', program.analysis.Nodes);
##patch('Faces', program.analysis.ElementNodeIds(idx,[2,4,3]), 'Vertices', program.analysis.Nodes);