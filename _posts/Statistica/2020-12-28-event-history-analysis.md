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
	1. Panel
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
