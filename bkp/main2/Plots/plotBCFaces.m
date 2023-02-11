close all;

figure;
hold on;

trimesh(BF(BC(4).targets,:), N(:,1), N(:,2), N(:,3));

set(gcf, 'visible', 'on');