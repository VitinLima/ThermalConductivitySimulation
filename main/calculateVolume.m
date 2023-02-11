VE = dot(cross(program.analysis.Nodes(program.analysis.ElementNodeIds(:,2),:)-program.analysis.Nodes(program.analysis.ElementNodeIds(:,1),:),program.analysis.Nodes(program.analysis.ElementNodeIds(:,3),:)-program.analysis.Nodes(program.analysis.ElementNodeIds(:,1),:),2),program.analysis.Nodes(program.analysis.ElementNodeIds(:,4),:)-program.analysis.Nodes(program.analysis.ElementNodeIds(:,1),:),2)/6;
VN = zeros(rows(program.analysis.Nodes), 1);
VN += accumarray(program.analysis.ElementNodeIds(:,1),VE,size(VN));
VN += accumarray(program.analysis.ElementNodeIds(:,2),VE,size(VN));
VN += accumarray(program.analysis.ElementNodeIds(:,3),VE,size(VN));
VN += accumarray(program.analysis.ElementNodeIds(:,4),VE,size(VN));
VN /= 4;