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
	2. Censure (tipo I, II, random-non informative che non dipendono dal rischio, random-informative che dipendono dal rischio)
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



### [1.3] Modelli a tempo continuo

#### [1.3.1] Modelli semi-parametrici
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
	1. Violazione assunzione proporzionalità
	2. Verifica proporzionalità 
		- Grafico (analisi del logaritmo del rischio cumulato)
		- Residui di Schoenfeld (l'andamento dello scarto tra la covariata dell'i-esimo individuo e la sua media nel tempo è casuale)
		- Modello con interazione tra tempo e covariate
	3. Superamento ipotesi proporzionalità
		- Modello stratificato
		- Modello con interazione tra il tempo (continuo o discreto) e le covariate


#### [1.3.2] Modelli parametrici
1. Calcolo delle funzioni di densità, sopravvivenza e rischio
2. Modelli di regressione parametrici
	1. Rischi proporzionali (PH)
	2. Tempi accelarati (AFT)
3. Modello Esponenziale, Weibull, Esponenziale a tratti
	1. Senza covariate
	2. Con covariate (Parametrizzazione PH e AFT)
4. Stima di massima verosimiglianza



## 1
1. Item1
  1.1. SubItemA
  1.2. SubItemB
    - wat
      - inception noise

## 2
1. Item1
  1.1, SubItemA
  1.2. SubItemB
2. Item2 
  2.1. SubItem 
  2.2. SubItem

## 3
1. Item1
   1. SubItemA
   2. SubItemB
      - wat
        - hi

## 4
  1. List item 1.
  2. List item 2.
     1. Sublist item 1.
     2. Sublist item 2.
     3. Sublist item 3.
  3. List item 3.

## 5
1. List item 1.
2. List item 2.
   1. Sublist item 1.
   2. Sublist item 2.
   3. Sublist item 3.
3. List item 3.

## 6
1. Item1
  1.1. SubItemA
  1.2. SubItemB
    - wat
      - inception noise





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




## SAS Labs
<button class="collapsible" id="es1">Esempio 1: LT e KM (0)</button>
<div class="content" id="es1data" markdown="1">

	```sas
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
	```
</div>
<embed src="/assets/images/Statistica/EHA_1.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es2">Esempio 2: LT e KM (1)</button>
<div class="content" id="es2data" markdown="1">

	```sas
	/* 
	Obiettivo: con LT e KM, esaminare se e come la propensione a lasciare 
	il mercato del lavoro differisce tra gli uomini e le donne nati tra 1929 e 1951. 
	*/
	
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
	```
</div>
<embed src="/assets/images/Statistica/EHA_2.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es3">Esempio 3: Cox base (0)</button>
<div class="content" id="es3data" markdown="1">

	```sas
	* leggo i dati da inserimento;
	data dati;
	input time cens edu edu1 edu2 age ;   /*edu=B, M, A; age=anni compiuti */
	cards;
	0.1 1 1 1 0 20
	0.2 1 2 0 1 18
	0.5 0 3 0 0 29
	0.5 1 1 1 0 30
	0.7 1 2 0 1 17
	0.8 1 3 0 0 23
	1.3 1 1 1 0 29
	1.5 1 2 0 1 33
	1.8 0 3 0 0 25
	2.5 1 1 1 0 18
	2.5 1 2 0 1 20
	2.5 0 3 0 0 31
	3.2 1 1 1 0 35
	3.7 1 2 0 1 17
	3.8 0 3 0 0 24
	;
	run;

	/*stimo modelli*/
	proc phreg  data=dati;
	model time*cens (0) = edu1 edu2;  /* ! anche class edu se …*/
	title “predittori rischio uscita disoccupazione: education”;
	run;

	proc phreg  data=dati;
	class edu;  *NB ref=3, se non si specifica la class viene considerata come numerica;
	model time*cens (0) = edu;  
	title “predittori rischio uscita disoccupazione: education”;
	run;

	proc phreg  data=dati;
	model time*cens (0) = edu1 edu2 age;
	title “predittori rischio uscita disoccupazione: age & edu”;
	run;
	```
