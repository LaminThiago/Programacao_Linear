param n;
param m;
param C {j in 1..m};
param d {i in 1..n, j in 1..m};
var x {i in 1..n, j in 1..m} binary;
var y {i in 1..n} >= 0;
var maior_distancia >= 0;
var S;
minimize dist_media:
	(S / n) +  100*(sum {i in 1..n} y[i]);
subject to distancia:
	sum {i in 1..n, j in 1..m} x[i,j] * d[i,j] = S;

subject to atendimento_unico {i in 1..n}:
    sum {j in 1..m} x[i,j] = 1;

subject to capacidade {j in 1..m}:
	sum {i in 1..n} x[i,j] <= C[j];

subject to maxdist {i in 1..n, j in 1..m}:
	maior_distancia >= x[i,j]*d[i,j];
subject to md:
	maior_distancia <= 30;
subject to menorque3 {i in 1..n}:
	sum {j in 1..m} x[i,j]*d[i,j] <= 3 + y[i];
