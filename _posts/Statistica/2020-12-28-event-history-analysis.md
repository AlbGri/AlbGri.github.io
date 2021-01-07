---
title: "Appunti: Event History Analysis"
excerpt: ""
date: 2021-01-03
tags: [statistics, math, theory, university]
mathjax: "true"
---

*in costruzione*


## [1] Metodi per l'analisi di dati di durata

### [1.1] Basi dell'analisi dei dati di durata

#### [1.1.1] Concetti base
1. Ambiti ed esempi
2. Definizioni base
	1. Dominio, evento, episodio, popolazione a rischio
	2. Caso semplice: 1 episodio, 1 stato destinazione
	3. Multistato o rischi competitivi: 1 episodio, 2+ stati destinazione
	4. Multi-episodio: 2+ episodi, 1 stato destinazione
	5. Multistato o multi-episodio
3. Modellazione specifica
	1. Limiti modello lineare
	2. Censure (tipo I, II, random-informative, random-non informative)
	3. Covariate (variabili o costanti rispetto il tempo)
4. Disegni longitudinali retrospettivi
	1. Indagini retrospettive
5. Disegni longitudinali prospettivi
	1. Panel (con waves)
	2. Studi di follow-up (studi coorte)
	3. Record-Linkage

#### [1.1.2] Funzioni base nel continuo e nel discreto
1. Funzioni base con tempo continuo
	1. Condizioni
	2. Densità, Ripartizione, Sopravvivenza
	3. Funzione di rischio
	4. Rischio integrato
	5. Relazioni tra le funzioni
2. Funzioni base con tempo discreto
	1. Discreto
	2. Continuo discretizzato

#### [1.1.3] Tipologie di metodi
1. Metodi per tempo continuo
	1. Metodi non parametrici: Kaplan-Meier (Product-Limit)
	2. Modelli di regressione: PH, AFT
2. Metodi per tempo discreto
	1. Metodi non parametrici: Life Table (Actuarial Method)
	2. Modelli di regressione: Logit, Probit

### [1.2] Metodi non parametrici

#### [1.2.1] Kaplan-Meier (Product Limit)
1. Calcolo delle funzioni e indici
2. Esplorazione forma del rischio
3. Funzione di sopravvivenza
	1. Analisi quantili
	2. Confronto tra gruppi
	3. Test di omogeneità (grafico, log-rank rest, wilcoxon test)
4. Funzioni di pseudo-sopravvivenza per rischi competitivi

#### [1.2.2] Life Table (o Attuariale)
1. Tavola di eliminazione: stima rischio, probabilità e sopravvivenza
2. Altre funzioni (es. rischio integrato)
3. Intervalli di confidenza

##### Coding in SAS: LT e KM
<button class="collapsible" id="yaml">Esempio 1</button>
<div class="content" id="yamldata" markdown="1">
* creo df;
data dati;
input time cens;
cards;
0.1 1
0.2 1
0.5 0
0.5 1
0.7 1
0.8 1
1.3 1
1.5 1
1.8 0
2.5 1
2.5 1
2.5 0
3.2 1
3.7 1
3.8 0
;
run;

* stima LT;
proc lifetest 
data=dati
method= lt
intervals= 1 2 3 4
plots =(s h) graphics  /* se una sola funzione non serve () */
outsurv=conf1;
time time*cens(0);
title “analisi LT durata episodi”;
run;

* stima KM;
proc lifetest 
data=dati
plots =(s h) graphics  
outsurv=conf2;
time time*cens(0);
title “analisi KM durata episodi”;
run;
</div>



<button class="collapsible" id="yaml">Esempio 2</button>
<div class="content" id="yamldata" markdown="1">
* carico df;
libname dir "/home/dati";
data pippo;
set dir.rrdat1;
durata=tfin-tstart+1;
des=0;
if tfin lt ti then des=1; /* pongo=0 casi censurati*/
run;

