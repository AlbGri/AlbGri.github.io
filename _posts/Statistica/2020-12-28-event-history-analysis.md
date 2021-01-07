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




## SAS Labs
<button class="collapsible" id="es1">Esempio 1: LT e KM</button>
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


<button class="collapsible" id="es2">Esempio 2: LT e KM</button>
<div class="content" id="es2data" markdown="1">

	```sas
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


<button class="collapsible" id="es3">Esempio 3: vuoto</button>
<div class="content" id="es3data" markdown="1">

	```sas
	codice
	```
</div>


#############################

<html class="ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3" lang="it" xml:lang="it" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta content="SAS 9.4" name="generator"/>
<title>Risultati: es0_lt_km.sas</title>
<style>
/*<![CDATA[*/
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c section > table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c section > pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c div > table,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c div > pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c article > table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c article > pre,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j section > table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j section > pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j div > table,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j div > pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j article > table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j article > pre,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c p.note, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c p.warning, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c p.error, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c p.fatal,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j p.note, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j p.warning, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j p.error, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j p.fatal,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.c > table.layoutcontainer, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body.j > table.layoutcontainer { margin-left: auto; margin-right: auto }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.l table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.l pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.l p.note,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.l p.warning, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.l p.error, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.l p.fatal { margin-left: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.c table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.c pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.c p.note,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.c p.warning, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.c p.error, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.c p.fatal { margin-left: auto; margin-right: auto }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r p.note,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r table, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r pre, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r p.note,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r p.warning, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r p.error, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion.r p.fatal { margin-right: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 article, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 aside, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 details, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 figcaption, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 figure, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 footer, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 header, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 hgroup, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 nav, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 section { display: block }
html.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 { font-size: 100% }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body { margin: 1em; font-size: 13px; line-height: 1.231 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 sup { position: relative; vertical-align: baseline; bottom: 0.25em; font-size: 0.8em }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 sub { position: relative; vertical-align: baseline; top: 0.25em; font-size: 0.8em }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 ul, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 ol { margin: 1em 0; padding: 0 0 0 40px }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 dd { margin: 0 0 0 40px }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 nav ul, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 nav ol { list-style: none; list-style-image: none; margin: 0; padding: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 img { border: 0; vertical-align: middle }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 svg:not(:root) { overflow: hidden }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 figure { margin: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 table { border-collapse: collapse; border-spacing: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutcontainer { border-collapse: separate; border-spacing: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 p { margin-top: 0; text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 h1.heading1 { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 h2.heading2 { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 h3.heading3 { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 h4.heading4 { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 h5.heading5 { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 h6.heading6 { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 span { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 table { margin-bottom: 1em }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 td, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 th { text-align: left; padding: 3px 6px; vertical-align: top }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 td[class$="fixed"], .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 th[class$="fixed"] { white-space: pre }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 section, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 article { padding-top: 1px; padding-bottom: 8px }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 hr.pagebreak { height: 0px; border: 0; border-bottom: 1px solid #c0c0c0; margin: 1em 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .stacked-value { text-align: left; display: block }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .stacked-cell > .stacked-value, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 td.data > td.data, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 th.data > td.data, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 th.data > th.data, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 td.data > th.data, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 th.header > th.header { border: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .stacked-cell > div.data { border-width: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer { white-space: nowrap; margin-bottom: 1em }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > p { margin: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > p > span { display: inline-block; width: 100%; white-space: normal }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .batch { display: table }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .toc { display: none }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .proc_note_group, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .proc_title_group { margin-bottom: 1em }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 p.proctitle { margin: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 p.note, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 p.warning, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 p.error, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 p.fatal { display: table }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .notebanner, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .warnbanner, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .errorbanner, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .fatalbanner,
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .notecontent, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .warncontent, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .errorcontent, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .fatalcontent { display: table-cell; padding: 0.5em }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .notebanner, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .warnbanner, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .errorbanner, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .fatalbanner { padding-right: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body > div > ol li { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .beforecaption > h4 { margin-top: 0; margin-bottom: 0 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .c { text-align: center }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .r { text-align: right }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .l { text-align: left }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .j { text-align: justify }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .d { text-align: right }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .b { vertical-align: bottom }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .m { vertical-align: middle }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .t { vertical-align: top }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 a:active { color: #800080 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .aftercaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
    padding-top: 4pt;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .batch > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .batch > tbody, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .batch > thead, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .batch > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .batch { border: hidden; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .batch {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: 'SAS Monospace', 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    padding: 7px;
    }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .beforecaption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .body {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    margin-left: 8px;
    margin-right: 8px;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bodydate {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    text-align: right;
    vertical-align: top;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bycontentfolder {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .byline {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > colgroup > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > colgroup, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > * > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > thead, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > tbody, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer > tfoot { border: none; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .bylinecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .caption {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .cell, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .container {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .contentfolder, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .contentitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .contentproclabel, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .contentprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .contents {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .contentsdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .contenttitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .continued {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .data, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .dataemphasis {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .dataemphasisfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .dataempty {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .datafixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .datastrong {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .datastrongfixed {
    background-color: #ffffff;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .date {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .document {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .errorbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .errorcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .errorcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .extendedpage {
    background-color: #fafbfe;
    border-style: solid;
    border-width: 1pt;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
    text-align: center;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .fatalbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .fatalcontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .fatalcontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .folderaction {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .footer {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .footeremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .footeremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .footerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .footerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .footerstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .footerstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .frame {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .graph > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .graph > tbody, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .graph > thead, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .graph > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .graph { border: hidden; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .graph {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .header {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .headeremphasis {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .headeremphasisfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .headerempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .headerfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .headersandfooters {
    background-color: #edf2f9;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .headerstrong {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .headerstrongfixed {
    background-color: #d8dbd3;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #000000;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .heading1, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .heading2, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .heading3, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .heading4, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .heading5, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .heading6 { font-family: Arial, Helvetica, sans-serif }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .index {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .indexaction, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .indexitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .indexprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .indextitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutcontainer, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .layoutregion {
    border-width: 0;
    border-spacing: 30px;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .linecontent {
    background-color: #fafbfe;
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 a:link { color: #0000ff }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list3, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list4, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list5, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list6, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list7, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list8, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .list9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: disc;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem10 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem2 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: circle;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem3, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem4, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem5, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem6, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem7, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem8, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .listitem9 {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: square;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .note {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .notebanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .notecontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .notecontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .output > colgroup {
    border-left: 1px solid #c1c1c1;
    border-right: 1px solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .output > tbody, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .output > thead, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .output > tfoot {
    border-top: 1px solid #c1c1c1;
    border-bottom: 1px solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .output { border: hidden; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .output {
    background-color: #fafbfe;
    border: 1px solid #c1c1c1;
    border-collapse: separate;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .pageno {
    background-color: #fafbfe;
    border-spacing: 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
    text-align: right;
    vertical-align: top;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .pages {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: decimal;
    margin-left: 8px;
    margin-right: 8px;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .pagesdate {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .pagesitem {
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    list-style-type: none;
    margin-left: 6pt;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .pagesproclabel, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .pagesprocname {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .pagestitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .paragraph {
    background-color: #fafbfe;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > colgroup > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > colgroup, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > * > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > thead, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > tbody, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip > tfoot { border: none; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .parskip {
    border: none;
    border-spacing: 0;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
    }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .prepage {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    text-align: left;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .proctitle {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .proctitlefixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowfooter {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowfooteremphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowfooteremphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowfooterempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowfooterfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowfooterstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowfooterstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowheader {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowheaderemphasis {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowheaderemphasisfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: italic;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowheaderempty {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowheaderfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowheaderstrong {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .rowheaderstrongfixed {
    background-color: #edf2f9;
    border-color: #b0b7bb;
    border-style: solid;
    border-width: 0 1px 1px 0;
    color: #112277;
    font-family: 'Courier New', Courier, monospace;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter10, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter2, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter3, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter4, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter5, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter6, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter7, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter8, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemfooter9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle10, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle2, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle3, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle4, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle5, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle6, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle7, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle8, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systemtitle9 {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > colgroup > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > colgroup, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > * > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > thead, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > tbody, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer > tfoot { border: none; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .systitleandfootercontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .table > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .table > colgroup > col {
    border-left: 1px solid #c1c1c1;
    border-right: 0 solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .table > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .table > * > tr {
    border-top: 1px solid #c1c1c1;
    border-bottom: 0 solid #c1c1c1;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .table { border: hidden; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .table {
    border-color: #c1c1c1;
    border-style: solid;
    border-width: 1px 0 0 1px;
    border-collapse: collapse;
    border-spacing: 0;
    }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > colgroup > col, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > colgroup, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > * > tr, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > thead, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > tbody, .ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer > tfoot { border: none; }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titleandnotecontainer {
    background-color: #fafbfe;
    border: none;
    border-spacing: 1px;
    color: #000000;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
    width: 100%;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .titlesandfooters {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .usertext {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 a:visited { color: #800080 }
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .warnbanner {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: bold;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .warncontent {
    background-color: #fafbfe;
    color: #112277;
    font-family: Arial, 'Albany AMT', Helvetica, Helv;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
.ods_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3 .warncontentfixed {
    background-color: #fafbfe;
    color: #112277;
    font-family: 'Courier New', Courier;
    font-size: x-small;
    font-style: normal;
    font-weight: normal;
}
/*]]>*/
</style>
</head>
<body class="body">
<div id="div_44d3e6ed-166a-4b4a-b3a7-58068d9f42b3" class="c body">
<h1 class="body toc">Risultati: es0_lt_km.sas</h1>
<section data-name="Lifetest" data-sec-type="proc">
<div id="IDX" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">“analisi LT durata episodi”</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">La procedura LIFETEST</p>
</div>
<h1 class="contentprocname toc">La procedura Lifetest</h1>
<section>
<h1 class="contentfolder toc">Strato 1</h1>
<article aria-label="Stime delle tabelle di vita">
<h1 class="contentitem toc">Stime delle tabelle di vita</h1>
<table class="table" style="border-spacing: 0" aria-label="Stime delle tabelle di vita">
<caption aria-label="Stime delle tabelle di vita"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/><col/><col/><col/><col/><col/><col/><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="16" scope="colgroup">Stime di sopravvivenza della tabella di vita</th>
</tr>
<tr>
<th class="c b header" colspan="2" scope="colgroup">Intervallo</th>
<th class="r b header" rowspan="2" scope="col">Numero<br/>insuccessi</th>
<th class="r b header" rowspan="2" scope="col">Numero<br/>con censura</th>
<th class="r b header" rowspan="2" scope="col">Dimensione<br/>campionaria<br/>effettiva</th>
<th class="r b header" rowspan="2" scope="col">Probabilità condizionata di insuccesso</th>
<th class="r b header" rowspan="2" scope="col">Errore<br/>standard<br/>probabilità<br/>condizionata</th>
<th class="r b header" rowspan="2" scope="col">Sopravvivenza</th>
<th class="r b header" rowspan="2" scope="col">Insuccesso</th>
<th class="c b header" rowspan="2" scope="col">Errore<br/>standard<br/>sopravvivenza</th>
<th class="c b header" rowspan="2" scope="col">Durata vita<br/>residua<br/>mediana</th>
<th class="c b header" rowspan="2" scope="col">Errore<br/>standard<br/>mediana</th>
<th class="c b header" colspan="4" scope="colgroup">Valutato al punto medio dell&apos;intervallo</th>
</tr>
<tr>
<th class="r b header" scope="col">[Inferiore,</th>
<th class="r b header" scope="col">Superiore)</th>
<th class="c b header" scope="col">PDF</th>
<th class="c b header" scope="col">Errore<br/>standard<br/>PDF</th>
<th class="c b header" scope="col">Rischio</th>
<th class="c b header" scope="col">Errore<br/>standard<br/>rischio</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">0</th>
<th class="r rowheader" scope="row">1</th>
<td class="r data">5</td>
<td class="r data">1</td>
<td class="r data">14.5</td>
<td class="r data">0.3448</td>
<td class="r data">0.1248</td>
<td class="r data">1.0000</td>
<td class="r data">0</td>
<td class="r data">0</td>
<td class="r data">2.0056</td>
<td class="r data">0.7207</td>
<td class="r data">0.3448</td>
<td class="r data">0.1248</td>
<td class="r data">0.416667</td>
<td class="r data">0.18225</td>
</tr>
<tr>
<th class="r rowheader" scope="row">1</th>
<th class="r rowheader" scope="row">2</th>
<td class="r data">2</td>
<td class="r data">1</td>
<td class="r data">8.5</td>
<td class="r data">0.2353</td>
<td class="r data">0.1455</td>
<td class="r data">0.6552</td>
<td class="r data">0.3448</td>
<td class="r data">0.1248</td>
<td class="r data">1.9519</td>
<td class="r data">0.6167</td>
<td class="r data">0.1542</td>
<td class="r data">0.0997</td>
<td class="r data">0.266667</td>
<td class="r data">0.186878</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2</th>
<th class="r rowheader" scope="row">3</th>
<td class="r data">2</td>
<td class="r data">1</td>
<td class="r data">5.5</td>
<td class="r data">0.3636</td>
<td class="r data">0.2051</td>
<td class="r data">0.5010</td>
<td class="r data">0.4990</td>
<td class="r data">0.1349</td>
<td class="r data">1.2679</td>
<td class="r data">0.4188</td>
<td class="r data">0.1822</td>
<td class="r data">0.1139</td>
<td class="r data">0.444444</td>
<td class="r data">0.306412</td>
</tr>
<tr>
<th class="r rowheader" scope="row">3</th>
<th class="r rowheader" scope="row">4</th>
<td class="r data">2</td>
<td class="r data">1</td>
<td class="r data">2.5</td>
<td class="r data">0.8000</td>
<td class="r data">0.2530</td>
<td class="r data">0.3188</td>
<td class="r data">0.6812</td>
<td class="r data">0.1339</td>
<td class="r data">0.6250</td>
<td class="r data">0.3953</td>
<td class="r data">0.2551</td>
<td class="r data">0.1341</td>
<td class="r data">1.333333</td>
<td class="r data">0.702728</td>
</tr>
<tr>
<th class="r rowheader" scope="row">4</th>
<th class="r rowheader" scope="row">.</th>
<td class="r data">0</td>
<td class="r data">0</td>
<td class="r data">0.0</td>
<td class="r data">0</td>
<td class="r data">0</td>
<td class="r data">0.0638</td>
<td class="r data">0.9362</td>
<td class="r data">0.0850</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
</tr>
</tbody>
</table>
</article>
<article id="IDX1" aria-label="Curva di sopravvivenza delle tabelle di vita">
<h1 class="contentitem toc">Curva di sopravvivenza delle tabelle di vita</h1>
<div class="c">
<img style="height: 480px; width: 640px" alt="Curva di sopravvivenza della tabella di vita" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAIAAAC6s0uzAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAgAElEQVR4nO3de1xM+f8H8E/NNE1Nk1mlUiGXLii60Bahck0XkqKwYe0mosK6pZV126xb3yjtl6/7Jco1Qu5yLV1o1W+EMC7bxaZSNpN+f8w+RptbjalPM/N6Pvbxe5yZM3PmFV+/V+fMOeetlJ2dTQAAAKB5MQkhPXr0oB0DAABAgdy+fVuZdgYAAABFhAIGAACgAAUMAABAAQoYAACAAhQwAAAABShgAAAAClDAAAAAFKCAAQAAKEABAwAAUIACBgAAoAAFDAAAQAEKGAAAgAIUMMBHsNlsJSWl/Pz8es+/e/fu22+/7dSpU0lJCSGkrKzM29u7VatWSkpKUVFRDdny6NGjlT7GzMzsM+/i8XhKSkovXrxo1Cqx169fr1692srK6ptvvuFwODY2NqtWraqoqGhI4Iao98fSWJ/5Ed69e7d58+Y+ffpoamqqq6tbWVktX768tLT0qyMD0MekHQBAxtTU1BBCamtrCSFr1qxJSEgQPW9paUkz1qe9e/duyJAhV69eFT+TkZGRkZGxadOm3NxcVVVVqXxK3T8WaREKhaNGjTp27Jj4maysrKysrI0bN+bk5LRu3VqKnwXQ/LAHDNAIysrK6enpDx480NbWJoTk5eURQhYvXlxbWztgwICGbCEhIaG2tra2tnbp0qWEEH9/f9FD0aaaQlpa2tWrV5lM5r59+8rKyv76668bN26EhITY2tpKq33r/bFIy7Jly44dO6aiorJ27dri4uJXr16lp6cvXLiwe/fuaF+QAyhggMYRHy/l8Xj79+8nhCxZsoTH4xFCqqqqQkND27Zty2azHRwcMjIyGrvxixcvent7t2nThsvl9u3b98aNG3XXpqamWlpaijZ+586dD9/+0QBMJpMQwmKx2rZty+VyeTyera3tunXr9u3bJ3oXk8lUUlISH5HW1tYWHxAW/bCXL1/u3LmzhYWFh4eHkpLSwoULRa8sKSlhsVgqKipFRUXiP5bPvObzP109b9++Xb9+PSEkIiIiNDRUS0tLU1PTxsZm+fLlKSkpUkz+9X9rABLKzs6uBYB/E+0a3rt378NVrVq1IoQ8f/5ctCDSqlWr2tpad3f3uv+4eDxeSUnJpz6i3h5wbW1tTU1N3W0SQnR0dMrKysQfqqKiIl5lYGDw+vXrunk+FaCmpsbOzk70TNu2bf38/LZt21Y3GIPBIISUl5eLHmppaYk3KNq46O3jx48X/cLRqVMn0Ss3bNhACHFzc6sb41Ov+eJPJ/pEsbS0NEKIkpKSONiHpJK8UX9rANKSnZ2NPWAACZWWlnp5eRFCdu7cWVpampWVdezYMW1t7bS0tMrKyqVLl5aWljbwzCwRZWVlLy+vmJiYly9fPnv2zMTEpLCwMDs7W/yCKVOmvHjx4tatW23atHn69OmePXvqvv1TAZSVlVNSUsLCwjp27Pj8+fM9e/ZMnDixXbt2ov3Lhnj8+PH//d//7dy508PDo1WrVg8ePEhPTyeE7Nq1ixAyYcKEui/+1Gu++NPVIzqfS1tbW0NDo4E5JUj+9X9rABJDAQNIh+jQZXFxce/evdXV1cPDwwkht27dWrRokfhU50WLFn1+I4sXL87NzXV0dOzatSufzxdtULz2559/1tXVtba2Hj9+PCHk7t27DQlACNHQ0Fi2bNmDBw/u37//+++/Dx06tLKyMjQ09MqVKw350SIjI01MTAghqqqq3t7ehJD4+Pj79+9fv35dU1PTw8Oj7os/85rP/3T1fPPNN6IXlJeXNySkZMk/84cG0NRQwADSoaz8kX9NAoGg4Vv4888/bWxsoqOjb9++/erVq8+8UnTKsZqaWmMDdOrU6Ycffjh58uSgQYMIIXVPjRYKhZ/6ONGLRUT7u/v379+5cychxNvbm81m13v9R1/T8J9OpGfPnhwOp7a29rfffvv8K78m+df/rQFIDAUMIB2irxtbt26dnJxcVVVVUFCwdu3akSNHLlu2TPytz7Jlyz6zhdOnTxcXFw8bNiwjI2PNmjUfFtvq1auLiooyMjJ2795NCDE3N29IgNzcXHNz88jIyIyMjFevXpWXlyckJNy8eZMQYmhoSAjhcDiEkKNHjxYXFy9atOjz1/L269fPyMjo8ePHa9euJR8cf/7Ma77409Wjqqo6bdo0Qsjy5csXLlz46NGj8vLy7OzsyMhIa2vrN2/eSCX5p/7QPp8NQDpwEhbAhz56fY7ohKm6ZwyJvwMWvWvKlCn13jJgwIBPfcSHJ2GdO3fuww+Nj48Xf6jonCORTp06VVdX18vz0QAJCQl1z94S69u3799//11bWzts2DDxkyoqKqIX1z2Vqd7pUWFhYaIXt2/f/t27d6In673yw9d88aer9ym1tbVv3rypuwsrxuFw7ty5I63kjfpbA5AWnIQFIE1xcXFr1qzp2rUri8UyMDDw8vJq1Ok8Tk5OISEhrVq16tChQ1hYmOiLXtF3pSL/+9//TE1NWSxWv379kpKSPqzVjwbw8vLKzc2dPXu2ubm5mpoaj8fr1avXhg0bzp49y2KxCCExMTHOzs5qamqmpqYHDx7U1NT8fE7xXu+4ceOUlJQa+Jov/nQfUlVVTU5O3rBhg62tLYfDYbPZpqamoaGhd+/eFe39SyX5V/6tAUhMKTs7u0ePHrRjAAAAKJDbt29jDxgAAIACFDAAAAAFKGAAAAAKUMAAAAAUoIABAAAoQAEDAABQgAIGAACgAAUMAABAAZN2AKnZfeCgeC43AAAARfp6uu4uQz//Gvkp4IqKioBJ39FOAQAAQOK27vjia3AIGgAAgALKBVxWVnbq1CkjI6OEhIQP16amppqZmbHZbA8Pj4YMEAUAAJAVlAt40KBB4eHhH52JXV1d7e3tHRwcLBAIVFVVFyxY0NiNX79TGLk9K2pvTv6TMmmEBQAAkBrKBXzz5s2bN2+amJh8uOrq1assFiswMFBbWzssLOyju8ifER6bPnj68fwnZalZL6zGJe5OzpdSZAAAAClouSdh5efni0Z+EkJMTU2LiorKysq+OO9T5MKtZxv25zw86qvNYxNCUrNeuMxMHmpvKHoIAABAXcst4KqqKi6XK1pWU1NjMpmVlZXiAs7j3yv5q1T8YpbKv36QszefjXcx1uaxhTXv8gpKHSz1zDt/cyX7xYgBRs0VHwAA4HNabgFzOJzy8nLRslAoFAqFHA5HvFZNTa2VUCh+yGT+6wdhqzJKn1cTQvIKSgdPO7FrqVNpeTWTgVO+AQCgpWi5BWxsbJyTkyNa5vP5urq64h1iQkiHdob1Xn/xyjXx8lA7w1+3ZeXcf2neufWByEHDgk4oM5QGWLdthtgAAAAN0XJ3Cu3s7IRCYWxsbElJSUREhKenZ8Pf26tbm/Wz7XtPODR42vHAlaksFQabxThy8VHTpQUAAGiUlrgHbG1tvWXLFisrq/j4+ClTpoSGhjo7O8fFxTVqI9+PMBvY2+BGTiFblTHAWv9FSaVTQFJx6ZtgX/Mmig0AANBwLaKAT548WfdhRkaGaMHBwSEvL0/izRrpc430/zlqzeOyMveMcgpIqqh6GzbZSuJtAgAASEXLPQQtdXpa6ufj3HaduBe69tqXXw0AANCUFKiACSF6WuppOzzT7xYFrkwV1ryjHQcAABSXYhUwIURDXSX5Py55BaW+C8+hgwEAgBaFK2BCiIa6SkrMcEKI55zTFZVvaccBAABFpIgFTAhhMpT3rnDWUFNxmZmMDgYAgOanoAVM/unggb26tRk8/fiLkkracQAAQLEobgGLrJtl72ij7xSQhA4GAIDmpOgFTAhZGWQ71atbvylH8wpKv/xqAAAAaUABE0JIsK95iK/F4GnH0cEAANA8UMD/mO7Tff2cPk4BSalZL2hnAQAA+dcibkXZQng5d2QylLznnTkQOcjBUo92HAAAkGfYA/6XEQOMDkQO8p53JvHcQ9pZAABAnmEPuD4HS70DkYN8F54lhHg5d6QdBwAA5BP2gD/CwVIvJcY1ZPXVqL05tLMAAIB8QgF/nJkRLyXGdVPiXXQwAAA0BRTwJ5kZ8c7HuW1KvPtT1HXaWQAAQN6ggD9HNEL4+p1CjBAGAADpQgF/gZ6WevJ/XNLvFnnPO4PxhQAAIC0o4C8TjRAW1rzDCGEAAJAWFHCDaKirHIgcRAhxCkjC+EIAAPh6KOCGEo0QtjTRcpmZXFpeTTsOAADINhRwIzAZytFz+/bq1sZ+0mGMLwQAgK+BAm60dbPsJ7qbOAUkCQpf084CAACyCgUsiXn+llO9uvWecAjjCwEAQDIoYAkF+5qvn20/eNrxLH4J7SwAACB7MIxBcmOGdGYylZ0Cjh1bNwzjCwEAoFGwB/xVvJw7Hlo9xHvembM3n9LOAgAAsgQF/LUcbfQPRA4aPS8FI4QBAKDhcAhaChws9a5tHTl42vGKyrf+bia04wAAgAxAAUuHaHyhU0BSaXl1sK857TgAANDS4RC01JgZ8TL3jNqUeHfJ77doZwEAgJYOBSxNovGFCWcfYnwhAAB8HgpYyvS01K9tHZF+t+iHZZcwOgkAAD4FBSx9ovGF+U/KML4QAAA+BQXcJDTUVVJihhNC3ENPYXwhAAB8CAXcVETjC7V5bJeZyehgAACoBwXchJgM5Z2/OPXq1sZpahLGFwIAQF0o4Ca3bpb9MPt2TgHoYAAAeA8F3ByWBvaa6tXNftIRjC8EAAARFHAzCfY1nz/RcvC04+hgAAAgKODmFDCq6/o5fZwCklKzXtDOAgAAlKGAm5WXc8fN4f29551BBwMAKDgUcHNzdWh/IHKQ55zTGF8IAKDIMA2JAgdLvWPrhnnPSyGEeDl3pB0HAAAowB4wHXYWOikxriGrr0btzaGdBQAAKEABU2NmxDsf574p8S46GABAAaGAaerSTvN8nNumxLsYXwgAoGhQwJSJRgin3y1CBwMAKBQUMH16WurJ/3FJv1vkPe8MxhcCACgIFHCLIBohTAjxXXjuTXUN7TgAANDkUMAthYa6yt4VzoSQwdOOY3whAIDcQwG3IKIRwpYmWi4zk4tL39COAwAATQgF3LIwGcrRc/v26tam35SjGF8IACDHUMAt0bpZ9lNGmjkFJBU8K6edBQAAmgQKuIWaPb4HRggDAMgxFHDLFexrvmFe38HTjqffLaKdBQAApAzDGFo00aiGwdOPH1s3zMFSj3YcAACQGuwBt3Rezh2PrRvmPe/MqWsC2lkAAEBqUMAywMFS70DkoPHh5zBCGABAbqCAZYODpd7lzR4hq69uOZJHOwsAAEgBvgOWGWZGvJQY18HTjldUCoN9zWnHAQCAr4I9YFliZsRL2+m5KfHukt9v0c4CAABfBQUsY0TjCw9fKMD4QgAAmYYClj16WuqXN3uk3y2atOQCxhcCAMgoygWcmppqZmbGZrM9PDxevXpVb+2FCxe6d+/O5XK9vLxKS3FDqPdE4wsFf772XXgOHQwAIItoFnB1dbW3t3dwcLBAIFBVVV2wYEHdtUKh0MfH5+eff3727Jmqqmp4eDitnC2ThrpKcrQLIcQ99BTGFwIAyByaBXz16lUWixUYGKitrR0WFpaQkFB37dOnT1+9ejVmzBgulzt27Nhbt3DaUX2i8YV6WmouM5PRwQAAsoVmAefn55ub/3M5jampaVFRUVlZmXitgYGBrq7utm3bysvLd+/ebW9vTylmi8ZkKG9d7IjxhQAAMofmdcBVVVVcLle0rKamxmQyKysrNTU1Rc8wmcyVK1dOmDBh0qRJ+vr6N27cqPvePwuLXle+7xsGg9FssVugdbPsw2PTnQKSzse56Wmp044DAABfRrOAORxOefk/826FQqFQKORwOOK1GRkZc+fOvXz5sqWl5caNG11cXLKyssRF+/zPP4uKS8QvZrFUmjN5C7Q0sJc2j20/6Ujyf1zMjHi04wAAwBfQLGBjY+OcnBzRMp/P19XVFe8QE0LOnTs3aNCgvn37EkJ++umnn3/++fnz54aGhqK1lhb1bwWVx89vltQtV7CvuYY6c/C04ykxruhgAIAWjuZ3wHZ2dkKhMDY2tqSkJCIiwtPTs+5ae3v7U6dOpaenV1ZWrlu3Tk9Pz8DAgFZUWfH9CLP1c/r0m3I0NesF7SwAAPA5NAtYRUUlPj4+KirKwMCgoqJixYoVouetra0zMzP79u27YsWKsWPHtmnT5siRI8eOHVNSUqKYVlZ4OXfcFuHoPe8MOhgAoCWjPIzBwcEhL6/+eJ+MjAzRwuTJkydPntzsoWSeq0P7A5GD3ENPbg4f4OXckXYcAAD4CExDkk8OlnopG10955wmhKCDAQBaINwLWm716tYmJcY1KPJK1N4c2lkAAKA+FLA8MzPiXds6YlPi3TW7btPOAgAA/4IClnNG+tzzcW6bD+dhfCEAQIuCApZ/4vGFoWuvYXQSAEALgQJWCNo8dvJ/XNLvFmF8IQBAC4ECVhQa6iopMa6EEN+F5zA6CQCAOhSwAmGzGHtXOBNCML4QAIA6FLBiEY0Q7tWtjcvM5OLSN7TjAAAoLhSwwmEylNfNsscIYQAAulDACmrdLPupXt2cApLyn5TRzgIAoIhQwIor2Nd8qle3flOO5hWU0s4CAKBwUMAKLdjXfMO8voOnHU+/W0Q7CwCAYsEwBkUnGtXgMjP50OohDpZ6tOMAACgK7AED8XLueGj1EO95Z46nPqadBQBAUaCAgRBCHCz1DkQOmhhxIfHcQ9pZAAAUAgoY/uFgqXd5s0fI6qtbjuTRzgIAIP9QwPCemREvJcZ12ZZMjBAGAGhqKGD4F/EI4fDYdNpZAADkGQoY6tPTUj8f55Z0+RFGCAMANB0UMHyEeITwhJ/PY3whAEBTQAHDx2moqyT/x6W49A1GCAMANAUUMHyShrrKsXVDCSEuMzC+EABAylDA8Dmi8YVG+lyMEAYAkC4UMHwBk6H830X9e3VrYz/pCMYXAgBIi4T3gn7+/Dmfz3/79i0hRCgU5ubmhoaGSjUYtCzrZtkv+f2WU0DS+Tg3PS112nEAAGSeJAUcFxc3Y8YMfX39R48emZqa3rt3z9nZGQUs9xb/aMPjqvaecCglxtXMiEc7DgCAbJOkgJcvX56UlDRkyBB1dfXs7OxffvlFX19f6smgBQr2NedxWYOnHUcHAwB8JUm+Ay4sLOzfvz8hREtL6+XLlwEBATExMdIOBi2Uv5vJ+jl97CcdTs16QTsLAIAMk6SAra2tL126RAgxNjZOT0/ncDgFBQVSzgUtmJdzx30rBnnPO4MOBgCQmCQFvHDhwqioKEKIv7//1KlTvby8+vTpI+1g0KINtTc8EDnIPfQkxhcCAEhGku+A3dzc3NzcCCH+/v6tW7d+9OjR+PHjpR0MWjoHS73zce7uISeFwndjhnSmHQcAQMZIeBmSmLu7OyHkwoULjo6OUogDMsXSRCslxtUpIOlFSVWwrzntOAAAskSSQ9CGhoYHDx6s+4yTk5OU8oCMEY8vXLPrNu0sAACyRJICfvr06U8//TRr1iyhUCj1QCBzjPS55+PcNh/Ow/hCAICGk/BWlLdu3bp3796AAQOePn0q3UAgi/S01K9tHZl+t2jGqisYnQQA0BASFjCPxzt69Ojw4cN79ep15swZ6WYCWcTjspL/45LFL8H4QgCAhpB8GIOSklJYWNiuXbsmTJggxUAguzTUVVJiXAkh3vPOYHQSAMDnSVLAixcvFi8PHDgwLS1txowZ0osEMozNYuxd4cxkKGN8IQDA50lyGVJERMSNGzf4fH5NTY3oGWtra6mmAhnGZCgfiBwUuvaay8zkA5GDMDoJAOCjJCng2bNnx8bG2tjYqKqqip+cOHGi1EKB7Fs3yz507TWMLwQA+BRJCnjz5s2XL1+2sbGRehqQJ+tm2Ru15ToFJB1aPQSjkwAA6pHkO2A9Pb22bdtKPQrIn2Bf86le3QZPO55XUEo7CwBAyyJJAYeHhy9fvlzqUUAuBfuar5/TZ/C049fvFNLOAgDQgkhyCHrixIk1NTVxcXF1n8RdseBTvJw7EkI855w+EDnIwVKPdhwAgBZBkgLOz8+Xeg6Qb17OHXVbq3nPO7NpoUNPY60jFx+Vlv/tYKk30NaAdjQAADokOQRtZGTUqlWrlJSUTZs2GRkZ7dix49073PkIvsDBUu9A5KBJERe7eu8/c1NQXPpm9LyUH5Zdop0LAIAOSQr4xo0bXbp0OXDgQGRkJCGEzWYvWbJE2sFADlmaaBFCNNRU3Pp1iJ7b9/mpCUmXHx+5WEA7FwAABZIUcGBgYGxs7OnTp0UPx44di9tBQ0Nk8Ut0tdQub/ZYvTN7wYabpeV/T/XqeuYG5nkAgCKSpIDz8/OHDx8uftiqVau///5bepFAbrFZjNLy6i7tNC9v9igtr+46ev++lPtFpW9o5wIAoECSAraysoqOjhY//N///mdvby+9SCC3zLu0Zqsy4hJz9bTUYxc4XPzd49Gz8itZL3p/d2h7Ev9NdQ3tgAAAzUeSs6A3bNgwZMiQ7du3E0IcHBwEAkFKSoq0g4EcYrMYe5cP9J6XsmH/H0b63DM3nv46w3b2+B7HUx9vSrw7Z/31ie4m0727G+lzaScFAGhykhSwhYXFvXv3Tpw4IRAIOnTo4OLioq6Om/1Cg9hZ6OQm+FzMeF5R+TZ2voOoa10d2rs6tC94Vr7xwB+9vztkZ6ET5GM+1N6QdlgAgCYkSQHfuHHj22+/9fHxkXoaUAQa6iquDu0/fN5In/tbsN3SwN67k+8tik0LWXN1qlc3fzcTHpfV/CEBAJqaJN8Bjxw5slu3bqtWrXr+/LnUA4GCY7MY348wS9vhuXWx4/U7f3b02BO4MjXn/kvauQAApEySAn7y5Mlvv/2Wnp5ubGzs6uqakJBQXV0t9WSg4OwsdPauGJib4GOoy3GZkdxvytH40/eFNbjlCwDICUkKmMlkurq67t+//8mTJ8OHD//xxx/19fWlngyAEKKnpR422erhMd8QP4vNh/PaDd+z5PdbL0oqaecCAPhaknwHLJKbm7t9+/adO3e2a9du4sSJ0osEUB+Toezl3NHLuWPO/ZdxibldR+8fZt9uuk93jHYAANklyR7wxo0bbW1t+/XrV1lZeezYsezs7NDQUKknA/iQeefW0XP7Pjzq52Cp98OySxZjEuIO5uICYgCQRZLsAScnJ8+bN8/d3Z3FwumpQAGPy5ru0326T/ezN59u2P/Hopi08cONp3t379JOk3Y0AICGalwBV1dXs1ispKSkJkoD0CgDbQ0G2hoICl9v3P+H/aTDvbq1CfLpPtTekMmQ5NAOAEBzatz/n7KysiKEKH1M08QD+DJDHc7KINsnJ8aNdzFetiXD2DN+za7bxbjFNAC0bI3bAz5//jwh5MmTJ00TBkBybBZjnEuXcS5d0u8WbTzwh7HnvtEDOwWM6tqrWxva0QAAPqJxBayjo0MIefr06bfffts0eQC+Vq9ubbYudvwt+M32JL73/DN6WmpBPuZeAzuyWQza0QAA3qN8J6zU1FQzMzM2m+3h4fHq1at6a0tKSry8vDgcTo8ePS5evPiVnwUKRZvHnj2+x71DYxZ9b70r+V5H970LNtwUFL6mnQsA4B8074RVXV3t7e0dHBwsEAhUVVUXLFhQ7wXjx483NDR8/PhxdHR0cnKyBB8BCo7JUHZ1aJ/8H5fzcW5vqmus/BI955w+e/Mp7VwAAEQpOzu7R48ekr35r7/+2rNnT3h4uLKycnFxcWPffuHCBX9//0ePHhFCsrKyhgwZUlhYKF5bUFDQu3fvp0+fNvBip7itOwImfdfYDKBQ3lTXbE/ib4j/Q1jzLsinu7+biYa6Cu1QACCHvlhJt2/flvxqjdzc3MjIyBUrVrRr1y4sLEyCLeTn55ubm4uWTU1Ni4qKysrKxGszMzM7derk7++vrq5ua2t7584diaMCiLBZjIBRXe/Ej/7vov4Xbj1v57p7xqormPQAAFTQvBNWVVUVl/vP6HU1NTUmk1lZ+f4ev6Wlpenp6c7OzoWFhT4+PqNGjaqpeX/Do+rq6qqqN+L/3rzBNSfQCA6WegciB+Um+Gjz2IOnnRg87XjiuYeY9AAAzYnmnbA4HE55ebloWSgUCoVCDocjXquurt67d+8ffviBEDJ79uyVK1fev3/fxMREtPbKjbQnT99/k6fGZn9NElBMelrqi3+0CfveKvHsw/V77oSsvho0pru/m4meljrtaAAg/yQp4PDwcKlchmRsbJyTkyNa5vP5urq64h1iQoipqen9+/eFQiGTyRTd6ENF5f3XdU79+tbbWtzWHV8fCRQQk6E8ZkjnMUM6Z/FLxJMegn0t7Cx0aEcDAHlG8zIkOzs7oVAYGxtbUlISERHh6elZd23Pnj11dHSWLFlSVla2ceNGPT29Dh06fM3HAXyepYlW7AKHh0f97Cx0J/x8rvd3h7YcycOkBwBoIjQvQ1JRUYmPj4+KijIwMKioqFixYoXoeWtr68zMTCUlpQMHDpw+fVpXV3fnzp379+9XVsYNfqHJ8bisYF/ze4fGLgvsffhCQbvhu3+Kul7wrJx2LgCQNzQvQ5IuXIYETaHgWfnGA39sO8a3s9AJ8jEfam9IOxEAyICWfhkSQMtnpM/9LdjuyYlxIx2NFsWmGXvuW7Prdmm5JId8AADqonkZEoCsYLMY348wS9vhufMX5yx+SUePPYErU7P4JbRzAYAMo3kZEoDMsbPQsbPQeVFSuT2J7x5y0kifG+TT3WtgR0wgBoDGkqSAk5KSnj9/fu3atbdv3xJChEJhbm4udoJBcehpqc/zt5w9vseRi482JdwNWXNtykiz6T7dcAExADScJL+2x8XFdejQwd/ff/DgwUFBQa6uridOnJB6MoAWjslQ9nLumBLjej7OrbT8766j93vPO5Oa9YJ2LgCQDZIU8PLly5OSkgoKCtTU1LKzs+fPn2STikYAACAASURBVD9y5EipJwOQFWZGvOi5fZ8cH+do0/aHZZcsxiTEHcytqHxLOxcAtGiSFHBhYWH//v0JIVpaWi9fvgwICIiJiZF2MAAZo6GuMt2ne26Cz/rZ9mduPO3osTd07bW8glLauQCghZKkgK2trS9dukQIMTY2Tk9P53A4BQUFUs4FILMG2hociByUuceLzWI4BSS5zEw+crEAkx4AoB5JCnjhwoVRUVGEEH9//6lTp3p5efXp00fawQBkm6EOZ2WQ7cNjvhPdTH7dlmXsGR+5Pau4FGO7AOAfkpwFraKicvz4cUKIv79/69atHz16NH78eGkHA5AHbBZDNOkh/W5R3MFcY899Ix2Npnt379WtDe1oAECZJAXs7e0tEAg0NTUJIe7u7tKOBCCHenVr06tbm5VBttuT+N7zz2jz2CG+Fl4DO7JZDNrRAIAOSQ5BJyQkzJgx4/r161JPAyDftHns2eN7PDzqG/Gjza7ke+2G716w4aag8DXtXABAgSR7wH5+frW1tTt27GAw3v/yLhQKpZcKQM65OrR3dWif/6Rs44E/rPwSHSz1pnp1w6QHAIUiSQGnp6dLPQeAAurSTnPdLHvRcen50TdC1lwN8uk+zsWYx8VNXgHknyQFbGRklJqaum/fvsLCwvbt20+YMKFnz55STwagINgsRsCorgGjuqZmvdi4/49FsWnjXYwDvLqad25NOxoANCFJvgOOjY11dXWtra21sbGpqKjo16/f9u3bpZ4MQNE4WOrtXTEwN8FHm8cePO2EU0BS4rmHuIAYQF5Jsge8fPnyo0ePDhgwQPTQx8dn8uTJ/v7+Ug0GoKD0tNQX/2gT9r3VkYuP1u+5E7L66tTR3b4fYYpJDwByRpI9YGVl5e7du4sfWlpaisYiAYC0iCY9XN7skRztIvjzddfR+30Xnr1+p5B2LgCQGkkKeOvWrdOnTy8qKiKEFBcXh4SEbNmyRdrBAIAQQsw7t45d4PDwqJ+dhe6kJRes/BK3HMl7U11DOxcAfC1JDkEPHTr03bt3CQkJSkpKtbW1tbW1e/bsEa/F9UgAUsfjsoJ9zYN9zU9dE2zYnzM/+uZEd5OAUd26tNOkHQ0AJCRJAefn50s9BwA0xFB7w6H2hgXPyuMO5tpPOmxnoTPVq5urQ3vauQCg0SS8DCkzM3Pbtm1Pnjxp167d5MmTcRkSQHMy0ueuDLJd/KNN/On7Eb/fCllzdapXt+9HmOECYgAZIsl3wAcPHhwwYEB1dXWfPn1ev37dp0+fI0eOSD0ZAHwem8XwdzNJ2+G58xfnLH5JR489Pyy7lMUvoZ0LABpEkj3g8PDwhISEIUOGiB66u7uHhYWNGDFCqsEAoKHsLHTsLHSKS99sOZLnHnLSUJcjmvTAZEjyGzYANA9J/n0+fvzY3t5e/NDR0fHRo0fSiwQAktDmsef5Wz485jt/ouXmw3nthu8Jj03HpAeAFkuSAra0tKx766uNGzdaWVlJLxIASI7JUB4xwCglxvV8nFtp+d9Wfone885cuPWMdi4AqE+SQ9DR0dFDhw7dvHmzkZERn89/+fLlqVOnpJ4MAL6GmREvem5f0aSHGauuEkKmenX1dzPRUFehHQ0ACJGsgC0tLfPz80+cOCEQCHx9fYcPH87lcqWeDAC+noa6ynSf7tN9ul+49Wzj/rsRv98aO6TzdJ/uZkY82tEAFJ0kBUwI4XK5Y8aMkW4UAGg6jjb6jjb6gsLXcYm5TgFJlqZaU726ujq0r3uiVl5B6X1BmWkHHu7vAdAMJPkO+MGDB+vWrSOE3L5929zc3MrKKiMjQ9rBAED6DHU4SwN7PTzmO9HN5NdtWR3d90ZuzyoufVNR+dZ73hkrv8Rft2V1Hb1/0pILmMIE0NQk2QMOCQkRXYM0e/Zsf39/NTW1oKCgq1evSjsbADQJNosxZkjnMUM6Z/FLNu7/w9hzn562eptW7Ccnxmnz2C9KKj3nnI7cnh02GSdXAjQhSfaAU1JSJkyYUFJSkp2dPWvWrClTpmRnZ0s9GQA0NUsTrf8u6v/wqN+TFxX5gnKXmcm7k/O1eez5Ey0TzjygnQ5AzkmyB9y6deuSkpJLly4NHTqUwWDw+Xx9fX2pJwOA5sHjspSUlG7uGJnNL1m983bE7+njhhkXl76hnQtAzklSwFOnTu3fv39VVdXRo0cJIUuXLvXz85N2MABoPg6WenGJuUsDe7k6tL9w65lf2LmKqrfbk/jjXLrgdloATUTCW1EOHDiwVatW3bt3J4TMmTOna9eu0g4GAM0n+qe+TgHHUrNeuPVrn3D2gSqL8d9F/Tcfzlu2JSPIxzzAqyubxaCdEUDeSHgZUp8+fcTL1tbWUgoDAHR0aad5J957y5G8vILS8S7Govt1uDq0z+KXLPn91q/bsuZPtEQNA0iXhAUMAHKGx2XNHt+j3pOWJlqHVg9BDQM0BXy7AwBfIKrh5GiXC7eedXTfG7U35011De1QADIPBQwADYIaBpCuxhVwdXV1E+UAAJmAGgaQlsYVsGjsoNLHNE08AGiJUMMAX69xJ2GdP3+eEPLkyZOmCQMAsgSnaAF8jcYV8Llz5z61auzYsV8dBgBkj7iGI7dlrd6ZHeJn8f0IMx6XRTsXQEvXuALesGGDaOHu3bsGBgatWrUqLi4uKirq2rUrChhAkVmaaO1dMTD/Sdny/2UYe+4L8uke7GuBGgb4jMYVcGpqKiFk5cqVI0aM+OmnnwghtbW1CxYs4PEw3BsASJd2mlsXO6KGARpCksuQfv3118DAQNGykpJSWFjYihUrpJoKAGSYqIavbR1Z8Lzc2HPfkt9vlZbjAgqA+iQpYAMDgwMHDogf7tixw8jISGqJAEAuoIYBPk+SW1FGR0d7enpu3LixXbt2Dx48ePz48ZEjR6SeDADkAA5KA3yKJAU8cODABw8eJCcnFxYWjh071sXFRVNTU+rJAEBuoIYBPiThMAZtbe0JEyZINwoAyDfUMEBduBc0ADQr8XfDgsLXXUfvX/L7reLSN7RDAVCAAgYACrq00/zvov6Ze0aVVlQbe+4LXXvtRUkl7VAAzQoFDADU6Gmpr5tln5vgQwjpOno/ahgUioTfAT9//pzP5799+5YQIhQKc3NzQ0NDpRoMABSFqIbn+feM3J7ddfT+ie6m8/x76mmp084F0LQk2QOOi4vr0KGDv7//4MGDg4KCXF1dT5w4IfVkAKBQsDcMiqYRBfz69euIiAhCyPLly5OSkgoKCtTU1LKzs+fPnz9y5MimCggAigQ1DIqjEQXcpUuXkpISQkhhYWH//v0JIVpaWi9fvgwICIiJiWmqgACgeFDDoAgaUcC//PJLdHQ0IcTa2vrSpUuEEGNj4/T0dA6HU1BQ0ET5AEBhoYZBvjWigH/44QfRwsKFC6Oioggh/v7+U6dO9fLy6tOnT5OkAwCFhxoGeSXJSVhubm7Hjx8nhPj7+2/atGn06NF1ZzMAAEidqIYfHvXjabAsxiRMWnIh/0kZ7VAAX0WSAt61a5d42d3dPSgoaN26ddKLBADwcTwua/GPNvcOjTVqy7WfdBg1DDKtcQX84sWLFy9eTJgw4UUdV65cWbVqVRPlAwCoBzUM8qFxN+Jo27ZtvQVCCIfDmTNnjjRDAQB8iaiGg30tovbesZ902K1f+7DJ1l3aYTIbyIzG7QG/ffv27du3PXv2fFtHRUXF0qVLmygfAMBnYG8YZFfjCvjdu3dMJjMrK4tZRxMlAwBoINQwyKLGFbCVlRUhROljJPv41NRUMzMzNpvt4eHx6tWrj76Gz+erqamVlpZK9hEAoCBQwyBbGlfA58+fJ4Q8+RgJPru6utrb2zs4OFggEKiqqi5YsODD19TW1gYGBv79998SbB8AFBBqGGRF4wpYR0eHEGL4MRJ89tWrV1ksVmBgoLa2dlhYWEJCwoeviY2NtbW1VVbG2EQAaARxDVuaaDsFHPOedyaLX0I7FMC/NK7YPnrwWeJD0Pn5+ebm5qJlU1PToqKisrJ//aIqEAji4uLCw8Ml2DgAAI/LCvY1v3d4rIOlnsuMZM85p1HD0HI07hQqyQ41f0pVVRWXyxUtq6mpMZnMyspKTc33VxEEBgauXLlSXf0jY0EvX7v+9NkL8UM2W1WKwQBAnrBZjGBf8wCvrnGJuS4zku0sdBb/aGNpokU7Fyi6xhWwjo4Oi8WS1mdzOJzy8nLRslAoFAqFHA5HvHbv3r1sNnv48OEffa9Nz549uncTP1RSUtqbcEhawQBA/qCGoaWheRa0sbFxTk6OaJnP5+vq6op3iAkhiYmJCQkJoo3X1NR88803SUlJ4rXq6mqtNDXF/2nWeSMAwKeIavjhMV9HG30clAa6GrcHLD4LWiqfbWdnJxQKY2NjfXx8IiIiPD09666te04Wk8ksLi7m8XhS+VwAUHDYG4aWQMKzoAsKCn799ddZs2atX7++pKREsrOgVVRU4uPjo6KiDAwMKioqVqxYIXre2to6MzNTgg0CADQc9oaBLkku74mNjXV1da2trbWxsamoqOjXr9/27dsl+3gHB4e8vLw3b96cOHHim2++ET2ZkZEhOtYtJhQKsfsLAE0BNQy0SHIjyeXLlx89enTAgAGihz4+PpMnT/b395dqMACA5iM+KL3lcJ73vBTzzq2Dfc0dbfRp5wJ5JskecE1NTY8ePcQPrayscKcqAJADbBZjuk/33ASfkY5GPyy75BSQdOHWM9qhQG5JUsDr1q2bMWNGdXU1IaSioiIkJCQmJkbawQAA6GAylP3dTHITfCa6m6CGoek07hC0ePZRTU3Nvn37CCG1tbW1tbW7d+8WCoXSTwcAQImohse5dNmdnP/DskuGOhqLf7TGQWmQosYVcH5+fhPlAABogVDD0HQaV8BGRkaihefPn/P5/Ldv3xJChEJhbm5uaGio1MMBALQEqGFoCpKcBR0XFzdjxgx9ff1Hjx6Zmpreu3fP2dkZBQwA8g01DNIlyUlYy5cvT0pKKigoUFNTy87Onj9//siRI6WeDACgBcIpWiAtkhRwYWFh//79CSFaWlovX74MCAjAWdAAoFDq1vCMVVedApJOXRPQDgUyRpICtra2vnTpEiHE2Ng4PT2dw+EUFBRIORcAQIsnquE78aND/MznR9+w8ks8crGAdiiQGZIU8MKFC6Oioggh/v7+U6dO9fLy6tOnj7SDAQDIjBEDjDL3eEUE2ETE3UINQwNJchKWm5ubm5sbIcTf379169aPHj0aP368tIMBAMiYEQOMRgwwOnKxICLuVkTcrYgAmxEDjGiHgpZLkgImhKSmpu7bt6+wsLB9+/YTJkzApAQAABHUMDQQ5WlIAAByCQel4YswDQkAoKlgbxg+A9OQAACaFvaG4aMwDQkAoDmIa3jZlkzUMBBMQwIAaE6ig9IXbj1b8nvGnPXXF31vPc6lC5Mhyb4QyDpMQwIAaG6ONvqOcfqiGl62JQM1rJgknIaUmZm5bdu2J0+etGvXbvLkyT179pR+NAAAuYYaVnCS/E0fPHhwwIAB1dXVffr0ef36dZ8+fY4cOSL1ZAAAisDRRv98nNt/F/XfdozfdfT+7Ul8Yc072qGgOUhyGVJ4eHhCQsKQIUNED93d3cPCwkaMGCHVYAAACuRTe8NvqmviEnNTs14Y6nL83UwsTbRoJwWpkWQP+PHjx/b29uKHjo6Ojx49kl4kAAAFVW9vePPhPDv/w7uS7w3rY/jm7xqngGM4d1qeSFLAlpaWdW99tXHjRisrK+lFAgBQaOIaXrk18/8elwb5dPd3M4ld4LBrqfOUpZdwgFpuSHIIOjo6eujQoZs3bzYyMuLz+S9fvjx16pTUkwEAKDJHG/1unb7xHdpl2zH+si0Z62f3cXVoz2Yxcu7/hQPR8kGSAv7zzz/z8/NPnDghEAh8fX2HDx/O5XKlngwAQMHpaanXvKs9H+d24dazSUsu7j2VX1z6xlCHQzsXSIckBezt7S0QCMaMGSP1NAAAIDbOpYv3vDOuDu0dbfQvxLkNDUpWVib5T8q0eWza0UAKJPkOOCEhYcaMGdevX5d6GgAAEHO00f91hq3LzOSuo/ebee1vp8uJC+vvOef0gg038U2wHJBkD9jPz6+2tnbHjh0MBkP8JG5FCQAgdd+PMBszuHPO/b8MdTmig8/D7NtNWnKh94RDe1cMNDPCLHYZJkkBp6enSz0HAAB8lIa6ip2FjvihNo99bN2wLUfy+k05uuh762Bfc4rZ4GtIUsDiG1ICAAAV348wG9jbwDfs7OELBTuXOuHMLFnUuO+AX716NW7cuM6dO//444+vX79uokwAAPBFRvrcy5s9hvUxtPJLjD99n3YcaLTGFfCcOXNKSkp+++23Bw8ezJ8/v4kyAQBAQzAZyvP8LVNiXJdtyfSed6a0vJp2ImiExhXwsWPHYmNjR40a9fvvvx88eLCJMgEAQMNZmmil7fQ01OVYjDlw6pqAdhxoqMYV8J9//in6Arhjx47Pnj1rkkQAANBIbBZj3Sz7nUudpiy9OGPVlTfVNbQTwZc1+jpgJSUl8f8FAICWw9FG/068d2lFtZVfYvrdItpx4AsafRZ03WuQ6i736tVLOokAAEBSPC5r5y9OieceusxMDvGzmOffk8mQ5IZL0AwaV8AcDsfR0fHDZUJIRUWF9FIBAIDkvJw7fmuu88OyS0mXH+38xblLO03aieAjGvebUcWnNVE+AACQgKEOJ/k/LuNdjO0nHd64/w/aceAjcGgCAEBuTffpfnmzx7YkvnvoyRcllbTjwL+ggAEA5JmZEe/a1hG9urax8juYeO4h7TjwHgoYAEDOMRnKi3+0ObR6yPzoG5OWXMD9OloIFDAAgEKws9DJ3O2loaZiNS7xwi3cyIE+FDAAgKLQUFeJntt3w9y+k5Zc/CnqOu7XQRcKGABAsbg6tE/b4VnwrMJ+4uEsfgntOIoLBQwAoHC0eewDkYNC/CxcZiSv2XVbWPOOdiJFhAIGAFBQ/m4m17aOSLr8ePC0EwXPymnHUTgoYAAAxWWkz02JGe7Wr33v7w5tT+LTjqNYUMAAAAqNyVCePb5HSozr+j13vOedKS59QzuRokABAwDAP0OFjfQ1rPwSj6c+ph1HIaCAAQCAEEKYDOXfgu12LnUKWnUlcGVqReVb2onkHAoYAADec7TRv7Nv9JtqodW4xOt3CmnHkWcoYAAA+BcNdZWtix1Xh9h5zjkdHpuOi5SaCAoYAAA+YsQAo8w9o7L4xfaTjuQVlNKOI4dQwAAA8HF6WurH1g2bMtKs35SjGCosdShgAAD4nIBRXdN2eO5Kvjd42nFB4WvaceQHChgAAL7ASJ97ebOHYy99K79EDBWWFhQwAAB8GZOhHDbZKiXGdVFMmu/Csxgq/PVQwAAA0FCWJlqZe7y0eWyLMQfO3nxKO45sQwEDAEAjsFmM6Ll9t0U4Toy4ELr2GoYKSwwFDAAAjTbQ1uBOvPeL4korv0QMFZYMChgAACTB47L2rhgY8aPN4GnHI7dn4X4djYUCBgAAyY0Z0jlzj9eZG0/7TTmKocKNggIGAICvYqjDSYlxHe9i3Pu7Q3EHc2nHkRmUCzg1NdXMzIzNZnt4eLx69aruqqqqqvDw8M6dO/N4PD8/v3prAQCgRZnu0/3yZo9NCXfdQ09iqHBD0Czg6upqb2/v4OBggUCgqqq6YMGCumvv3LkjEAhOnjx5//79qqqq+fPn08oJAAANYWbES9vpaWmibTEm4cjFAtpxWjqaBXz16lUWixUYGKitrR0WFpaQkFB3ra2t7datW42NjbW0tIKCgq5du0YrJwAANBCTobw0sNeh1UNC1lybtOQChgp/Bs0Czs/PNzc3Fy2bmpoWFRWVlZV99JX379/v0qVLM0YDAADJ2Vno3Nk3ms1iWoxNSM16QTtOC8Wk+NlVVVVcLle0rKamxmQyKysrNTU1672srKxs7dq1u3fvrvtkTm5eSclL8UMVlkpTpwUAgIbTUFeJXeBwPPWx78KzY4d2Xhlky2TgtN9/ofnHweFwysv/OWddKBQKhUIOh1PvNZWVlSNHjpw7d66NjU3d579p1UpXV0f8n462djOFBgCABnN1aJ+5xyv/SVnvCYdy7r/88hsUCc09YGNj45ycHNEyn8/X1dUV7xCLvHr1ysPDY8KECZMnT673XgP9tvWeOXvxctNFBQAAyWjz2IdWD9mexHcKSJo/0XL2+B60E7UUNPeA7ezshEJhbGxsSUlJRESEp6dn3bUlJSVDhw4NCAiYMmUKrYQAACAV/m4maTs8ky4/dgpIwv06RGgWsIqKSnx8fFRUlIGBQUVFxYoVK0TPW1tbZ2ZmRkVF3bhxY9y4cUpKSkpKSkwmzZ11AAD4Skb63JSY4W792vf+7tDu5Hzaceij3GoODg55eXn1nszIyCCEWFlZ/fLLLzRCAQBAk2AylGeP7zHQ1mBSxIXDFwpiFzho89i0Q1GDc9IAAKBZWZpoXds20khfw8ov8XjqY9pxqEEBAwBAc2OzGL8F2+1c6hS06sqMVVcU834dKGAAAKDD0UY/c7dXRdXb3t8dun6nkHac5oYCBgAAanhc1tbFjsum9facc3rJ77cUaqgwChgAACjzcu6YttMzPbeo35SjeQWltOM0ExQwAADQZ6jDObZu2HgXY6eApI37/6AdpzmggAEAoKUQDRXelXzPZWayoPA17ThNCwUMAAAtSJd2mpc3e9iZ6/SecCjx3EPacZoQChgAAFoWJkN58Y82x9YNXRSTNuHn86Xl1bQTNQkUMAAAtES9urVJ2+HJ02BZjDlw4dYz2nGkDwUMAAAtlIa6SvTcvpvDB0wIP/9T1PU31TW0E0kTChgAAFq0ofaGd+K9C55V9J5wKItfQjuO1KCAAQCgpeNxWQciB82faDl42vHI7Vnycb8OFDAAAMiGcS5dMvd4nbwqkI+hwihgAACQGYY6nPNxbqMHdur93aEtR+pPs5UtKGAAAJAxwb7m5+PcNsT/4TnndHHpG9pxJIQCBgAA2WPeuXXaTk8zI57FmAQZHSqMAgYAAJnEZCivDLI9EDkoaNWVH5ZdkrmhwihgAACQYQ6Wenf2jSaEWIxNkK2hwihgAACQbRrqKv9d1H/D3L6ec04v2HBTVi5SQgEDAIA8cHVofyd+dM79l70nHMq5/5J2nC9DAQMAgJzQ5rGPrRsWNKa7U0BS1N4c2nG+AAUMAABy5fsRZmk7PBPOPnAKSGrJQ4VRwAAAIG+M9Lnn49yG9TG08kuMP32fdpyPQwEDAIAcYjKU5/lbpsS4LtuS6T3vTAscKowCBgAAuWVpopW209NQl2Mx5sCpawLacf4FBQwAAPKMzWKsm2W/c6nTlKUXZ6y60nKGCqOAAQBA/jna6N+J9y6tqLbyS0y/W0Q7DiEoYAAAUBA8LmvnL07LpvV2mZm85Pdb1O/XgQIGAAAF4uXcMXOP1/Wcwn5TjuY/KaOYBAUMAACKxVCHk/wfl/Euxv2mHN24/w9aMVDAAACgiKb7dD8f57Ytie8eevJFSWXzB0ABAwCAgjIz4l3bOqJX1zZWfgcTzz1s5k9HAQMAgOJiMpQX/2hzaPWQRTFpk5ZcaM77daCAAQBA0dlZ6KTt8NRQU7Eal3jh1rPm+VAUMAAAANFQV4me23fD3L6Tllz8Kep6M9yvAwUMAADwD1eH9mk7PAueVdhPPJzFL2nSz0IBAwAAvKfNYx+IHBTiZzF42vE1u2433f06UMAAAAD1+buZpO3wTLr8ePC0EwXPypviI1DAAAAAHyEaKuzWr33v7w5tT+JLffsoYAAAgE+aPb5HSozr+j13vOedKS59I8Uto4ABAAA+RzRU2Ehfw8ov8XjqY2ltlimtDQEAAMgrJkP5t2C7EQOMJvx8Puny4/kTey6KTU+6/IgQMsy+XfTcvto8dmO3iT1gAACABnGw1Luzb3Tl329Nvfb/Vfb35c0e17aO1FBXGTztuAQnS6OAAQAAGkpDXcVnUGcNNeat3KL40w+6tNP876L+pRXVEhyaRgEDAAA0Qv6TMk+njpl7vAqel4vuHe3m0D6voLSx20EBAwAANIJ5528OXyjgcVV3/uKkzWMLa94lnH1o3rl1Y7eDk7AAAAAaYaCtgXnn1t7zUkJ8LRgMpTW7bhvpawy1N2zsdrAHDAAA0DjH1g01M+KFrLn2w7JLXdq1StnoymQ0uk+xBwwAANA4GuoqvwXb/Rb8VRvBHjAAAAAFKGAAAAAKUMAAAAAUoIABAAAoQAEDAABQgAIGAACgAAUMAABAAQoYAACAAhQwAAAABShgAAAAClDAAAAAFKCAAQAAKEABAwAAUIACBgAAoIByAaemppqZmbHZbA8Pj1evXjVqLQAAgOyiWcDV1dXe3t7BwcECgUBVVXXBggUNXwsAACDTaBbw1atXWSxWYGCgtrZ2WFhYQkJCw9cCAADINJoFnJ+fb25uLlo2NTUtKioqKytr4FoAAACZxqT42VVVVVwuV7SspqbGZDIrKys1NTUbsvbp8+cVFZXiTTGYjGYMDgAA8LVoFjCHwykvLxctC4VCoVDI4XAauPavv0qLX74UP2SpsJolMgAAgHTQLGBjY+OcnBzRMp/P19XVFe/yfnGtebeu9bZ2525uE+cFAACQGprfAdvZ2QmFwtjY2JKSkoiICE9Pz4avBQAAkGk0C1hFRSU+Pj4qKsrAwKCiomLFihWi562trTMzMz+1FgAAQA7QPARNCHFwcMjLy6v3ZEZGxmfWAgAAyAHcihIAAIACFDAAAAAFKGAAAAAKKH8HLEWqLFbc1h20UwAAABAul/PF18hPAU8cN/bDJy9dudamjXZXE+PmzwOf8fDR43v3HwxxdqQdBP5FKBRu37v/+wl+tINAfUdOnPzWxlpPV4d2EPiXjOzbNTXveltbSvZ2HIIGAACgAAUMAABA043zCgAABZdJREFUAQoYAACAAvn5DvijWrf+RoPz5W/CoZmpq6m10dainQLqU1JSam9oQDsFfISeThtVVVXaKaC+Vpqa7969k/jtStnZ2T169JBiIAAAAPi827dv4xA0AAAABShgAAAAClDAAAAAFKCAAQAAKJDbAk5NTTUzM2Oz2R4eHq9evaIdB94rKys7deqUkZFRQkIC7Szwj6qqqvDw8M6dO/N4PD8/P/yTaSEqKipCQ0P19fV1dHRmzpwpFAppJ4L6+Hy+mppaaWmpBO+VzwKurq729vYODg4WCASqqqoLFiygnQjeGzRoUHh4uLKyfP5vT0bduXNHIBCcPHny/v37VVVV8+fPp50ICCEkOzv73bt3aWlp6enp169f37RpE+1E8C+1tbWBgYF///23ZG+Xz+uAr169ymKxAgMDCSFhYWFDhgyJiYmhHQr+cfPmTULIsGHDaAeB92xtbW1tbUXLQUFBs2fPppsHRPr27du3b1/Rso+PT1paGt08UE9sbKytre3Fixcle7t87oXk5+ebm5uLlk1NTYuKisrKyuhGApAV9+/f79KlC+0U8J5QKMzNzd23b9+AAQNoZ4H3BAJBXFxceHi4xFuQzwKuqqricrmiZTU1NSaTWVlZSTcSgEwoKytbu3YtvrVpUUJCQrp166ampjZ27EdmvgEtgYGBK1euVFdXl3gL8lnAHA6nvLxctCwUCoVCIQc3pAT4ksrKypEjR86dO9fGxoZ2FngvOjpaIBB06NBh0qRJtLPAP/bu3ctms4cPH/41G5HPAjY2Ns7JyREt8/l8XV1d8Q4xAHzUq1evXFxc/Pz8Jk+eTDsL/IuSkpKBgcG0adMuXbpEOwv8IzExMSEhQUlJSUlJqaam5ptvvklKSmrsRuTzJCw7OzuhUBgbG+vj4xMREeHp6Uk7EUCLVlJS4urqOnPmTD8/P9pZ4L0VK1ZwuVwfH5+amppVq1Y5OzvTTgT/qHsVJZPJLC4u5vF4jd2IfO4Bq6ioxMfHR0VFGRgYVFRUrFixgnYigBYtKirqxo0b48aNE/1Gz2TK56/mMmfs2LFXrlzp0aNHjx49tLS0cDWHnME0JAAAgOaGaUgAAAB0oIABAAAoQAEDAABQgAIGAACgAAUMAABAAQoYAACAAhQwAAAABShgAAAAClDAAAAAFKCAAQAAKEABAwAAUIACBgAAoAAFDKAohEKhkpLSixcvCCGFhYXdu3evrq6mHQpAcWHoGIAi0tHR+eOPP2inAFBo2AMGUBS9evUihLRt23bXrl0CgUBJSYkQUlBQwGQyN23a1KFDBz09vaSkpDVr1mhpabVv3/7UqVOiN/7xxx+Ojo6ampo2NjY3btyg+TMAyBEUMICiSE9PJ4Q8f/58/PjxdZ+vqanJz8+/detWaGjo2LFj8/LyHjx4MHXq1FmzZhFCKioqBg8ePGjQoKdPn/7000+urq5//fUXnR8AQL6ggAEUHYPBWL16tba29qhRo968ebNp06ZWrVqNHj26oKCAEHLixAkul7to0SIulzt27Fhra+uEhATakQHkAb4DBoB/qKioEEIYDAYhhMVi1dTUEEIEAgGfzxcdrxaxtramlRBAnqCAAeBzOnTo0Ldv39TUVNpBAOQNDkEDKAomk8nhcB48eNCodw0bNkwgEKxfv/7Vq1dPnjxZtWrVL7/80kQJARQKChhAgQQHBw8cOHDx4sUNfwuHw0lJSTl79mynTp2+/fbbnJyceudwAYBklLKzs3v06EE7BgAAgAK5ffs29oABAAAoQAEDAABQgAIGAACgAAUMAABAAQoYAACAAhQwAAAABShgAAAAClDAAAAAFKCAAQAAKEABAwAAUIACBgAAoAAFDAAAQAEKGAAAgAIUMAAAAAUoYAAAAAqYhJDbt2/TjgEAAKBY/h+zPlUPAaKlOgAAAABJRU5ErkJggg=="/>
</div>
</article>
<article id="IDX2" aria-label="Rischio stimato">
<h1 class="contentitem toc">Rischio stimato</h1>
<div class="c">
<img style="height: 480px; width: 640px" alt="Un diagramma della funzione di rischio stimata utilizzando il metodo delle tabelle di vita" src="data:image/png;base64,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WYNh/Pz87p+/qTdh3WfrwcHBqpf29vY19z4F/c0330h1TkGPHDlSkqT9+/f/9NNPd685IiLi7jVzExaaG6eggQZs2rRp6NChbdq06dmz57fffqu6Aef+GnmKcs+ePaGhoc7OziYmJl26dJk3b95PP/10n7O1Klu3bl27dm2vXr3MzMzs7e0nTJiwfv36eu+JiIgYPXq06qtBO3bs6NixY2Py3MuTTz65efNmb29vKyurtm3b9unTZ82aNS+88IIqzEcffdSnTx8zMzNbW9tx48b97//+b+PX3Jg9cJ+tr1ixIigoyMLC4saNGw88h9zgzxUSEtK+ffuuXbsuX758+vTpkiSlp6ffvWb1/qWAJjFKTk7u16+f6BgAABiQixcv0gEDACAABRgAAAEowAAACEABBgBAAAowAAACUIABABCAAgwAgAAUYAAABDARHUBj9nzzbe0I6gAACGRn23n0iMD7v0d/CnB5eflLLzwvOgUAANLWHV888D2cggYAQAAKMAAAAujPKWgAAFrMhfTCE/E3JEkaNtDeo4e1GmugAwYAoGm2fnt58IvfJVy6dSG9cPCL363dfVGNldABAwDQBBnZpSFrzqZETHJ1bCdJUlZuWa+JXwf6OLi7dGjSeuiAAQBoglOJucMft3d1bJeTf1uSJGc72ajBXU/E5zZ1PRRgAACawNzMpLxCUSVXPvnSoZgLeZIklVfeMW9t3NT1UIABAGiCIZ5dEi7fevmDGI8eHf08bONS8mMu5I30c2rqergGDABAEzjYWK5f7PPiO6c9elj7vHAgNfOPbSuecLCxbOp6KMAAADTN8bgbi6b38+7bWZKkQY92trW2UGMlFGAAAJrg5PncuNT8y2GTzc2afN23Lq4BAwDQWApldfCqs2tCvB+y+koUYAAAGm/rvsu21m0mDH3k4VfFKWgAABqloLgq7JPz0dvGaGRtdMAAADRK6OaE6U93d3O20sja6IABAHiwhEu3DkdfS4mYpKkV0gEDAPBgC9fFhr3kaSUz09QKKcAAADzAniMZVXLlnLFuGlwnp6ABALif8oo7i8Pj9q8J0Oxq6YABALif9z5LCvJ18O5ro9nV0gEDAHBPGdml2w6kpURM1Pia6YABALin4NVnXp/lod7Tnu+PAgwAQMOiYnOycssWPOveHCunAAMA0IAquXL+qpiNSweZGDdLraQA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"/>
</div>
</article>
</section>
<article id="IDX3" aria-label="Riepilogo con censura">
<h1 class="contentitem toc">Riepilogo con censura</h1>
<table class="table" style="border-spacing: 0" aria-label="Riepilogo con censura">
<caption aria-label="Riepilogo con censura"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Riepilogo del numero di valori con censura e senza censura</th>
</tr>
<tr>
<th class="r b header" scope="col">Totale</th>
<th class="r b header" scope="col">In errore</th>
<th class="r b header" scope="col">Con censura</th>
<th class="r b header" scope="col">Percentuale<br/>con censura</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">15</td>
<td class="r data">11</td>
<td class="r data">4</td>
<td class="r data">26.67</td>
</tr>
</tbody>
</table>
</article>
</section>
<section data-name="Lifetest" data-sec-type="proc">
<hr class="pagebreak"/>
<div id="IDX4" class="systitleandfootercontainer" style="border-spacing: 1px">
<p><span class="c systemtitle">“analisi KM durata episodi”</span> </p>
</div>
<div class="proc_title_group">
<p class="c proctitle">La procedura LIFETEST</p>
</div>
<h1 class="contentprocname toc">La procedura Lifetest</h1>
<section>
<h1 class="contentfolder toc">Strato 1</h1>
<article aria-label="Stime prodotto-limite">
<h1 class="contentitem toc">Stime prodotto-limite</h1>
<table class="table" style="border-spacing: 0" aria-label="Stime prodotto-limite">
<caption aria-label="Stime prodotto-limite"></caption>
<colgroup><col/><col/></colgroup><colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="7" scope="colgroup">Stime di sopravvivenza prodotto-limite</th>
</tr>
<tr>
<th class="r b header" scope="col">time</th>
<th class="r b header" scope="col"> &#160;</th>
<th class="r b header" scope="col">Sopravvivenza</th>
<th class="r b header" scope="col">Insuccesso</th>
<th class="r b header" scope="col">Errore standard della sopravvivenza</th>
<th class="c b header" scope="col">Numero<br/>insuccessi</th>
<th class="c b header" scope="col">Numero<br/>rimasti</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">0.00000</th>
<th class="r data">&#160;</th>
<td class="r data">1.0000</td>
<td class="r data">0</td>
<td class="r data">0</td>
<td class="r data">0</td>
<td class="r data">15</td>
</tr>
<tr>
<th class="r rowheader" scope="row">0.10000</th>
<th class="r data">&#160;</th>
<td class="r data">0.9333</td>
<td class="r data">0.0667</td>
<td class="r data">0.0644</td>
<td class="r data">1</td>
<td class="r data">14</td>
</tr>
<tr>
<th class="r rowheader" scope="row">0.20000</th>
<th class="r data">&#160;</th>
<td class="r data">0.8667</td>
<td class="r data">0.1333</td>
<td class="r data">0.0878</td>
<td class="r data">2</td>
<td class="r data">13</td>
</tr>
<tr>
<th class="r rowheader" scope="row">0.50000</th>
<th class="r data">&#160;</th>
<td class="r data">0.8000</td>
<td class="r data">0.2000</td>
<td class="r data">0.1033</td>
<td class="r data">3</td>
<td class="r data">12</td>
</tr>
<tr>
<th class="r rowheader" scope="row">0.50000</th>
<th class="r data">*</th>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">3</td>
<td class="r data">11</td>
</tr>
<tr>
<th class="r rowheader" scope="row">0.70000</th>
<th class="r data">&#160;</th>
<td class="r data">0.7273</td>
<td class="r data">0.2727</td>
<td class="r data">0.1167</td>
<td class="r data">4</td>
<td class="r data">10</td>
</tr>
<tr>
<th class="r rowheader" scope="row">0.80000</th>
<th class="r data">&#160;</th>
<td class="r data">0.6545</td>
<td class="r data">0.3455</td>
<td class="r data">0.1257</td>
<td class="r data">5</td>
<td class="r data">9</td>
</tr>
<tr>
<th class="r rowheader" scope="row">1.30000</th>
<th class="r data">&#160;</th>
<td class="r data">0.5818</td>
<td class="r data">0.4182</td>
<td class="r data">0.1311</td>
<td class="r data">6</td>
<td class="r data">8</td>
</tr>
<tr>
<th class="r rowheader" scope="row">1.50000</th>
<th class="r data">&#160;</th>
<td class="r data">0.5091</td>
<td class="r data">0.4909</td>
<td class="r data">0.1334</td>
<td class="r data">7</td>
<td class="r data">7</td>
</tr>
<tr>
<th class="r rowheader" scope="row">1.80000</th>
<th class="r data">*</th>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">7</td>
<td class="r data">6</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2.50000</th>
<th class="r data">&#160;</th>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">8</td>
<td class="r data">5</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2.50000</th>
<th class="r data">&#160;</th>
<td class="r data">0.3394</td>
<td class="r data">0.6606</td>
<td class="r data">0.1323</td>
<td class="r data">9</td>
<td class="r data">4</td>
</tr>
<tr>
<th class="r rowheader" scope="row">2.50000</th>
<th class="r data">*</th>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">9</td>
<td class="r data">3</td>
</tr>
<tr>
<th class="r rowheader" scope="row">3.20000</th>
<th class="r data">&#160;</th>
<td class="r data">0.2263</td>
<td class="r data">0.7737</td>
<td class="r data">0.1277</td>
<td class="r data">10</td>
<td class="r data">2</td>
</tr>
<tr>
<th class="r rowheader" scope="row">3.70000</th>
<th class="r data">&#160;</th>
<td class="r data">0.1131</td>
<td class="r data">0.8869</td>
<td class="r data">0.1024</td>
<td class="r data">11</td>
<td class="r data">1</td>
</tr>
<tr>
<th class="r rowheader" scope="row">3.80000</th>
<th class="r data">*</th>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">.</td>
<td class="r data">11</td>
<td class="r data">0</td>
</tr>
</tbody>
</table>
<div class="proc_note_group">
<p class="c note"><span class="c notebanner">Nota:</span><span class="c notecontent">I tempi di sopravvivenza contrassegnati sono osservazioni con censura.</span></p>
</div>
</article>
<section>
<h1 class="contentfolder toc">Riepilogo di time</h1>
<div class="proc_note_group">
<p class="c proctitle">Statistiche di riepilogo per la variabile temporale time</p>
</div>
<article id="IDX5" aria-label="Quartili della distribuzione di sopravvivenza">
<h1 class="contentitem toc">Quartili della distribuzione di sopravvivenza</h1>
<table class="table" style="border-spacing: 0" aria-label="Quartili della distribuzione di sopravvivenza">
<caption aria-label="Quartili della distribuzione di sopravvivenza"></caption>
<colgroup><col/><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="5" scope="colgroup">Stime dei quartili</th>
</tr>
<tr>
<th class="r b header" rowspan="2" scope="col">Percentuale</th>
<th class="r b header" rowspan="2" scope="col">Stima<br/>puntuale</th>
<th class="c b header" colspan="3" scope="colgroup">Intervallo di confidenza al 95%</th>
</tr>
<tr>
<th class="b header" scope="col">Trasformata</th>
<th class="r b header" scope="col">[Inferiore</th>
<th class="r b header" scope="col">Superiore)</th>
</tr>
</thead>
<tbody>
<tr>
<th class="r rowheader" scope="row">75</th>
<td class="r data">3.20000</td>
<td class="data">LOGLOG</td>
<td class="r data">1.50000</td>
<td class="r data">.</td>
</tr>
<tr>
<th class="r rowheader" scope="row">50</th>
<td class="r data">2.50000</td>
<td class="data">LOGLOG</td>
<td class="r data">0.50000</td>
<td class="r data">3.20000</td>
</tr>
<tr>
<th class="r rowheader" scope="row">25</th>
<td class="r data">0.70000</td>
<td class="data">LOGLOG</td>
<td class="r data">0.10000</td>
<td class="r data">1.50000</td>
</tr>
</tbody>
</table>
</article>
<article id="IDX6" aria-label="Media">
<h1 class="contentitem toc">Media</h1>
<table class="table" style="border-spacing: 0" aria-label="Media">
<caption aria-label="Media"></caption>
<colgroup><col/><col/></colgroup>
<thead>
<tr>
<th class="r b header" scope="col">Media</th>
<th class="r b header" scope="col">Errore<br/>standard</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">1.98949</td>
<td class="r data">0.37046</td>
</tr>
</tbody>
</table>
<div class="proc_note_group">
<p class="c note"><span class="c notebanner">Nota:</span><span class="c notecontent">Il tempo di sopravvivenza medio e il relativo errore standard sono stati sottostimati perché l&apos;osservazione più ampia è stata censurata e la stima è stata ristretta al tempo dell&apos;evento più ampio.</span></p>
</div>
</article>
</section>
<article id="IDX7" aria-label="Curva di sopravvivenza">
<h1 class="contentitem toc">Curva di sopravvivenza</h1>
<div class="c">
<img style="height: 480px; width: 640px" alt="Curva di sopravvivenza prodotto-limite" src="data:image/png;base64,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NzfX19dXnQ4LC6urqyspKWl0yby8PD8/v+sYDQCAliWzgMvLyz08PNRptV8vXLhw5WIlJSWffPLJkiVLrms4AABakswbcXh7e1dUVKjTFotFCOHv799gmfPnz/ft23fSpEnR0dH1H//nZ9tPnzlzfXICAKA7mQUcEhKSlpamTmdlZRkMhsDAwPoLFBcX9+3bd8yYMampqQ3WHR0+osEj77y/tuWiAgCgL5lD0DExMVarNSoqqrCwMDY2tnfv3vXnFhYW9unTJzo6+sMPP5SVEACAFiKzgD09PZOSkjIyMoKDgysrKzMzM22Pp6enT5061Ww2v/3228pvJEYFAEBfkj+MITY2NjY2tsGD5eXlQoioqCgZiQAAuB64FSUAABJQwAAASEABAwAgAQUMAIAEFDAAABJQwAAASEABAwAgAQUMAIAEFDAAABJQwAAASEABAwAgAQUMAIAEFDAAABJQwAAASEABAwAgAQUMAIAEFDAAABJQwAAASEABAwAgAQUMAIAEFDAAABJQwAAASEABAwAgAQUMAIAEFDAAwIkoocmyI/w/FDAAABJQwAAASGCUHQAAAH00c3jZtpg1e1pLxvkdFDAAwBE0s02V0GS5vWvDEDQAABJQwAAASEABAwCcSCsZfxYUMAAAUlDAAABIQAEDACABBQwAgAQUMAAAElDAAABIQAEDACABBQwAgAQUMAAAElDAAABIQAEDACABBQwAgAQUMAAAElDAAABIQAEDACABBQwAgAQUMAAAElDAAABIQAEDACABBQwAgAQUMAAAElDAAABIQAEDACABBQwAgAQUMAAAElDAAABIQAEDACABBQwAgAQUMAAAElDAAABIQAEDACABBQwAgASSC3jVqlVubm6KogQEBBQXF9s1FwCAG5fMAjabzXFxcZGRkQUFBa6uruHh4c2fCwDADU1mAaekpBgMhvT09ODg4GXLlh0+fLj5cwEAuKHJLODc3FxfX191OiwsrK6urqSkpJlzAQC4ocks4PLycg8PD3Xaz89PCHHhwoVmzgUA4IZmlLhvb2/viooKddpisQgh/P39mzn3n59tP33mzPXLCgCArmQWcEhISFpamjqdlZVlMBgCAwObOXd0+IgGW3vn/bUtnBcAAN3IHIKOiYmxWq1RUVGFhYWxsbG9e/du/lwAAG5oMgvY09MzKSkpIyMjODi4srIyMzPT9nh6evrV5gIA4ABkDkELIWJjY2NjYxs8WF5e3sRcAAAcALeiBABAAgoYAAAJKGAAACSQ/BqwjtxMJt6JBABoDby9b/rdZRyngP806THdt/nO+2ufjpms+2ZhL74RrQTfiNaD70UrcS3fCIagAQCQgAIGAEACChgAAAkoYAAAJKCAm9Ix8GbZESAE34hWg29E68H3opW4lm+EkpeXd8cdd+iYBgAANC0/P58zYAAAJKCAAQCQgAIGAEACCrgRq1atcnNzUxQlICCguLhYdhynVlJSkpCQ4OrqOmvWLNlZnFdZWdl9991nMpkMBkPXrl35RyHL2bNn+/fv7+Li4uLicuedd1osFtmJILZv364oyokTJzSsSwE3ZDab4+LiIiMjCwoKXF1dw8PDZSdyar169UpISJCdwtlt3rz5zJkzW7duLSgoqKqqeuihh2QnclKbNm2qq6vbs2fPN99888MPP0yezK0oJaurq3vsMe13QaaAG0pJSTEYDOnp6cHBwcuWLTt8+LDsRE7NbDabzea2bdvKDuLUYmJiCgsLw8LCbr311ueff/7YsWOyEzmp6dOn79+/PyQk5J577hk2bFhOTo7sRM5u4sSJvXr10rw6BdxQbm6ur6+vOh0WFlZXV1dSUiI3EtB65OXl+fn5yU7h1CwWy9atW7/44ov7779fdhantnfv3s2bN2/ZskXzFhzn05D0Ul5e7uHhoU6rv2guXLgQFBQkNRTQKpSUlHzyySfvvfee7CBObcCAAQcOHPDx8Vm6dKnsLE4tIiJizpw57du317wFzoAb8vb2rqioUKfVaxz8/f2lJgJahfPnz/ft23fSpEnR0dGyszi1/fv3Z2dn+/n59e/fX3YW5xUXF+fq6rpgwYJr2QgF3FBISMjFixfV6aysLIPBEBgYKDcSIF1xcXHPnj0jIiJSU1NlZ3F2BoMhJCRkzpw5vDom0aZNm06ePKkoiqIoQoiuXbtqKGMKuKGYmBir1RoVFVVYWBgbG9u7d2/ZiQDJCgsL+/TpEx0d/eGHH8rO4tRGjBgxbty4gwcP5ubmLly48JZbbpGdyHmdPHnS+hshxPHjxxctWmTvRijghjw9PZOSkjIyMoKDgysrKzMzM2UnAiSbOnWq2Wx+++23ld/ITuSk5s2bt2fPnn79+oWEhPj4+OzatUt2IlwTPowBAIDrjQ9jAABADgoYAAAJKGAAACSggAEAkIACBgBAAgoYAAAJKGAAACSggAEAkIACBgBAAgoYAAAJKGAAACSggAEAkIACBpyFxWJRFCU/P18I8b//+7/u7u5ms1l2KMB5GWUHACBBnz59LBaL7BSAU+MMGHAWfn5+Qoh+/frNmDFj79696sf67t69W1GUiRMnurq6uri4LFiwYPTo0QaDwWg0JiQkqCtu3rzZ19fXYDDcdNNNqampMp8D4EAoYMBZlJWVCSHy8vJWr17dYFZhYeGhQ4dGjhz56quvHj169MSJEw888MCrr74qhDh79mxkZGRISEhJScnUqVOffPLJY8eOSUgPOBwKGIDYu3dvcHBwfHy8ECI/P79z586zZs2qrKwUQixZssRoNO7YsSMwMDApKcnPz2/BggWy8wKOgNeAAfw/Hh4eQgiTySSE8PT0VB8sKiqqqqpSx6tVhYWFUuIBDoYCBtCU4OBgHx+fS5cuyQ4COBqGoAFn4e7uLoT47rvv7FrrhRdeKC8vf/TRR4uLi//zn/+MGjXqgQceaJmAgHOhgAEnMnDgwOnTpw8ZMqT5q3To0GHbtm3fffddly5dBg4ceOTIEV4DBnSh5OXl3XHHHbJjAADgRPLz8zkDBgBAAgoYAAAJKGAAACSggAEAkIACBgBAAgoYAAAJKGAAACSggAEAkIACBgBAAgoYAAAJKGAAACSggAEAkIACBgBAAgoYAAAJKGAAACQwCiHy8/NlxwAAwLn8fz0QwnSXxhYVAAAAAElFTkSuQmCC"/>
</div>
</article>
<article id="IDX8" aria-label="Curve di rischio smoothing stimato">
<h1 class="contentitem toc">Curve di rischio smoothing stimato</h1>
<div class="c">
<img style="height: 480px; width: 640px" alt="Curve di rischio smoothing stimato" src="data:image/png;base64,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"/>
</div>
</article>
</section>
<article id="IDX9" aria-label="Riepilogo con censura">
<h1 class="contentitem toc">Riepilogo con censura</h1>
<table class="table" style="border-spacing: 0" aria-label="Riepilogo con censura">
<caption aria-label="Riepilogo con censura"></caption>
<colgroup><col/><col/><col/><col/></colgroup>
<thead>
<tr>
<th class="c b header" colspan="4" scope="colgroup">Riepilogo del numero di valori con censura e senza censura</th>
</tr>
<tr>
<th class="r b header" scope="col">Totale</th>
<th class="r b header" scope="col">In errore</th>
<th class="r b header" scope="col">Con censura</th>
<th class="r b header" scope="col">Percentuale<br/>con censura</th>
</tr>
</thead>
<tbody>
<tr>
<td class="r data">15</td>
<td class="r data">11</td>
<td class="r data">4</td>
<td class="r data">26.67</td>
</tr>
</tbody>
</table>
</article>
</section>
</div>
</body>
</html>






...
