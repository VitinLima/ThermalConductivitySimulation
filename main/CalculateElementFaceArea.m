program.analysis.ElementFaceArea = {};

for i = 1:4
  N1 = program.analysis.Nodes(program.analysis.ElementNodeIds(:,cell2mat(ElementTypeEnum.kTet4(i))(1)+1),:);
  N2 = program.analysis.Nodes(program.analysis.ElementNodeIds(:,cell2mat(ElementTypeEnum.kTet4(i))(2)+1),:);
  N3 = program.analysis.Nodes(program.analysis.ElementNodeIds(:,cell2mat(ElementTypeEnum.kTet4(i))(3)+1),:);
  areas = cross(N2-N1, N3-N1, 2);
  program.analysis.ElementFaceArea(:, i) = sqrt(dot(areas, areas, 2))/2;
end