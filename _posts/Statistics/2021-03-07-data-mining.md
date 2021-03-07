---
title: "Statistics: Data Mining"
excerpt: "note"
date: 2021-03-07
tags: [statistics, math, theory, university, R]
mathjax: "true"
---

*in costruzione*


## Modelli Lineari e Minimi Quadrati (LS)

### Modello lineare multidimensionale
a più $$X$$

### Modello lineare multivariato
a più $$Y$$  
Sia $$Y=X\mathcal{B}+E$$  
con $$\mathcal{B}$$ matrice di parametri $$p$$ righe (numero di variabili esplicative) per $$q$$ colonne (numero di variabili risposta) e 
con $$\mathcal{E}$$ matrice di errore $$n$$ righe per $$q$$ colonne.  
$$\tilde{Y_i}$$ come vettore colonna, per semplicità la si mette come vettore colonna e la variabile multivariata è espressa dalle righe della Y metto la tilde sopra per identificare la riga messa in colonna.

### Stima LS con $$n$$ non troppo grande

#### Scomposizione QR
Complessità computazionale $$2np^2$$  
Per ottenere R e Q si può usare l'Algoritmo Gram-Schmidt che ortogonalizza la matrice  
[da approfondire] Interpretazione geometrica e relazione con il coefficiente di correlazione parziale

#### Scomposizione di Cholesky

### Stima LS con $$n$$ grande

#### Stima ricorsiva (filtro lineare)
Inverte $$p \times p$$ quindi se si ha un numero elevato di variabili diventa oneroso.  
Per invertire una matrice generica (eg. somma di due matrici) in questo caso si usa la formula di Sherman-Morrison.  
Si inverte solo una volta e poi si aggiornano le stime. Si può iniziare anche dalla Identità.  
Formula analoga per la stima della varianza.  

### Esercizi
- AS, ES. 2.8 (calcolare s^2)
- AS, ES. 2.9 (sherman finisce inversa)
- AS, ES. 2.10 (correttezza aggiornamento)
- AS, ES. 2.11 (minimi quad ricorsivi per sigma2)
- AS, ES. 2.12 (differenza intervallo di confidenza)






## R - Parte 1
<button class="collapsible" id="es001">Esempio 1: ()</button>
<div class="content" id="es001R" markdown="1">

	```R
	########################################################
	Obiettivo: 
	########################################################
	
</div>

&nbsp;
&nbsp;





## Utili

### Risorse
- [The Elements of Statistical Learing](https://web.stanford.edu/~hastie/ElemStatLearn/printings/ESLII_print12_toc.pdf)



...
