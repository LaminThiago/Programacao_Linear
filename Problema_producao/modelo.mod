set PRODUTO;
set RECURSO;

param lucro {PRODUTO} integer;
param disponibilidade {RECURSO} integer;
param consumo {p in PRODUTO, r in RECURSO} integer;

var x {PRODUTO} >= 0 ;

maximize lucro_total:
	sum {i in PRODUTO} x[i] * lucro[i];
subject to disponibilidade_recursos {r in RECURSO}:
	sum {p in PRODUTO} (x[p] * consumo[p, r]) <= disponibilidade[r];