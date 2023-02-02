##close all;
##clear all;
##clc;
##
##problemDir = 'Problem2';
##
##loadASCIIFile;

### BFaces always point outwards
##idx1 = 1;
##idx2 = 2;
##idx3 = 3;
##idx4 = 4;
##testCase1 = isempty(find(dot(cross(N(E(:,idx2),:)-N(E(:,idx1),:),N(E(:,idx3),:)-N(E(:,idx1),:),2),N(E(:,idx4),:)-N(E(:,idx1),:),2) > 0))
##idx1 = 1;
##idx2 = 4;
##idx3 = 2;
##idx4 = 3;
##testCase2 = isempty(find(dot(cross(N(E(:,idx2),:)-N(E(:,idx1),:),N(E(:,idx3),:)-N(E(:,idx1),:),2),N(E(:,idx4),:)-N(E(:,idx1),:),2) > 0))
##idx1 = 1;
##idx2 = 3;
##idx3 = 4;
##idx4 = 2;
##testCase3 = isempty(find(dot(cross(N(E(:,idx2),:)-N(E(:,idx1),:),N(E(:,idx3),:)-N(E(:,idx1),:),2),N(E(:,idx4),:)-N(E(:,idx1),:),2) > 0))
##idx1 = 2;
##idx2 = 4;
##idx3 = 3;
##idx4 = 1;
##testCase4 = isempty(find(dot(cross(N(E(:,idx2),:)-N(E(:,idx1),:),N(E(:,idx3),:)-N(E(:,idx1),:),2),N(E(:,idx4),:)-N(E(:,idx1),:),2) > 0))

# All faces from all tetrahedron elements
BF = [E(:,1),E(:,2),E(:,3);E(:,1),E(:,4),E(:,2);E(:,1),E(:,3),E(:,4);E(:,2),E(:,4),E(:,3)];
k = 1;
while k <= rows(BF)
	j = k+1;
	c1 = BF(k,1)==BF(j:end,:);
	c2 = BF(k,2)==BF(j:end,:);
	c3 = BF(k,3)==BF(j:end,:);
	j = find(sum(c1|c2|c3,2)==3);
	if !isempty(j)
		BF(k+[0 j],:) = [];
	else
		k++;
	end
end

BFS = zeros(rows(BF),4);
BFS(:,1:3) = cross(N(BF(:,2),:)-N(BF(:,1),:), N(BF(:,3),:)-N(BF(:,1),:), 2)/2;
BFS(:,4) = sqrt(BFS(:,1).*BFS(:,1) + BFS(:,2).*BFS(:,2) + BFS(:,3).*BFS(:,3))/3;

##for idx = 1:length(BC)
##	if strcmp(BC(idx).type, 'HEATFLOW') || strcmp(BC(idx).type, 'HEATFLUX') || strcmp(BC(idx).type, 'CONVECTION')
##		disp(['Converting boundary condition ', num2str(idx), ' from nodes to faces']);
##		BCBFaces = zeros(rows(BF),1);
##		for j = 1:length(BC(idx).targets)
##			c1 = BF(:,1) == BC(idx).targets(j);
##			c2 = BF(:,2) == BC(idx).targets(j);
##			c3 = BF(:,3) == BC(idx).targets(j);
##			BCBFaces(find(c1|c2|c3)) += 1;
##		end
##		BC(idx).targets = find(BCBFaces >= 3);
##	end
##end