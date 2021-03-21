---
title: "Statistics: Data Mining"
excerpt: "note"
date: 2021-03-07
tags: [statistics, math, theory, university, R]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire`


## Accenni di Algebra
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

## Accenni di Statistica
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Teorema di Gauss Markov  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Proprietà stimatore LS:  
- Non distorto
- Tra i non distorti è quello a minima varianza
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Proprietà stimatore MV (coincide con LS con errori gaussiani)



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

### Stima LS con $$n$$ non troppo grande

#### Fattorizzazione QR
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
$$ $$= Var(\hat{\theta})+Bias(\hat{\theta},\theta)^2 $$  

$$ MSE\left (\hat{y}\right )
= \mathbb{E}\left \{\left ( \hat{y}-f(x') \right ) ^2\right \}
= \mathbb{E}\left \{\left (\hat{y} \pm \mathbb{E}\left \{\hat{y}\right \}+f(x') \right)^2\right \}= \ldots$$  
$$= \mathbb{E}\left \{\left [ \hat{y}-\mathbb{E}\left \{\hat{y}\right \} \right ] ^2\right \} + \left [ \mathbb{E}\left \{\hat{y}\right \}-f(x') \right ] ^2 
$$ $$= Var(\hat{y})+Bias(\hat{y},f(x'))^2 $$  

### Iperparametri
- Grado del polinomio
- Dimensione del sottoinsieme
- Posizione della stepwise
- Parametri di penalizzazione
- Altro

### Stima e verifica
$$f(x)$$ è ignoto e si può calcolare solo la varianza residua  
$$\frac{1}{n}\sum_{i=1}^n\left [ \hat{y}_i - y_i \right ] ^2$$  
La varianza residua _overfitta_ se applicata su tutto il dataset, quindi divido in due parti i dati e uso una parte per la stima e uno per la verifica.  

### Cross Validation
Per identificare gli iper parametri, invece di fare una suddivisione tra stima (training) e verifica (validation), si suddividono i dati in $$k$$ sottoinsiemi, che si stima e si verifica a rotazione, ottenendo $$k$$ stime della funzione di perdita e si sceglie il parametro che la minimizza.  
$$p=\text{arg}\,\min\limits_{p}\,D^*(p)=\text{arg}\,\min\limits_{p}\,\left [ \sum_{i=1}^n \left ( y_i-\hat{y}_i \right )^2 \right ]_p$$

Consente di avere anche una stima approssimativa della variabilità degli stimatori, ad esempio facendone il boxplot perché si ottengono $$k$$ stime per ogni parametro. Non sarebbe possibile nella suddivisione stima-verifica.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Da implementare su R.

In fine, se si vuole ottenere un modello unico dalla CV, nel caso dei modelli parametrici, si può fare una media tra i parametri.

#### Leave-One-Out
$$k=n$$ suddividere il numero di porzioni pari al numero di righe, quindi $$n-1$$ per la stima e $$1$$ riga per la verifica, rotando gli insiemi.  
Computazionalmente oneroso per $$n$$ elevato.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Da implementare su R.

##### CV LOO Sherman-Morrison
Per i stimatori lineari, sfruttando la formula di Sherman-Morrison, da un solo modello completo, si ottiene l'errore di CV Leave-One-Out:  
$$y_i-\hat{y}_{-i}=\frac{y_i-\hat{y}_i}{1-P_{ii}}$$  
quindi l'MSE di previsione di CV risulta  
$$D^*(p)=\frac{1}{n}\sum_{i=1}^n\left [ y_i - \hat{y}_{-i} \right ] ^2 = \frac{1}{n}\sum_{i=1}^n \left ( \frac{y_i-\hat{y}_i}{1-P_{ii}} \right )^2$$  

### Information Criterion
In alternativa, per non suddividere il dataset e contenere l'effetto dell'overfitting della varianza residua, si può penalizzare la log verosimiglianza e cercare il modello con il valore minimo. Si penalizza la log-verosimiglianza per la relazione con la chi-quadro per differenze tra log verosimiglianze di modelli annidati. 
Inoltre, consente di esprimere l'aggiunta di un parametro come l'incremento dei suoi gradi di libertà (cioè il valore medio) alla log verosimiglianza. Quindi si cerca una penalizzazione che sia più grande del suo valore atteso.
- AIC: $$-2\log{p(y;\hat{\theta})}+2p=\frac{\sum_{i=1}^n(y_i-x_i\hat{\beta}_p)^2}{\sigma^2}+2p$$
- Cp: $$\frac{\sum_{i=1}^n(y_i-x_i\hat{\beta}_p)^2}{\sigma^2}-n+2p$$
- AICc, BIC/SIC, HQ 

##### Divergenza di Kullback-Leiber
AIC di Akaike è stato ottenuto sviluppando la divergenza di Kullback-Leiber.  
Cerca la funzione che minimizzi la distanza tra la vera distribuzione e la stima. Si prova che è la stima di massima verosimiglianza $$\hat{\theta}_y$$ il valore che la minimizza.

## Riduzione della dimensionalità
I una regressione multipla, la correlazione tra variabili esplicativa comporta
- aumento varianza dei coefficienti
- interpretazioni rischiose

Tra due variabili altamente correlate, rimuovo quella che contribuisce meno alla spiegazione della risposta.

### Best subset selection
Date $$p$$ variabili esplicative in una regressione lineare multipla
1. stimo gli $$k={p\choose i}$$ modelli con $$i=0,...,p$$ numero di variabili da considerare in ogni combinazione
2. uso un metodo (eg. $$R^2$$) per trovare il miglior modello interno per ogni $$i$$ (parametro di regolazione: dimensione del sottoinsieme)
3. uso altro metodo (eg. CV) per trovare il migliore tra i $$p+1$$ modelli (parametro di regolazione: numero di esplicative)
Il metodo è computazionalmente oneroso.

### Forward Stepwise
Dal modello con intercetta fino al modello più completo.  
Per saggiare il miglioramento si può usare il test F:  
$$F=\frac{\mbox{RSS}\left (\hat{\beta}^{\tiny \mbox{OLD}}\right )-\mbox{RSS}\left (\hat{\beta}^{\tiny \mbox{NEW}}\right )}{\mbox{RSS}\left (\hat{\beta}^{\tiny \mbox{NEW}}\right )/(n-s)}$$

### Backward Stepwise
Dal modello completo al modello con intercetta. Generalmente seleziona un numero più maggiore di variabili rispetto la forward.

### Bidirectional Stepwise
Combinazione delle due precedenti.

### PCA
Analisi delle componenti principali. Effettua una rotazione delle variabili per ottenere nuove variabili ortogonali. Si effettua la scomposizione spettrale della matrice di correlazione (o di varianze e covarianze ma è influenzata dalla scala delle variabili) $$\Sigma$$:  
$$\Sigma \alpha_l=\lambda^2_j \alpha_l$$ con $$\lambda$$ autovalori.  

La PCA minimizza le distanze ortogonali, è una relazione simmetrica tra le variabili, mentre la retta dei minimi quadrati minimizza le distanze verticali in cui la scelta della direzione comporta stime differenti dei parametri.  

La prima componente è la più informativa ma non necessariamente è quella che spiega meglio la target.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Esistono metodi, come la Correlazione Canonica in cui si determinano le componenti anche in funzione della risposta. Altri metodi: Minimi Quadrati Parziali (Partially Square), Independent Component Analysis, Principal Curves, etc.


#### Decomposizione Spettrale
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Per una matrice quadrata (sulla matrice di varianze e covarianze).

#### Decomposizione a valori singolari (SVD)
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Della matrice $$X$$  
$$X=UDV^T$$  


## Metodi di shrinkage
Regolarizzare l'equazione di stima, penalizzando la funzione di ottimizzazione dei minimi quadrati introducendo una distorsione ma riducendo la varianza. Se tutto traslato verso lo 0 l'errore quadratico medio (e assoluto) sarà più basso.  

Funzionano bene anche quando $$p>n$$.  

### Regressione Ridge
$$\min\limits_{\beta}\left ( y-X\beta \right )^T \left ( y-X\beta \right )$$ soggetta al vincolo $$\sum \beta_j^2 \le s$$ (norma in [spazio L2](https://it.wikipedia.org/wiki/Spazio_l2))  
in forma di Lagrange:  
$$\min\limits_{\beta}\left \{ \left ( y-X\beta \right )^T \left ( y-X\beta \right ) + \lambda\beta^T \beta \right \}$$  
nota: $$s\uparrow\Leftrightarrow \lambda \downarrow$$  
Si ottiene quindi:  
$$\hat{\beta}_\lambda=\left (X^TX+\lambda I \right )^{-1} X^T y$$  
nota: se $$\lambda\rightarrow\infty \Rightarrow \hat{\beta}\rightarrow 0$$ e se $$\lambda\rightarrow 0 \Rightarrow \hat{\beta}\rightarrow \hat{\beta}_{LS}$$  
Tipicamente non si penalizza l'intercetta. Il metodo consente di ottenere stime anche con variabili collineari.

#### Interpretazione Bayesiana
Data la verosimiglianza $$y_i\sim\mathcal{N}(\beta_0+x_i^T \beta , \sigma^2)$$, consideriamo che $$\beta_j\sim \mathcal{N}(0,\tau^2),j=1,...,p$$ è una v.a.,  
quindi la distribuzione a priori è  
$$\beta\sim \mathcal{N}(0,\tau^2 I)$$  
e si dimostra che la distribuzione a posteriori è  
$$\left ( y-X\beta \right )^T \left ( y-X\beta \right ) + \lambda\beta^T \beta$$  
la stima ridge è la moda (e media) a posteriori con $$\lambda=\frac{\sigma^2}{\tau^2}$$  
$$\beta \vert y \sim \mathcal{N} \left \{ \left ( X^TX+\frac{\sigma^2}{\tau^2}I \right )^{-1} X^Ty, \sigma^2 \left ( X^TX+\frac{\sigma^2}{\tau^2}I \right )^{-1} \right \}$$  

#### Relazione con PCA
Nella PCA rotiamo le $$X$$, e dopo scegliamo le prime direzioni (le più variabili), per fare la regressione su $$y$$. La ridge si può formulare in modo che prenda le direzioni delle componenti principali (utilizzando la SVD $$X=UDV^T$$).  
$$X\hat{\beta}^{\tiny \mbox{ridge}}=X\left ( X^TX+\lambda I \right )^{-1} X^T y =M_{\lambda}y=\sum_{j=1}^p u_j k_j u_j^T y$$  
con $$k_j=\frac{d_j^2}{d^2_j+\lambda}$$  
$$u_j$$ vettori ortogonali della $$U$$  
$$k_j$$ è la quantità di compressione nelle direzioni principali  
$$d_j^2$$ sono autovalori della matrice delle varianze e covarianze di $$X^TX$$, $$d_j^2$$ sono le varianze delle componenti principali. Anziché usare la regressione sulle componenti principali, in cui solitamente si considerano solo le prime componenti e le altre vengono messe a 0, qui considera tutte le componenti comprimendo quelle meno importanti.  

$$\mbox{df}(\lambda)=\mbox{tr}(M_{\lambda})=\sum_{j=1}^p k_j$$ misura la complessità del modello, è una funzione monotona di $$\lambda$$, al crescere della complessità si raggiungono i minimi quadrati, al decrescere i coefficienti tendono a 0.  
 
### Regressione Lasso
$$\min\limits_{\beta}\left ( y-X\beta \right )^T \left ( y-X\beta \right )$$ soggetta al vincolo $$\sum \vert \beta_j \vert \le s$$  
Non c'è una forma esplicita per risolvere il problema. Programmazione quadratica. Discontinuità della derivata prima causata dai valori assoluti.  

Per $$s$$ piccolo alcuni parametri vengono stimati a 0, quindi è anche un modo per selezionare le variabili.  

La funzione da minimizzare è un paraboloide, il cui centro è la stima di massima verosimiglianza. Nel caso a due variabili, con il Lasso il vincolo è un parallelepipedo a base quadrata, che possiamo visualizzare come quadrato (curve di livello) perché ragioniamo solo con i due coefficienti, e un cerchio nella Ridge. La soluzione con il vincolo è il punto di contatto tra il paraboloide e il vincolo. Nel Lasso, a meno di casi estremi (es 2 variabili in cui il paraboloide è perfettamente nella diagonale), uno dei due coefficienti andrà a 0.  

$$s$$ è da considerare come iperparametro, da scegliere ottimizzando il trade-off varianza distorsione.  

Con variabili esplicative ortogonali, il ridge moltiplica i coefficienti per un valore inferiore ad 1, il lasso li trasla verso lo zero.  
![png](/assets/images/Statistics/DM_Shrinkage1.png)

#### Consistenza del Lasso
La consistenza della stima MV non è garantita se lo spazio dei parametri $$p$$ cresce al crescere delle osservazioni $$n$$. Il Lasso è capace di identificare il modello corretto anche in questa situazione, purché le variabili esplicative non siano troppo correlate con le variabili di disturbo (altrimenti la condizione di irrepresentabilità, o stabilità dell'intorno, viene meno).  

##### Lasso Adattivo
Il Lasso adattivo permette di trovare una soluzione per svincolarsi dalla condizione di irrepresentabilità.  
$$\hat{\beta}_{\tiny \mbox{adp}}(\lambda)=\text{arg}\,\min\limits_{\beta}\,(y-X\beta)^T(y-X\beta)+\lambda \sum_{j=1}^p\frac{\vert \beta_j \vert}{\vert \hat{\beta}_{\tiny{\mbox{iniz}},j} \vert}$$  
Con $$\hat{\beta}_{\tiny{\mbox{iniz}},j}$$ è uno stimatore iniziale come OLS, un suggerimento a quale parametro dare più importante. Procedura a due step.

#### Interpretazione Bayesiana
Come per il Ridge, se consideriamo i beta (a priori) distribuiti secondo una Laplace, si ottiene lo stimatore Lasso (la densità a Posteriori ha come nucleo la forma di Lagrange dello stimatore Lasso).  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Da dimostrare

### Famiglia shrinkage
Il ridge e lasso possono essere casi specifici della seguente generalizzazione  
$$\tilde{\beta}=\text{arg}\,\min\limits_{\beta}\,(y-X\beta)^T(y-X\beta)$$ soggetta al vincolo $$\sum \vert \beta_j \vert ^q \le s$$ con $$q\ge 0$$.  
Se $$q\le 1$$ si ha la selezione delle variabili.  

### Ibridi
- Elastic Net
- Grouped Lasso

### Least Angle Regression
Serve a risolvere i minimi quadrati in un modo diverso ed è utile per stimare il modello Lasso.  
Si inizializza il vettore dei coefficienti pari a 0, iterativamente si incrementano le stime inserendo ad una ad una le variabili più correlate con i residui che si ottengono ad ogni passo, ci si ferma fino a quando si ha correlazione minima.  


#### LARS
Stima del Lasso con LAR
1. Inizia l'algoritmo del LAR
2. Se un coefficiente raggiunge lo 0 si ferma, elimina la variabile e si cerca la migliore direzione 
3. Si ottiene il percorso del lasso

Il LAR ha costo computazionale simile della stima LS con QR, poco più elevato perché quando si incontra lo 0 elimina e rinizia.





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


#### Lezione 7
Es1: con distribuz normale e mu unico parametro sconosciuto, dimostrare che mu è non distorto. se lo stimatore è non distorto, anche se non conosco mu, dimostro che lo stimatore è centrato sulla verità. la media della verità la si ottiene.
Es2: come ottenere sd delle stime distorte?


--->



<!--- 
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

Q: nella regressione ridge, può accadere che alcuni coefficienti cambiano anche il segno al variare dei lambda? questo non fa perdere la credibilità interpretativa dei coefficienti?
R: paradossalmente acquisisce più senso, anche se cambia il segno del coefficiente è perché stiamo modificando la relazione con le variabili correlate


Q: nella regressione ridge, il livello di variabilità dei beta al variare dei lambda ci da qualche informazione in più? la bassa variabilità potrebbe essere vicina al concetto di significatività statistica?
R:no perché se è lontano da 0 e non varia, non per questo è da considerare come robusto



https://www.codecogs.com/latex/eqneditor.php


--->



## R

##### Lab 1
<iframe frameborder=0 style="width: 100%; height: 250px;" scrolling="no" seamless="seamless" srcdoc='<html><body><style type="text/css">.gist .gist-data { height: 200px; }</style><script src="https://gist.github.com/AlbGri/26abf77e0a6d65e5c0a4d1a36afcdceb.js"></script></body></html>'></iframe> 



## Utili

### Risorse
- [Data analysis and data mining](http://azzalini.stat.unipd.it/Book-DM/index.html)
- [The Elements of Statistical Learing](https://web.stanford.edu/~hastie/ElemStatLearn/printings/ESLII_print12_toc.pdf)




<!---
https://gist.github.com/AlbGri

iframe codice stackoverflow:

<iframe frameborder=0 style="min-width: 200px; width: 60%; height: 460px;" scrolling="no" seamless="seamless" srcdoc='<html><body><style type="text/css">.gist .gist-data { height: 400px; }</style><script src="https://gist.github.com/sundbry/55bb902b66a39c0ff83629d9a8015ca4.js"></script></body></html>'></iframe> 

note:
- seamless è inutile
- height dentro gist è la dimensione del riquadro interno
- da trovare: rimuovere la parte finale con hosted with <3 (si potrebbe far sparire giocando con le due height)
- da trovare: word wrap
--->

