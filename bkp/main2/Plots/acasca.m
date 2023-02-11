close all;
figure;
hold on;

idxE = 1;
i1 = 2;
i2 = 3;
i3 = 4;
quiver3(0,0,0,cell2mat(Se(i1,i2,i3))(idxE,1),cell2mat(Se(i1,i2,i3))(idxE,2),cell2mat(Se(i1,i2,i3))(idxE,3));
quiver3(0,0,0,cell2mat(Se(i1,i3,i2))(idxE,1),cell2mat(Se(i1,i3,i2))(idxE,2),cell2mat(Se(i1,i3,i2))(idxE,3));
quiver3(0,0,0,cell2mat(Se1(i1,i2,i3))(idxE,1),cell2mat(Se1(i1,i2,i3))(idxE,2),cell2mat(Se1(i1,i2,i3))(idxE,3));
quiver3(0,0,0,cell2mat(Se1(i1,i3,i2))(idxE,1),cell2mat(Se1(i1,i3,i2))(idxE,2),cell2mat(Se1(i1,i3,i2))(idxE,3));
axis equal;