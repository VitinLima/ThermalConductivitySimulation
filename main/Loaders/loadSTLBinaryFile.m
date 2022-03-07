N = fread(FID, 1, 'uint32', 0, 'l');
S = zeros(N, 3);
P = zeros(3*N,3);
C = zeros(N, 1);
T = zeros(N, 3);
k = 1;
for i = 1:N
	S(i,:) = fread(FID, 3, 'single=>single', 0, 'l');
	P(k,:) = fread(FID, 3, 'single=>single', 0, 'l');
	T(i,1) = min(find(P(k,1)==P(:,1)&P(k,2)==P(:,2)&P(k,3)==P(:,3)));
	if T(i,1)==k
		k++;
	end
	P(k,:) = fread(FID, 3, 'single=>single', 0, 'l');
	T(i,2) = min(find(P(k,1)==P(:,1)&P(k,2)==P(:,2)&P(k,3)==P(:,3)));
	if T(i,1)==k
		k++;
	end
	P(k,:) = fread(FID, 3, 'single=>single', 0, 'l');
	T(i,3) = min(find(P(k,1)==P(:,1)&P(k,2)==P(:,2)&P(k,3)==P(:,3)));
	if T(i,1)==k
		k++;
	end
	C(i) = fread(FID, 1, 'uint16=>uint16', 0, 'l');
end

P(k:end,:) = [];