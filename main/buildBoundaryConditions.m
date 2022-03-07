disp('Build boundary conditions script initiated.');
tic;

U = zeros(columns(K),1);
F = zeros(columns(K),1);
solvedU = false(columns(K),1);
solvedF = true(columns(K),1);

Fpd = zeros(columns(K),1);
Fku = zeros(columns(K),1);
Fko = zeros(columns(K),1);
Fh = zeros(columns(K),1);
Kh = sparse(columns(K),columns(K));
Fi = zeros(columns(K),1);

for idx = 1:length(BC)
	if strcmp(BC(idx).type, 'TEMPERATURE')
		disp(['Applying temperature boundary condition, ', num2str(BC(idx).value(1)), ' ºC']);
		
		U(BC(idx).targets) = BC(idx).value(1);
		
		solvedU(BC(idx).targets) = true;
		solvedF(BC(idx).targets) = false;
		
	elseif strcmp(BC(idx).type, 'HEATFLOW')
		disp(['Applying heat flow boundary condition, ', num2str(BC(idx).value), ' W']);
		
		St = 0;
		
		for i = 1:4
			for j = 1:4
				if j == i
					continue;
				end
				for k = 1:j
					if k == i || k == j
						continue;
					end
					tmpIdx1 = find(ismember(E(:,i), BC(idx).targets)&ismember(E(:,j), BC(idx).targets)&ismember(E(:,k), BC(idx).targets));
					St += sum(cell2mat(Sea(i,j,k))(tmpIdx1));
				end
			end
		end
		
		q = BC(idx).value/St;
		
		for i = 1:4
			for j = 1:4
				if j == i
					continue;
				end
				for k = 1:j
					if k == i || k == j
						continue;
					end
					tmpIdx1 = find(ismember(E(:,i), BC(idx).targets)&ismember(E(:,j), BC(idx).targets)&ismember(E(:,k), BC(idx).targets));
					Fku(E(tmpIdx1,i)) += accumarray(E(tmpIdx1,i), q*cell2mat(Sea(i,j,k))(tmpIdx1))(E(tmpIdx1,i));
				end
			end
		end
		
	elseif strcmp(BC(idx).type, 'HEATFLUX')
		disp(['Applying heat flux boundary condition, ', num2str(BC(idx).value), ' W/mm²']);
		
		for i = 1:4
			for j = 1:4
				if j == i
					continue;
				end
				for k = 1:j
					if k == i || k == j
						continue;
					end
					tmpIdx1 = find(ismember(E(:,i), BC(idx).targets)&ismember(E(:,j), BC(idx).targets)&ismember(E(:,k), BC(idx).targets));
					Fku(E(tmpIdx1,i)) += accumarray(E(tmpIdx1,i), BC(idx).value*cell2mat(Sea(i,j,k))(tmpIdx1))(E(tmpIdx1,i));
				end
			end
		end
		
	elseif strcmp(BC(idx).type, 'CONVECTION')
		disp(['Applying convection boundary condition, ', num2str(BC(idx).value(1)), ' W/mm²ºC, ', num2str(BC(idx).value(2)), ' ºC']);
		
		for i = 1:4
			for j = 1:4
				if j == i
					continue;
				end
				for k = 1:j
					if k == i || k == j
						continue;
					end
					tmpIdx1 = find(ismember(E(:,i), BC(idx).targets)&ismember(E(:,j), BC(idx).targets)&ismember(E(:,k), BC(idx).targets));
					for i4 = 1:length(tmpIdx1)
						Fh(E(tmpIdx1(i4),i)) += BC(idx).value(1)*cell2mat(Sea(i,j,k))(tmpIdx1(i4))*BC(idx).value(2);
						Kh(E(tmpIdx1(i4),i),E(tmpIdx1(i4),i)) += BC(idx).value(1)*cell2mat(Sea(i,j,k))(tmpIdx1(i4));
					end
				end
			end
		end
		
	elseif strcmp(BC(idx).type, 'INTERNALHEATGENERATION')
		disp(['Applying internal heat generation condition, ', num2str(BC(idx).value), ' W/mm³']);
		
		for i = 1:4
			Fi(E(BC(idx).targets,i)) += accumarray(E(BC(idx).targets,i), V(E(BC(idx).targets,i))*BC(idx).value)(E(BC(idx).targets,i));
		end
		
	elseif strcmp(BC(idx).type, 'IRRADIATION')
		disp('Irradiation not yet implemented, ignoring.');
	end
end

disp(['Build boundary conditions script finilized. Execution time: ', num2str(toc), ' s']);