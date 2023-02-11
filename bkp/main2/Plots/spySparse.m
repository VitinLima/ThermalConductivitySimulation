spy(K);
for idx = 1:length(E)
	plot([E(idx,1) E(idx,2)], [E(idx,2) E(idx,1)], 'displayname', strjoin({num2str(idx),'.12'},''));
	plot([E(idx,1) E(idx,3)], [E(idx,3) E(idx,1)], 'displayname', strjoin({num2str(idx),'.13'},''));
	plot([E(idx,1) E(idx,4)], [E(idx,4) E(idx,1)], 'displayname', strjoin({num2str(idx),'.14'},''));
	plot([E(idx,2) E(idx,3)], [E(idx,3) E(idx,2)], 'displayname', strjoin({num2str(idx),'.23'},''));
	plot([E(idx,2) E(idx,4)], [E(idx,4) E(idx,2)], 'displayname', strjoin({num2str(idx),'.24'},''));
	plot([E(idx,3) E(idx,4)], [E(idx,4) E(idx,3)], 'displayname', strjoin({num2str(idx),'.34'},''));
end