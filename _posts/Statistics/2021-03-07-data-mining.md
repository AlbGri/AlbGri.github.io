---
title: "Statistics: Data Mining"
excerpt: "note"
date: 2021-03-07
tags: [statistics, math, theory, university, R]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire`


## Appunti utili
- $$(A^T)^T$$ $$=A$$
- $$(A^{-1})^T$$ $$=(A^T)^{-1}$$
    1. $$A^{-1}A$$ $$=I$$  
    2. $$(A^{-1}A)^T=I^T$$ $$=I$$ 
    3. dato che $$(AB)^T=B^TA^T$$  
    4. $$A^T(A^{-1})^T$$ $$=I$$  
    5. dato che $$A$$ è invertibile allora anche $$A^T$$ lo è
    6. $$(A^T)^{-1}A^T(A^{-1})^T$$ $$=(A^T)^{-1}I$$  
    7. $$(A^{-1})^T$$ $$=(A^T)^{-1}  
- $$[(X^TX)^{-1}X^T]^T=X[(X^TX)^{-1}]^T=X[(X^TX)^T]^{-1}=X[(X)^T(X^T)^T]^{-1}$$ $$=X(X^TX)^{-1}$$  
- Proprietà dissociativa dell'addizione $$10=5+5=...$$
- Se $$Q$ ortogonale, allora $$Q^TQ=I$$
- $$(AB)^{-1}$$ $$=A^{-1}B^{-1}$$

## Modelli Lineari e Minimi Quadrati (LS)

Minimizzazione di $$D(\beta)=\sum_{i=1}^n\big\{y_i-f(x_i; \beta)\big\}^2=\left \| y-f(x; \beta) \right \|^2$$

### Modello lineare multidimensionale
a più $$X$$.  
Sia $$y=X\beta+\epsilon$$ con $$\mathbb{E}(\epsilon)=0$$.  
Tramite OLS (proiezione ortogonale di $$y$$ su $$\mathcal{C}(X)$$):  
$$\hat{y}=X\hat{\beta}$$, dove 
$$\hat{\beta}=(X^T X)^{-1}X^T y\equiv\beta+(X^T X)^{-1}X^T \epsilon$$.  

Sia $$\hat{\epsilon}=y-\hat{y}=y-X\hat{\beta}$$

Valore atteso dello stimatore  
$$\mathbb{E}[\hat{\beta}]=
\mathbb{E}[(X^TX)^{-1}X^T(X\beta+\epsilon)]=
\beta$$

Varianza dello stimatore  
$$\sigma^2(\hat{\beta})
=\mathbb{E}\big[ (\hat{\beta}-\mathbb{E}[\hat{\beta}])^2 \big]=\sigma^2(X^TX)^{-1}$$  
Stima non distorta della varianza dello stimatore  
$$\widehat{\mbox{var}}(\hat{\beta})=\frac{D(\hat{\beta})}{n-p}$$


Nota: se si applica OLS con le esplicative trasformate con il logaritmo si mantiene lineare nei parametri, ma se il logaritmo si applica alla risposta non è più lineare nei parametri. La stima non è OLS e non è la migliore in termini di minimizzazione della devianza, ma mantiene la sua validità. Anche l'$$R^2$$ non risulterebbe confrontabile.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Ricalcolare l'$$R^2$$ retrotrasformando la previsione per il log Y, ovvero retrotrasformarla con l'esponenziale per ottenere Y.

#### Projection Matrix
$$P$$ è la matrice cappello o di proiezione $$P=X(X^TX)^{-1}X^T$$
Risulta che $$\hat{y}=X\hat{\beta}=Py$$.

##### Proprietà della projection matrix
1. Matrice $$n\times n$$
2. $$P^T=P$$  
3. $$PP=P$$  
4. $$\mbox{tr}(P)=\mbox{rk}(P)=p$$


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
Stima LS: $$\hat{ \mathcal{B} }=(X^T X)^{-1}X^T Y$$.  
Inoltre, $$VAR\{\tilde{\mathcal{E}_i}\}=\Sigma$$ e $$\hat{\Sigma}=\frac{1}{n-p}Y^T(I-P)Y$$  


### Stima LS
Bisogna invertire la matrice $$X^TX$$ (che è simmetrica).  

#### Gauss-Jordan
Per invertire qualsiasi matrice si può usare il metodo di [Gauss-Jordan](https://www.youmath.it/forum/algebra-lineare/70367-matrice-inversa-con-gauss-jordan.html).

#### Fattorizzazione di Cholesky
Per invertire una matrice simmetrica, si può usare la fattorizzazione di Cholesky.  
Complessità computazionale $$p^3+\frac{np^2}{2}$$ e risulta molto lento con tante variabili.

#### Scomposizione Spettrale
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Per una matrice quadrata.

### Stima LS con $$n$$ non troppo grande

#### Scomposizione QR
Complessità computazionale $$2np^2$$.  
Si cerca una scomposizione $$X=QR$$ per cui $$Q$$ è una matrice ortogonale (colonne ortogonali l'una con l'altra) $$n\times p$$ e $$R$$ è triangolare superiore $$p\times p$$.  
$$\hat{\beta}=(X^T X)^{-1}X^T y=R^{-1} Q^T y\quad$$ e $$\quad\hat{y}=QQ^T y$$  
Per ottenere $$Q$$ si può usare l'Algoritmo Gram-Schmidt che ortogonalizza la matrice.

##### Gram-Schmidt
Proietta la risposta su uno spazio generato da vettori ortogonali tra loro.  
Con due variabili esplicative $$x_1$$ e $$x_2$$ e la variabile risposta $$y$$, la regressione di $$y$$ sul vettore dei residui $$z_{x_2\sim x_1}$$, determinato dalla regressione di $$x_2$$ su $$x_1$$, fornisce i coefficienti di regressione multipla di $$x_2$$. Il vettore $$z_{x_2\sim x_1}$$ è ortogonale al vettore $$x_1$$.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Il coefficiente di correlazione parziale utilizza lo stesso concetto della regressione di $$x_2$$ su $$x_1$$.

### Stima LS con $$n$$ grande
Il prodotto $$X^TX$$ risulta oneroso se si ha un elevato numero di righe.

#### Stima ricorsiva (filtro lineare)
Il metodo consente di invertire solo due matrici $$p \times p$$ per la stima dei beta.  
$$\hat{\beta}_{(j)}=W^{-1}_{(j)}u_{(j)}$$  
Se si ha un numero elevato di variabili diventa oneroso, ma si estende il metodo al fine di attenuare questo problema.  
Per invertire una matrice generica (eg. somma di due matrici) in questo caso si usa la formula di Sherman-Morrison.  
Consente di invertire solo una volta (usando anche la matrice identità come partenza) e poi si aggiornano le stime.  
Formula analoga per la stima della varianza.  

<!--- 
### Esercizi

##### AS, ES. 2.8
Complete the details of the statements at the end of section 2.2.2 by calculating $$s^2$$ and standard errors, using (2.10) or any other method.
Si estenda la procedura precedente per calcolare $$s^2$$ e gli errori standard di $$\hat\beta$$ con un uso della memoria indipendente dalla numerosità $$n$$ dei dati disponibili.

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
