fdisp(program.logger, 'Solve system script initiated.');
tic;

solvedIdx = program.analysis.solvedU;
unsolved_idx = !solvedIdx;

if program.direct_solve
  program.analysis.U(unsolved_idx) = (program.analysis.K(unsolved_idx, unsolved_idx) - program.analysis.Kh(unsolved_idx,unsolved_idx))\(program.analysis.F(unsolved_idx) - program.analysis.K(unsolved_idx,solvedIdx)*program.analysis.U(solvedIdx) - program.analysis.Fku(unsolved_idx) - program.analysis.Fko(unsolved_idx) - program.analysis.Fh(unsolved_idx) - program.analysis.Fi(unsolved_idx));
else

end

fdisp(program.logger, ['Solve system script finilized. Execution time: ', num2str(toc), ' s']);
