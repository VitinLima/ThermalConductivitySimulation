close all;
##clc;

figure;
hold on;

scatter3(N(:,1), N(:,2), N(:,3), [], U, 'b', 'marker', '*', 'displayname', 'Nodes');

for i = 1:length(U)
	text(N(i,1), N(i,2), N(i,3), [num2str(U(i))]);
end