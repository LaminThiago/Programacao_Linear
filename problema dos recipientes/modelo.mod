set PLANTA;
set MAQUINA;
set TIPO;
set TRIMESTRE; 

param planta_maquina {MAQUINA} integer;
param produz_tipo {MAQUINA, TIPO} binary;

set M_P {p in PLANTA} := {m in MAQUINA: planta_maquina[m] = p};
set TIPO_M {m in MAQUINA} := {t in TIPO: produz_tipo[m,t] = 1};
set TIPO_P {p in PLANTA} := 
    union {m in M_P[p]} TIPO_M[m];

param demanda {PLANTA, TIPO, TRIMESTRE} >= 0;
param custo {m in MAQUINA, TIPO_M[m]} >= 0;
param dias_maquina {m in MAQUINA, TIPO_M[m]} >= 0;
param disponibilidade_maquina {MAQUINA, TRIMESTRE} >= 0;
param custo_transporte {PLANTA, PLANTA} >= 0, default 0;
param armazenamento {PLANTA, TRIMESTRE} >= 0;
param manuseio {PLANTA, TIPO} >= 0, default 0;

var x {p in PLANTA, m in M_P[p], t in TIPO_M[m], tr in TRIMESTRE} >= 0; #Quantidade Produzida

var A {p in PLANTA, t in TIPO_P[p], tr in TRIMESTRE} >= 0; #Quantidade armazenada

var T {p in PLANTA, pp in PLANTA diff {p}, t in TIPO_P[p], tr in TRIMESTRE: t in TIPO_P[pp]} >= 0;#Quantidade Transferida

minimize gasto:
	sum {p in PLANTA, m in M_P[p], t in TIPO_M[m], tr in TRIMESTRE} (x[p, m, t, tr] * custo[m, t])
	+sum {p in PLANTA, t in TIPO_P[p], tr in TRIMESTRE} (A[p, t, tr] * manuseio[p, t])
	+sum {p in PLANTA, pp in PLANTA diff {p}, t in TIPO_P[p], tr in TRIMESTRE: t in TIPO_P[pp]} (T[p, pp, t, tr] * custo_transporte[p, pp]);
subject to atender_demanda {p in PLANTA, t in TIPO_P[p], tr in TRIMESTRE}:
    sum {m in M_P[p]: produz_tipo[m,t] = 1} x[p, m, t, tr] #Producao no trimestre
  + sum {pp in PLANTA: pp != p and t in TIPO_P[pp]} T[pp, p, t, tr] #Transferencias recebidas
  + (if tr > 1 then A[p, t, tr - 1] else 0) #Estoque
  >= demanda[p, t, tr]
  + sum {pp in PLANTA: pp != p and t in TIPO_P[pp]} T[p, pp, t, tr] #Transferencias enviadas
  + A[p, t, tr]; # Estoque do mês seguinte
subject to disponibilidade {m in MAQUINA, tr in TRIMESTRE}:
	sum {t in TIPO_M[m]} (x[planta_maquina[m], m, t, tr] * dias_maquina[m, t]) <= disponibilidade_maquina[m, tr];
subject to capacidade_armazenamento {p in PLANTA, tr in TRIMESTRE}:
	sum {t in TIPO_P[p]} (A[p, t, tr]) <= armazenamento[p, tr];