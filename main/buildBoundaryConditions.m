fdisp(program.logger, 'Build boundary conditions script initiated.');
tic;

program.analysis.U = zeros(columns(program.analysis.K),1); %Temperature
program.analysis.F = zeros(columns(program.analysis.K),1); #Heat
program.analysis.solvedU = false(columns(program.analysis.K),1); #Known
## temperature
program.analysis.solvedF = true(columns(program.analysis.K),1); #Known heat

program.analysis.Fpd = zeros(columns(program.analysis.K),1); #Unused, radiation
program.analysis.Fku = zeros(columns(program.analysis.K),1); #Heat flux
program.analysis.Fko = zeros(columns(program.analysis.K),1); #Heat flow
program.analysis.Fh = zeros(columns(program.analysis.K),1); #Convective heat
program.analysis.Kh = sparse(columns(program.analysis.K),columns(program.analysis.K));
## #Convection geometric coefficients
program.analysis.Fi = zeros(columns(program.analysis.K),1); #Internal heat
## generated

cd('Loads');
for idx = 1:length(program.analysis.BoundaryConditions)
	if strcmp(program.analysis.BoundaryConditions(idx).Type, 'LoadThermalTemperature')
		LoadThermalTemperature;
	elseif strcmp(program.analysis.BoundaryConditions(idx).Type, 'LoadThermalHeatFlow')
		LoadThermalHeatFlow;
	elseif strcmp(program.analysis.BoundaryConditions(idx).Type, 'LoadThermalHeatFlux')
		LoadThermalHeatFlux;
	elseif strcmp(program.analysis.BoundaryConditions(idx).Type, 'LoadThermalConvection')
		LoadThermalConvection;
	elseif strcmp(program.analysis.BoundaryConditions(idx).Type, 'LoadThermalInternalHeat')
		LoadThermalInternalHeat;
	elseif strcmp(program.analysis.BoundaryConditions(idx).Type, 'LoadThermalRadiation')
		fdisp(program.logger, 'Irradiation not yet implemented, ignoring.');
	end
end
cd(program.pwd);

fdisp(program.logger, ['Build boundary conditions script finilized. Execution time: ', num2str(toc), ' s']);