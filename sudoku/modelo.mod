param mapa {1..9, 1..9} integer;
var x {1..9, 1..9, 1..9} binary;
var nada integer;

minimize gasto:
	nada
subject to unicidade {i in 1..9, j in 1..9}: #Cada quadrado tem um numero
    sum {k in 1..9} x[i, j, k] = 1;
subject to linha {i in 1..9, k in 1..9}: #Cada linha tem um numero de cada
    sum {j in 1..9} x[i, j, k] = 1;
subject to coluna {j in 1..9, k in 1..9}: #Cada coluna tem um numero de cada
    sum {i in 1..9} x[i, j, k] = 1;
subject to capacidade_armazenamento {p in PLANTA, tr in TRIMESTRE}:
	sum {t in TIPO_P[p]} (A[p, t, tr]) <= armazenamento[p, tr];