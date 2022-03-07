disp('Build system script initiated.');
tic;

% Sub-elements (surface elements)

Na = cell(4,4);
for i = 1:4
	for j = 1:4
		if i == j
			continue;
		end
		Na(i,j) = [
			mean([N(E(:,i), 1), N(E(:,j), 1)],2), ...
			mean([N(E(:,i), 2), N(E(:,j), 2)],2), ...
			mean([N(E(:,i), 3), N(E(:,j), 3)],2)
		];
	end
end
Ne = cell(4,4,4);
for i = 1:4
	for j = 1:4
		for k = 1:4
			if i == j || j == k || k == i
				continue;
			end
			Ne(i,j,k) = [
				mean([N(E(:,i), 1), N(E(:,j), 1), N(E(:,k), 1)],2), ...
				mean([N(E(:,i), 2), N(E(:,j), 2), N(E(:,k), 2)],2), ...
				mean([N(E(:,i), 3), N(E(:,j), 3), N(E(:,k), 3)],2)
			];
		end
	end
end
Ng = [
	mean([N(E(:,1), 1), N(E(:,2), 1), N(E(:,3), 1), N(E(:,4), 1)],2), ...
	mean([N(E(:,1), 2), N(E(:,2), 2), N(E(:,3), 2), N(E(:,4), 2)],2), ...
	mean([N(E(:,1), 3), N(E(:,2), 3), N(E(:,3), 3), N(E(:,4), 3)],2)
];
calculateSe;
calculateSi;
calculateVolume;

# Geometric Linear Coefficients

