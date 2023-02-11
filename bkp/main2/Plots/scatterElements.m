##close all;
##
##figure;
##hold on;

if ischar(idxE)
  if strcmp(idxE, 'all')
    idx = 1:rows(E);
  end
else
  idx = idxE;
end

Nmx = (N(E(idx,1),1)+N(E(idx,2),1)+N(E(idx,3),1)+N(E(idx,4),1))/4;
Nmy = (N(E(idx,1),2)+N(E(idx,2),2)+N(E(idx,3),2)+N(E(idx,4),2))/4;
Nmz = (N(E(idx,1),3)+N(E(idx,2),3)+N(E(idx,3),3)+N(E(idx,4),3))/4;

scatter3(Nmx, Nmy, Nmz, [], 'marker', '*', 'displayname', 'Elements');
for i = 1:rows(Nmx)
	text(Nmx(i), Nmy(i), Nmz(i), ['  ', num2str(idx(i))]);
end