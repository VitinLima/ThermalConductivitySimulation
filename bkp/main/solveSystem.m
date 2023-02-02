disp('Solve system script initiated.');
tic;

U(!solvedU) = (K(!solvedU, !solvedU) - Kh(!solvedU,!solvedU))\(F(!solvedU) - K(!solvedU,solvedU)*U(solvedU) - Fku(!solvedU) - Fko(!solvedU) - Fh(!solvedU) - Fi(!solvedU));
utd = true;

disp(['Solve system script finilized. Execution time: ', num2str(toc), ' s']);