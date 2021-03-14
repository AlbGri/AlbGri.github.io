---
title: "Statistics: Data Mining"
excerpt: "note"
date: 2021-03-07
tags: [statistics, math, theory, university, R]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire`


## Proprietà e teoremi utili
- $$(A^T)^T$$ $$=A$$
- $$(A^{-1})^T$$ $$=(A^T)^{-1}$$
    1. $$A^{-1}A$$ $$=I$$
    2. $$(A^{-1}A)^T=I^T$$ $$=I$$
    3. dato che $$(AB)^T=B^TA^T$$
    4. $$A^T(A^{-1})^T$$ $$=I$$
    5. dato che $$A$$ è invertibile allora anche $$A^T$$ lo è
    6. $$(A^T)^{-1}A^T(A^{-1})^T$$ $$=(A^T)^{-1}I$$
    7. $$(A^{-1})^T$$ $$=(A^T)^{-1}$$
- $$[(X^TX)^{-1}X^T]^T=X[(X^TX)^{-1}]^T=X[(X^TX)^T]^{-1}=X[(X)^T(X^T)^T]^{-1}$$ $$=X(X^TX)^{-1}$$  
- Proprietà dissociativa dell'addizione $$10=4+6=...$$
- Se $$Q$$ ortogonale, allora $$Q^TQ=I$$
- $$(AB)^{-1}$$ $$=A^{-1}B^{-1}$$

## Modelli Lineari e Minimi Quadrati (LS)

Minimizzazione di  
$$D(\beta)=\sum_{i=1}^n\big\{y_i-f(x_i; \beta)\big\}^2=\left \| y-X\beta \right \|^2=\sum_{i=1}^{n}(y_i-\hat{y})^2$$ $$=y^T(I_n-P)y$$

### Modello lineare multidimensionale
a più $$X$$.  
Sia $$y=X\beta+\epsilon$$ con $$\mathbb{E}(\epsilon)=0$$.  
Tramite OLS (proiezione ortogonale di $$y$$ su $$\mathcal{C}(X)$$):  
$$\hat{y}=X\hat{\beta}=Py$$  
con $$\hat{\beta}=(X^T X)^{-1}X^T y\equiv\beta+(X^T X)^{-1}X^T \epsilon$$  
Inoltre,  
$$\hat{\epsilon}=y-\hat{y}$$ $$=y-X\hat{\beta}$$  
$$\left \| \hat{\epsilon} \right \|^2$$ $$=y^Ty-y^TX\hat{\beta}$$  

Valore atteso dello stimatore  
$$\mathbb{E}[\hat{\beta}]=\mathbb{E}[(X^TX)^{-1}X^T(X\beta+\epsilon)]=\beta$$
Varianza dello stimatore  
$$\sigma^2(\hat{\beta})
=\mathbb{E}\big[ (\hat{\beta}-\mathbb{E}[\hat{\beta}])^2 \big]=\sigma^2(X^TX)^{-1}$$  
Stima non distorta della varianza dello stimatore  
$$\widehat{\mbox{var}}(\hat{\beta})=\frac{D(\hat{\beta})}{n-p}(X^TX)^{-1}=s^2(X^TX)^{-1}$$


Nota: se si applica OLS con le esplicative trasformate con il logaritmo si mantiene lineare nei parametri, ma se il logaritmo si applica alla risposta non è più lineare nei parametri. La stima non è OLS e non è la migliore in termini di minimizzazione della devianza, ma mantiene la sua validità. Anche l'$$R^2$$ non risulterebbe confrontabile.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Ricalcolare l'$$R^2$$ retrotrasformando la previsione per il log Y, ovvero retrotrasformarla con l'esponenziale per ottenere Y.

#### Projection Matrix
$$P$$ è la matrice cappello o di proiezione $$P=X(X^TX)^{-1}X^T$$.

##### Proprietà della projection matrix
1. Matrice $$n\times n$$
2. $$P^T$$ $$=P$$  
3. $$PP$$ $$=P$$  
4. $$\mbox{tr}(P)=\mbox{rk}(P)$$ $$=p$$


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
Data una matrice di dati con $$j$$ righe, si voglio stimare i coefficienti beta con i minimi quadrati.  
Sia $$_{(j)}$$ il riferimento di una matrice alle prime $$j$$ su $$n$$ osservazioni. La matrice $$(X^TX)_{(j)}$$ può essere vista come la stessa matrice con $$_{(j-1)}$$ righe più l'ultima. Analogamente la stima dei coefficienti beta risulta:  
$$\hat{\beta}_{(j)}=W^{-1}_{(j)}u_{(j)}$$  
con $$W=X^TX=\sum_{i=1}^n \tilde{x}_i \tilde{x}_i^T$$ e $$u=X^Ty=\sum_{i=1}^n \tilde{x}_i y_i$$  
Il metodo consente di invertire solo due matrici $$p \times p$$ per la stima dei beta ad ogni $$j$$, evitando di salvare in memoria la matrice $$X$$.  
Se si ha un numero elevato di variabili diventa oneroso, ma si estende il metodo al fine di attenuare questo problema.  

#### Stima ricorsiva (con filtro lineare)
Il seguente metodo, consente di invertire una sola matrice $$p\times p$$ all'inizio (anche la matrice identità) e poi iterativamente si aggiornano le stime.  
Per invertire una matrice generica (eg. somma di due matrici) si può usare la formula di Sherman-Morrison.  
$$(A+bd^T)^{-1}=A^{-1}-\frac{1}{1+d^TA^{-1}b}A^{-1}bd^TA^{-1}$$  
con $$d$$ vettore colonna, $$d^T$$ vettore riga.  
$$\hat{\beta}_{(n+1)}=\hat{\beta}_{(n)}+k_n (y_{n+1}-\tilde{x}^T_{n+1}\hat{\beta}_{(n)})=\hat{\beta}_{(n)}+k_n e_{n+1}$$  
con $$e_{n+1}$$ l'errore di $$y_{n+1}$$ con la stima di $$\beta$$ sulle prime $$n$$ osservazioni.  
La nuova stima è ottenuta come somma della precedente stima più l'errore di previsione pesato con il guadagno del filtro.  
La stima (ricorsiva) della devianza dello stimatore dei minimi quadrati ricorsivo al passo $$_{(n+1)}$$ risulta:  
$$D_{n+1}(\hat{\beta}_{(n+1)})=D_{n}(\hat{\beta}_{(n)})+he^2_{n+1}$$  
si determinano facilmente $$s^2_{n+1}$$ e lo standard error di $$\hat{\beta}_{(n+1)}$$ 

## Trade-off Varianza Distorsione

Errore Quadratico Medio  
$$\mathbb{E}\big\{[\hat{y}-f(x')]^2\big\}$$  
$$\hat{y}$$ l'elemento casuale perché dipende dall $$y$$  
Si cerca il valore degli iperparametri (es. grado polinomio) che minimizza l'MSE.  

$$ MSE\left (\hat{\theta}\right )
= \mathbb{E}\left \{\left (\hat{\theta}-\theta \right)^2\right \}
= \mathbb{E}\left \{\left (\hat{\theta} \pm \mathbb{E}\left \{\hat{\theta}\right \}+\theta \right)^2\right \}= \ldots$$  
$$= \mathbb{E}\left \{\left [ \hat{\theta}-\mathbb{E}\left \{\hat{\theta}\right \} \right ] ^2\right \} + \left [\mathbb{E}\left \{\hat{\theta}\right \}-\theta \right ]^2 
= Var(\hat{\theta})+Bias(\hat{\theta},\theta)^2 $$



<!--- 
## Esercizi

##### AS, ES. 2.8
Complete the details of the statements at the end of section 2.2.2 by calculating $$s^2$$ and standard errors, using (2.10) or any other method.
Si estenda la procedura precedente per calcolare $$s^2$$ e gli errori standard di $$\hat\beta$$ con un uso della memoria indipendente dalla numerosità $$n$$ dei dati disponibili.

##### AS, ES. 2.9 
Check the correctness of the Sherman-Morrison formula (A.2).
Verificare che la formula di Sherman-Morrison fornisce effettivamente l'inversa di $$(A+bd^T)$$.

##### AS, ES. 2.10
Check the correctness of the formulas provided by recursive updating of the least squares estimates.
Verificare la correttezza delle formule fornite per l'aggiornamento ricorsivo delle stime dei minimi quadrati.

##### AS, ES. 2.11
Prove (2.24).
Si completi l'algoritmo dei minimi quadrati ricorsivi sviluppando le formule per l'aggiornamento iterativo di $$\hat{\sigma}^2$$ appena viste. Si usi il fatto che $$\left \| \hat{\epsilon} \right \|^2=y^Ty-y^TX\hat{\beta}$$

##### AS, ES. 2.12
What is the difference between the confidence interval of the value of the function and the prediction interval, both relative to the next observation?
Qual è la differenza tra intervallo di confidenza del valore della funzione e quello di previsione, ambedue relativi alla prossima osservazione?

### Domande
Q: Es 2.8 suggerimenti per continuare la formula per s^2 (vedi appunti). 
R: da usare la formula sigma^2(X^TX)^-1

Q: (pagina 33) Q_(n+1)(beta_(n+1)) quel Q perché non ha usato la D di deviance?
R: è identica

Q: (pagina 33) la formula dello standard error dei beta iterati n+1 sarebbe (Q_{n+1}(beta_{(n+1)})/(n-p) V_{(n+1)})^-(1/2)
R: non devo fare la radice quadrata, ma prendere gli elementi diagonale e farne la radice

Q: C'è un modo migliore di risolvere questa semplificazione? (screen)
R: in attesa

Q: Es 2.9 verificare anche su R?
R: da verificare si intende provare che I=I

Q: Es 2.10 Cosa si intende? Che la stima si mantiene non distorta?
R: da verificare si intende provare che I=I

Q: Es 2-11 devo capire il 2.8
R: R: da verificare si intende provare che I=I

Q: Es 2-12 che intende per valore della funzione e di previsione? la differenza tra il vero valore e quello stimato?
R: sul modello lineare l'errore di previsione e le y, la differenza è +1 perché ho la variabile casuale in più di quella del futuro, esercizio semplice in tutti i libri di statistica 1 // da capire


https://www.codecogs.com/latex/eqneditor.php


--->



## R Esercitazioni



<button class="collapsible" id="esdm001">Esercitazione 1: confronti tra stimatori della media</button>
<div class="content" id="esdm001R" markdown="1">

	```R
	asd
    ```
</div>


&nbsp;
&nbsp;




<button class="collapsible" id="esdm003">Esercitazione 3: ()</button>
<div class="content" id="esdm003R" markdown="1">

	```R
	dddddddddddd
	```	
</div>

&nbsp;
&nbsp;


<button class="collapsible" id="es001">Esempio 1: LT e KM (0)</button>
<div class="content" id="es001data" markdown="1">

	```sas
	/*******************************************************
	Obiettivo: 
	analizzare andamento uscita mercato del lavoro con LT e KM
	*******************************************************/
	* genero il df;
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

