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

Nmx = (N(E(:,1),1)+N(E(:,2),1)+N(E(:,3),1)+N(E(:,4),1))/4;
Nmy = (N(E(:,1),2)+N(E(:,2),2)+N(E(:,3),2)+N(E(:,4),2))/4;
Nmz = (N(E(:,1),3)+N(E(:,2),3)+N(E(:,3),3)+N(E(:,4),3))/4;

scatter3(Nmx(idx), Nmy(idx), Nmz(idx), [], 'marker', '*', 'displayname', 'Elements');
for i = 1:rows(Nmx)
	text(Nmx(i), Nmy(i), Nmz(i), ['  ', num2str(i)]);
end