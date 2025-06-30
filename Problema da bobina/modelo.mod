param n; #n tipos de bobina
param m; #m padroes de corte
param D {j in 1..n}; #demanda
param C {i in 1..n, j in 1..m}; #padroes de corte
var x {i in 1..m} >= 0 integer;

minimize custo:
	sum {i in 1..m} x[i];

subject to demanda {i in 1..n}:
    sum {j in 1..m} x[j] * C[i,j] >= D[i];