&nbsp;
&nbsp;

<button class="collapsible" id="es004">Esempio 4: LT e KM (0)</button>
<div class="content" id="es004data" markdown="1">

	```sas
	yrdyasaaaaaaaaaaa
	```
</div>


&nbsp;
&nbsp;



<button class="collapsible" id="es005">Esempio 5: LT e KM (0)</button>
<div class="content" id="es005data" markdown="1">

	```R
	yrdyfdsfd
	```
</div>


&nbsp;
&nbsp;




## Utili

### Risorse
- [Data analysis and data mining](http://azzalini.stat.unipd.it/Book-DM/index.html)
- [The Elements of Statistical Learing](https://web.stanford.edu/~hastie/ElemStatLearn/printings/ESLII_print12_toc.pdf)


## test

<script src="https://gist-it.appspot.com/github/robertkrimen/gist-it-example/blob/master/example.js"></script>

a


<script src="http://gist-it.appspot.com/http://github.com/$file"></script>


b



<script src="http://gist-it.appspot.com/https://github.com/dotnet/corefx/blob/master/src/System.ObjectModel/src/System/Windows/Input/ICommand.cs"></script>


c



<script src="https://emgithub.com/embed.js?target=https%3A%2F%2Fgithub.com%2Fpytorch%2Fpytorch%2Fblob%2Fmaster%2Ftorch%2Fnn%2Fcpp.py&style=github&showBorder=on&showLineNumbers=on&showFileMeta=on"></script>



d


<script src="https://gist-it.appspot.com/AlbGri/AlbGri.github.io/blob/master/assets/files/Statistics/data-mining-lab1.R"></script>


e


<script src="https://gist-it.appspot.com/AlbGri/AlbGri.github.io/blob/master/assets/files/Statistics/data-mining-lab1.R" slice=0:10 footer=minimal></script>

f


<script src="https://gist-it.appspot.com/AlbGri/AlbGri.github.io/blob/master/assets/files/Statistics/data-mining-lab1.R", slice=0:10, footer=minimal></script>


g


<script src="https://gist-it.appspot.com/AlbGri/AlbGri.github.io/blob/master/assets/files/Statistics/data-mining-lab1.R&slice=0:10&footer=minimal"></script>




...
