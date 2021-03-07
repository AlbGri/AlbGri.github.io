---
title: "Statistics: Data Mining"
excerpt: "note"
date: 2021-03-07
tags: [statistics, math, theory, university, R]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire`



## Modelli Lineari e Minimi Quadrati (LS)

### Modello lineare multidimensionale
a più $$X$$.  
Sia $$y=X\beta+\epsilon$$  
con OLS (proiezione ortogonale di $$y$$ su $$\mathcal{C}(X)$$):  
$$\hat{y}=X\hat{\beta}$$, dove $$\hat{\beta}=(X^T X)^{-1}X^T y$$.

Nota: se si applica OLS con le esplicative trasformate con il logaritmo si mantiene lineare nei parametri, ma se il logaritmo si applica alla risposta non è più lineare nei parametri. La stima non è OLS e non è la migliore in termini di minimizzazione della devianza, ma mantiene la sua validità. Anche l'$$R^2$$ non risulterebbe confrontabile.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Ricalcolare l'$$R^2$$ retrotrasformando la previsione per il log Y, ovvero retrotrasformarla con l'esponenziale per ottenere Y.

#### Variabili qualitative: dummy e contrasti
- Parametrizzazione ad angolo: 0/1
- Parametrizzazione simmetrica: +1/-1 (la somma degli coefficienti fa 0)
- Parametrizzazione media
- ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Altre

### Modello lineare multivariato
a più $$Y$$.  
Sia $$Y=X\mathcal{B}+\mathcal{E}$$  
con $$\mathcal{B}$$ matrice di parametri $$p$$ righe (numero di variabili esplicative) per $$q$$ colonne (numero di variabili risposta) e 
con $$\mathcal{E}$$ matrice di errore $$n$$ righe per $$q$$ colonne, in cui si assume che ogni riga è indipendente.  
$$\tilde{Y_i}$$ come vettore colonna, sarebbe la i-esima riga della matrice $$Y$$ messa in colonna. Per semplicità la si mette come vettore colonna e la variabile multivariata è espressa dalle righe della Y.  
Inoltre, $$VAR\{\tilde{\mathcal{E}}\}=\Sigma$$

### Stima LS con $$n$$ non troppo grande

#### Scomposizione QR
Complessità computazionale $$2np^2$$  
Per ottenere R e Q si può usare l'Algoritmo Gram-Schmidt che ortogonalizza la matrice  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Interpretazione geometrica e relazione con il coefficiente di correlazione parziale

#### Scomposizione di Cholesky

### Stima LS con $$n$$ grande

#### Stima ricorsiva (filtro lineare)
Inverte $$p \times p$$ quindi se si ha un numero elevato di variabili diventa oneroso.  
Per invertire una matrice generica (eg. somma di due matrici) in questo caso si usa la formula di Sherman-Morrison.  
Si inverte solo una volta e poi si aggiornano le stime. Si può iniziare anche dalla Identità.  
Formula analoga per la stima della varianza.  

<!--- 
### Esercizi

##### AS, ES. 2.8
Complete the details of the statements at the end of section 2.2.2 by calculating $$s^2$$ and standard errors, using (2.10) or any other method.

##### AS, ES. 2.9 
Check the correctness of the Sherman-Morrison formula (A.2).

##### AS, ES. 2.10
Check the correctness of the formulas provided by recursive updating of the least squares estimates.

##### AS, ES. 2.11
Prove (2.24).

##### AS, ES. 2.12
What is the difference between the confidence interval of the value of the function and the prediction interval, both relative to the next observation?

--->



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
- [Data analysis and data mining](http://azzalini.stat.unipd.it/Book-DM/index.html)
- [The Elements of Statistical Learing](https://web.stanford.edu/~hastie/ElemStatLearn/printings/ESLII_print12_toc.pdf)



...