</div>
<embed src="/assets/images/Statistica/EHA_3.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es4">Esempio 4: Cox base (1)</button>
<div class="content" id="es4data" markdown="1">

	```sas
	/* 
	Obiettivo: stimare predittori uscita mercato del lavoro tra un set covariate
	*/
	
	libname dir "/home/dati";
	data pippo;
	set dir.rrdat1;
	durata=tfin-tstart+1;
	des=0;
	if tfin lt ti then des=1; /* pongo=0 casi censurati*/

	/* calcolo data nascita e esamino distribuzione anno nascita */
	anno1=(tb-1)/12+1900; 
	anno2=int(anno1);  
	run;

	*verifico cosa ho ottenuto per sesso;
	proc freq;   
	table anno2*sex;  
	run; 
											
	*costruisco covariate necessarie per modello;

	data pluto;
	set pippo;

	/* coorte nascita categoriale*/
	coorte=3;
	if anno2 le 1931 then coorte=1;
	if anno2 ge 1939 and anno2 le 1941 then coorte=2;

	/* coorte nascita dummy: coho1 = reference group 1929-31*/
	coho2=0; coho3=0;
	if tb ge 468 and tb le 504 then coho2=1;      /* nati tra 1939-41 */
	if tb ge 588 and tb le 624 then coho3=1;      /* nati tra 1949-11  */
	* ALTERNATIVAMENTE DUMMY USANDO DIRETTAMENTE COORTE OPPURE ANNO2;

	/* altre variabili utili */                                                  
	pnoj=noj-1;                 /* numero lavori precedenti*/
	lfx=tstart - te;            /* esperienza lavorativa */
	run;

	*STIMO MODELLO COX - uso dummy coorte in model - NO SEX;

	proc phreg  data=pluto;
	model durata*des (0) = edu coho2 coho3 lfx pnoj pres;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;
	
	/* 
	Nostre ipotesi: 
	- se l'istruzione è bassa accelera l'uscita dal mondo da lavoro 
	- Il prestigio del lavoro accelera o rallenta l'uscita? Probabilmente ritarda
	
	Risultati:
	- tranne il numero di episodi è tutto significativo
	- per ogni anno aggiuntivo di educazione il rischio di lasciare il posto di lavoro aumenta del 6%,
	l'ipotesi potrebbe essere che chi ha un educazione alta ha anche un ambizione maggiore e lo lascia
	con più facilità.
	- la coorte2 e 3 aumenta il rischio (51% e 36%), diventano più mobile, rispetto il gruppo di base, 
	si può prendere in riferimento la coorte2 e capire se la 3 è significativamente diverso
	- all'aumentare dell'esperienza lavorativa diminuisce per ogni mese il rischio di uscire
	- all'aumentare del prestigio del lavoro, diminuisce la propensione ad abbandonare quel lavoro
	*/
	
	*L'esercizio successivo è con la variabile SEX;
	```
</div>
<embed src="/assets/images/Statistica/EHA_4.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es5">Esempio 5: Cox base (2)</button>
<div class="content" id="es5data" markdown="1">

	```sas
	/* 
	Obiettivo: stimare predittori uscita dal mercato del lavoro tra 
	un set covariate separatamente per maschi e femmine (Ci sono effetti 
	delle covariate che interagiscono con il genere?)
	*/
	
	libname dir "/home/dati";

	* con data dir.pippo rendo permanente il df;
	data dir.pippo;
	set dir.rrdat1;
	durata=tfin-tstart+1;
	des=0;
	if tfin lt ti then des=1; /* pongo=0 casi censurati*/

	/* calcolo data nascita e esamino distribuzione anno nascita */
	anno1=(tb-1)/12+1900; 
	anno2=int(anno1);  

	/* coorte nascita categoriale*/
	coorte=3;
	if anno2 le 1931 then coorte=1;
	if anno2 ge 1939 and anno2 le 1941 then coorte=2;

	/* coorte nascita dummy: coho1 = reference group 1929-31*/
	coho2=0; coho3=0;
	if tb ge 468 and tb le 504 then coho2=1;      /* nati tra 1939-41 */
	if tb ge 588 and tb le 624 then coho3=1;      /* nati tra 1949-11  */

	/* altre variabili utili */                                                  
	pnoj=noj-1;                 /* numero lavori precedenti*/
	lfx=tstart - te;            /* esperienza lavorativa */
	run;

	/* 
	Ipotizzo interazione tra maschi e femmine, stimo due modelli distinti di Cox
	Scoprire se c'è qualche covariata che influenza in modo diverso i maschi e femmine
	*/

	proc phreg data=dir.PIPPO;;
	WHERE SEX=1;                 /* altrimenti usare prima if */     
	model durata*des (0) = edu coho2 coho3 lfx pnoj pres;
	title “MASCHI analisi predittori rischio uscita mercato lavoro”;
	run;

	*non metto data perché prende in riferimento l'ultimo df;
	proc phreg;
	WHERE SEX=2;
	model durata*des (0) = edu coho2 coho3 lfx pnoj pres;
	title “FEMMINE analisi predittori rischio uscita mercato lavoro”;
	run;
	
	/*
	Confrontando i due modelli emerge che 
	- EDU è prevalente maggiormente nelle femmine
	- le coorti sono crescenti per gli uomini
	*/

	proc phreg  data=dir.PIPPO;
	CLASS COORTE;   /*il riferimento è alla COORTE3*/
	model durata*des (0) = edu COORTE lfx pnoj pres;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;
	proc phreg  data=dir.PIPPO;
	CLASS COORTE (REF=FIRST);   /*RIF=COORTE1*/
	model durata*des (0) = edu COORTE lfx pnoj pres;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;

	/* 
	dato quello che era emerso su SEX ed EDU li aggiungo sia singolarmente
	che con la loro interazione
	*/
	proc phreg  data=dir.PIPPO;
	CLASS COORTE (REF=FIRST);   /*RIF=COORTE1*/
	model durata*des (0) = edu COORTE lfx pnoj pres sex sex*edu;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;
	/*
	Perde la significatività SEX e fa diventare EDU negativo
	non riusciamo a sfruttare l'interazione così com'è
	Si potrebbe rendere categoriale EDU e fare incroci con SEX
	*/
	```
</div>
<embed src="/assets/images/Statistica/EHA_5.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<!---

<button class="collapsible" id="es6">Esempio 6: vuoto</button>
<div class="content" id="es6data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistica/EHA_6.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es7">Esempio 7: vuoto</button>
<div class="content" id="es7data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistica/EHA_7.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es8">Esempio 8: vuoto</button>
<div class="content" id="es8data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistica/EHA_8.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es9">Esempio 9: vuoto</button>
<div class="content" id="es9data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistica/EHA_9.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

--->










...