* stime con LT (unico gruppo//distinto per M e F);
proc lifetest
	data=pippo
	method=life
	width=30
plots =(s h) graphics   
/* N.B: se più di 1 funzione (ls lls ...) usare () altrimenti: plots=s graphics */
	outsurv=conf1;
time durata*des (0);
/* chiedo S per maschi e femmine */
*strata sex;
title “analisi LT durata episodi lavoro uomini e donne”;
run;

* stime con KM per M e F;
proc lifetest
	data=pippo
	plots=(s(cl) h(cl) ls) graphics
	outsurv=conf2;
time durata*des (0);
strata sex;
title ”analisi KM su dati durata occupazione – M e F”; 
symbol1 v=none color=black line=1;
symbol2 v=none color=red line=2;
run;
proc print data=conf2;
run;
</div>





### [1.3] Modelli a tempo continuo

#### Modello semi-parametrico
1. Modello base
	1. Caratteristiche modello di Cox
	2. Significato PH (Proportional Hazard)
2. Parametri e risk score
	1. Interpretazione parametri
	2. Significatività statistica dei parametri
	3. Risk score
3. Bontà adattamento modello
	1. Rapporto di verosimiglianza
	2. AIC e BIC
4. Modello a rischi competitivi
5. Stima di massima verosimiglianza 
	1. Metodo FL (Full Likelihood - “Qual è la probabilità che l'individuo i-mo sperimenti un evento nel $$t_j$$ osservato?'')
	2. Complicazioni: censure e rischio base
	3. Metodo PL (Partial Likelihood - “Dato che qualcuno sperimenta un evento al tempo $$t_j$$ qual è la probabilità che si tratti dell'individuo i-mo?'') basato sui rank dei tempi
	4. Massimizzazione PL con metodi numerici iterativi
6. Ties
	1. Exact (tutti i possibili ordinamenti)
	2. Breslow (come Exact ma shrinkage to 0 se ci sono molti ties)
	3. Efron (come Breslow ma più vicino all'Exact)
	4. Discrete (eventi effettivamente doppioni)
7. Stima e utilizzo delle funzioni base
8. Variabili tempo-dipendenti
	1. Caratteristiche VTD
	2. Modello con VTD
	3. Come tenere sotto controllo variabili TD
	4. Spazio stati TD
	5. Effetti immediati o differiti nel tempo
9. Effetti non proporzionali
	1. ...


##### SAS
<button class="collapsible" id="yaml">Esempio 3</button>
<div class="content" id="yamldata" markdown="1">
codice
</div>



#### [1.3.1] Classi di modelli
#### [1.3.2] Modello semiparametrico a rischi proporzionali e sue estensioni oltre il modello base (variabili tempo dipendenti, effetti non proporzionali, rischi competitivi)
#### [1.3.3] Modelli parametrici a rischi proporzionali e a tempi accelerati (esponenziale, weibull, esponenziale a tratti)

### [1.4] Modelli a tempo discreto
#### [1.4.1] Person Period
#### [1.4.2] Modello a odds proporzionali












## [2] Modelli Frailty
### [2.1] Introduzione al concetto di Frailty
### [2.2] Frailty univariati
#### [2.2.1] Modelli semiparametrici e parametrici
#### [2.2.2] Metodi di stima
### [2.3] Shared Frailty Models


## [3] Modelli Multilevel
### [3.1] Il modello Multilevel come pooling parziale dei dati
### [3.2] Modelli a risposta continua
#### [3.2.1] Modelli a intercetta casuale
#### [3.2.2] Modelli a effetti casuali
#### [3.2.3] Inferenza per effetti fissi e per effetti casuali
### [3.3] Modelli a risposta discreta
#### [3.3.1] Modelli logistici a effetti casuali
#### [3.3.2] Modelli a tempo discreto con effetti casuali
#### [3.3.3] Inferenza per effetti fissi ed effetti casuali.





...
