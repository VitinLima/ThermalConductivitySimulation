VE = dot(cross(N(E(:,2),:)-N(E(:,1),:),N(E(:,3),:)-N(E(:,1),:),2),N(E(:,4),:)-N(E(:,1),:),2)/6;
VN = zeros(rows(N), 1);
VN += accumarray(E(:,1),VE,size(VN));
VN += accumarray(E(:,2),VE,size(VN));
VN += accumarray(E(:,3),VE,size(VN));
VN += accumarray(E(:,4),VE,size(VN));
VN /= 4;