param n; #n alimentos
param m; #m categorias
param R {j in 1..m}; #requisitos minimos
param C {j in 1..n}; #calorias
param T {i in 1..n, j in 1..m}; #nutrientes
var x {i in 1..n} >= 0;

minimize calorias:
	sum {i in 1..n} x[i] * C[i];

subject to nutrientes {j in 1..m}:
    sum {i in 1..n} x[i] * T[i,j] >= R[j];