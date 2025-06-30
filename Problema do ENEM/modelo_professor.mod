param n; 
#número de estudantes

param m; #número de escolas

param d {i in 1..n, j in 1..m}; 
#matriz de distâncias da residência do estudante a escola

param C {j in 1..m}; #Capacidade da escola

var x {i in 1..n, j in 1..m} binary; 
#variável de decisão xij=1 de o estudante i é alocado à escola j

var t; #máxima distância

var S; #soma

minimize maxdist: S/n;

subject to distancia: sum{i in 1..n,j in 1..m} x[i,j]*d[i,j]=S;

subject to distmax {i in 1..n}: sum{j in 1..m} x[i,j]*d[i,j]<=t;

subject to tt: t<=30;

subject to alocaest {i in 1..n}: sum{j in 1..m} x[i,j]=1;

subject to capacidade {j in 1..m}: sum {i in 1..n} x[i,j]<=C[j];














