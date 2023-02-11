clc;

pkg load symbolic
syms x1 x2 x3 x4 y1 y2 y3 y4 z1 z2 z3 z4 Q1 Q2 Q3 Q4
sympref display flat

A = [x1 y1 z1 1; x2 y2 z2 1; x3 y3 z3 1; x4 y4 z4 1]
b = [Q1;Q2;Q3;Q4]

c = A\b;

[KA1, tA1] = coeffs(c(1), [Q1]);
[KA2, tA2] = coeffs(c(1), [Q2]);
[KA3, tA3] = coeffs(c(1), [Q3]);
[KA4, tA4] = coeffs(c(1), [Q4]);
KA1 = KA1(1);
KA2 = KA2(1);
KA3 = KA3(1);
KA4 = KA4(1);

[KB1, tB1] = coeffs(c(2), [Q1]);
[KB2, tB2] = coeffs(c(2), [Q2]);
[KB3, tB3] = coeffs(c(2), [Q3]);
[KB4, tB4] = coeffs(c(2), [Q4]);
KB1 = KB1(1);
KB2 = KB2(1);
KB3 = KB3(1);
KB4 = KB4(1);

[KC1, tC1] = coeffs(c(3), [Q1]);
[KC2, tC2] = coeffs(c(3), [Q2]);
[KC3, tC3] = coeffs(c(3), [Q3]);
[KC4, tC4] = coeffs(c(3), [Q4]);
KC1 = KC1(1);
KC2 = KC2(1);
KC3 = KC3(1);
KC4 = KC4(1);

[KD1, tD1] = coeffs(c(4), [Q1]);
[KD2, tD2] = coeffs(c(4), [Q2]);
[KD3, tD3] = coeffs(c(4), [Q3]);
[KD4, tD4] = coeffs(c(4), [Q4]);
KD1 = KD1(1);
KD2 = KD2(1);
KD3 = KD3(1);
KD4 = KD4(1);

function Ki = formatSymbolicEquation(Ki)
	Ki = char(Ki);
	Ki = strjoin(strsplit(Ki, '*'), '.*');
	Ki = strjoin(strsplit(Ki, '/'), './');
	Ki = strjoin(strsplit(Ki, 'x1'), 'N(E(:,1),1)');
	Ki = strjoin(strsplit(Ki, 'x2'), 'N(E(:,2),1)');
	Ki = strjoin(strsplit(Ki, 'x3'), 'N(E(:,3),1)');
	Ki = strjoin(strsplit(Ki, 'x4'), 'N(E(:,4),1)');
	Ki = strjoin(strsplit(Ki, 'y1'), 'N(E(:,1),2)');
	Ki = strjoin(strsplit(Ki, 'y2'), 'N(E(:,2),2)');
	Ki = strjoin(strsplit(Ki, 'y3'), 'N(E(:,3),2)');
	Ki = strjoin(strsplit(Ki, 'y4'), 'N(E(:,4),2)');
	Ki = strjoin(strsplit(Ki, 'z1'), 'N(E(:,1),3)');
	Ki = strjoin(strsplit(Ki, 'z2'), 'N(E(:,2),3)');
	Ki = strjoin(strsplit(Ki, 'z3'), 'N(E(:,3),3)');
	Ki = strjoin(strsplit(Ki, 'z4'), 'N(E(:,4),3)');
end

KA1 = formatSymbolicEquation(KA1);
KA2 = formatSymbolicEquation(KA2);
KA3 = formatSymbolicEquation(KA3);
KA4 = formatSymbolicEquation(KA4);

KB1 = formatSymbolicEquation(KB1);
KB2 = formatSymbolicEquation(KB2);
KB3 = formatSymbolicEquation(KB3);
KB4 = formatSymbolicEquation(KB4);

KC1 = formatSymbolicEquation(KC1);
KC2 = formatSymbolicEquation(KC2);
KC3 = formatSymbolicEquation(KC3);
KC4 = formatSymbolicEquation(KC4);

KD1 = formatSymbolicEquation(KD1);
KD2 = formatSymbolicEquation(KD2);
KD3 = formatSymbolicEquation(KD3);
KD4 = formatSymbolicEquation(KD4);

FID = fopen('GeometricLinearCoefficients.txt', 'w');

fdisp(FID, strjoin({'KA1 = ', KA1}, ''));
fdisp(FID, strjoin({'KA2 = ', KA2}, ''));
fdisp(FID, strjoin({'KA3 = ', KA3}, ''));
fdisp(FID, strjoin({'KA4 = ', KA4}, ''));

fdisp(FID, strjoin({'KB1 = ', KB1}, ''));
fdisp(FID, strjoin({'KB2 = ', KB2}, ''));
fdisp(FID, strjoin({'KB3 = ', KB3}, ''));
fdisp(FID, strjoin({'KB4 = ', KB4}, ''));

fdisp(FID, strjoin({'KC1 = ', KC1}, ''));
fdisp(FID, strjoin({'KC2 = ', KC2}, ''));
fdisp(FID, strjoin({'KC3 = ', KC3}, ''));
fdisp(FID, strjoin({'KC4 = ', KC4}, ''));

fdisp(FID, strjoin({'KD1 = ', KD1}, ''));
fdisp(FID, strjoin({'KD2 = ', KD2}, ''));
fdisp(FID, strjoin({'KD3 = ', KD3}, ''));
fdisp(FID, strjoin({'KD4 = ', KD4}, ''));

fclose(FID);