## Kij = zeros(rows(E), 4*4);
## There relations will construct the coefficient matrix and can be derived in
## the 'CalculateLinearCoefficients' script. No one needed to derive these
## relations manually since the symbolic package made the necessary calculations
## with the system these relations came from. Note that these relations are
## purely geometric, therefore can potentially be utilized in other systems
## (other than a thermodynamic system) given the mesh of the problem.
KA = zeros(rows(E),4);
KB = zeros(rows(E),4);
KC = zeros(rows(E),4);
KD = zeros(rows(E),4);
KA(:,1) = (N(E(:,2),2).*N(E(:,3),3) - N(E(:,2),2).*N(E(:,4),3) - N(E(:,3),2).*N(E(:,2),3) + N(E(:,3),2).*N(E(:,4),3) + N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),2).*N(E(:,3),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KA(:,2) = (-N(E(:,1),2).*N(E(:,3),3) + N(E(:,1),2).*N(E(:,4),3) + N(E(:,3),2).*N(E(:,1),3) - N(E(:,3),2).*N(E(:,4),3) - N(E(:,4),2).*N(E(:,1),3) + N(E(:,4),2).*N(E(:,3),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KA(:,3) = (N(E(:,1),2).*N(E(:,2),3) - N(E(:,1),2).*N(E(:,4),3) - N(E(:,2),2).*N(E(:,1),3) + N(E(:,2),2).*N(E(:,4),3) + N(E(:,4),2).*N(E(:,1),3) - N(E(:,4),2).*N(E(:,2),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KA(:,4) = (-N(E(:,1),2).*N(E(:,2),3) + N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),2).*N(E(:,1),3) - N(E(:,2),2).*N(E(:,3),3) - N(E(:,3),2).*N(E(:,1),3) + N(E(:,3),2).*N(E(:,2),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KB(:,1) = (-N(E(:,2),1).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,4),3) - N(E(:,4),1).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,3),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KB(:,2) = (N(E(:,1),1).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,4),3) + N(E(:,4),1).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,3),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KB(:,3) = (-N(E(:,1),1).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,4),3) - N(E(:,4),1).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,2),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KB(:,4) = (N(E(:,1),1).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,2),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KC(:,1) = (N(E(:,2),1).*N(E(:,3),2) - N(E(:,2),1).*N(E(:,4),2) - N(E(:,3),1).*N(E(:,2),2) + N(E(:,3),1).*N(E(:,4),2) + N(E(:,4),1).*N(E(:,2),2) - N(E(:,4),1).*N(E(:,3),2))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KC(:,2) = (-N(E(:,1),1).*N(E(:,3),2) + N(E(:,1),1).*N(E(:,4),2) + N(E(:,3),1).*N(E(:,1),2) - N(E(:,3),1).*N(E(:,4),2) - N(E(:,4),1).*N(E(:,1),2) + N(E(:,4),1).*N(E(:,3),2))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KC(:,3) = (N(E(:,1),1).*N(E(:,2),2) - N(E(:,1),1).*N(E(:,4),2) - N(E(:,2),1).*N(E(:,1),2) + N(E(:,2),1).*N(E(:,4),2) + N(E(:,4),1).*N(E(:,1),2) - N(E(:,4),1).*N(E(:,2),2))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KC(:,4) = (-N(E(:,1),1).*N(E(:,2),2) + N(E(:,1),1).*N(E(:,3),2) + N(E(:,2),1).*N(E(:,1),2) - N(E(:,2),1).*N(E(:,3),2) - N(E(:,3),1).*N(E(:,1),2) + N(E(:,3),1).*N(E(:,2),2))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KD(:,1) = (-N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KD(:,2) = (N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KD(:,3) = (-N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));
KD(:,4) = (N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3))./(N(E(:,1),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,1),1).*N(E(:,2),2).*N(E(:,4),3) - N(E(:,1),1).*N(E(:,3),2).*N(E(:,2),3) + N(E(:,1),1).*N(E(:,3),2).*N(E(:,4),3) + N(E(:,1),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,1),1).*N(E(:,4),2).*N(E(:,3),3) - N(E(:,2),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,2),1).*N(E(:,1),2).*N(E(:,4),3) + N(E(:,2),1).*N(E(:,3),2).*N(E(:,1),3) - N(E(:,2),1).*N(E(:,3),2).*N(E(:,4),3) - N(E(:,2),1).*N(E(:,4),2).*N(E(:,1),3) + N(E(:,2),1).*N(E(:,4),2).*N(E(:,3),3) + N(E(:,3),1).*N(E(:,1),2).*N(E(:,2),3) - N(E(:,3),1).*N(E(:,1),2).*N(E(:,4),3) - N(E(:,3),1).*N(E(:,2),2).*N(E(:,1),3) + N(E(:,3),1).*N(E(:,2),2).*N(E(:,4),3) + N(E(:,3),1).*N(E(:,4),2).*N(E(:,1),3) - N(E(:,3),1).*N(E(:,4),2).*N(E(:,2),3) - N(E(:,4),1).*N(E(:,1),2).*N(E(:,2),3) + N(E(:,4),1).*N(E(:,1),2).*N(E(:,3),3) + N(E(:,4),1).*N(E(:,2),2).*N(E(:,1),3) - N(E(:,4),1).*N(E(:,2),2).*N(E(:,3),3) - N(E(:,4),1).*N(E(:,3),2).*N(E(:,1),3) + N(E(:,4),1).*N(E(:,3),2).*N(E(:,2),3));


# Linear system

## Coefficient matrix, the matrix that defines the relations between each node.
## This matrix can be extremely giangantic, but will surely be sparse. This
## means that almost all of its elements will be zeros. Therefore, much space
## can be saved in disc by only saving the positions and value of the non zero
## elements and infering that all other elements are zero. The matrix will be
## NxN, and is being declared below, initially with all zeros, but will be
## populated in the next lines.
K = sparse(rows(N),rows(N));

# K([Vetor de linhas] + rows(a)*([Vetor de colunas]-1))

# Connections between nodes through the sub-elements

% Thermal conductivity in W/mm�C
kc = 0.060500*ones(rows(E),1);

for i = 1:4
	for j = 1:4
		if j == i
			continue;
		end
		for k = 1:4
			Ks = sparse(E(:,i), E(:,k), kc.*(KA(:,k).*cell2mat(Si(i,j))(:,1) + KB(:,k).*cell2mat(Si(i,j))(:,2) + KC(:,k).*cell2mat(Si(i,j))(:,3)), rows(K), columns(K));
			K += Ks;
		end
	end
end

disp(['Build system script finilized. Execution time: ', num2str(toc), ' s']);