plot3( ...
	[
		N(E(idxE,1),1), N(E(idxE,2),1);
		N(E(idxE,1),1), N(E(idxE,3),1);
		N(E(idxE,1),1), N(E(idxE,4),1);
		N(E(idxE,2),1), N(E(idxE,3),1);
		N(E(idxE,2),1), N(E(idxE,4),1);
		N(E(idxE,3),1), N(E(idxE,4),1);
	].', ...
	[
		N(E(idxE,1),2), N(E(idxE,2),2);
		N(E(idxE,1),2), N(E(idxE,3),2);
		N(E(idxE,1),2), N(E(idxE,4),2);
		N(E(idxE,2),2), N(E(idxE,3),2);
		N(E(idxE,2),2), N(E(idxE,4),2);
		N(E(idxE,3),2), N(E(idxE,4),2);
	].', ...
	[
		N(E(idxE,1),3), N(E(idxE,2),3);
		N(E(idxE,1),3), N(E(idxE,3),3);
		N(E(idxE,1),3), N(E(idxE,4),3);
		N(E(idxE,2),3), N(E(idxE,3),3);
		N(E(idxE,2),3), N(E(idxE,4),3);
		N(E(idxE,3),3), N(E(idxE,4),3);
	].');
for i = 1:length(idxE)
##	text(mean(N(E(idxE(i),:),1)),mean(N(E(idxE(i),:),2)),mean(N(E(idxE(i),:),3)), [num2str(mean(N(E(idxE(i),:),1))),',',num2str(mean(N(E(idxE(i),:),2))),',',num2str(mean(N(E(idxE(i),:),3)))])
	text(mean(N(E(idxE(i),:),1)),mean(N(E(idxE(i),:),2)),mean(N(E(idxE(i),:),3)), num2str(idxE(i)))
end