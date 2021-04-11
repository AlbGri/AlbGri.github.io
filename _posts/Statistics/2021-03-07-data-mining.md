---
title: "Statistics: Data Mining"
excerpt: "note"
date: 2021-03-07
tags: [statistics, math, theory, university, R]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire.`


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
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Proprietà stimatore LS (non distorto, tra i non distorti è quello a minima varianza)  
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
= \ldots$$  
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

Metodo parsimonioso per scegliere il miglior parametro di regolazione: costurisco il grafico dell'andamento dell'iperparametro vs errore di convalida incrociata, poi identifico l'iperparametro che minimizza, aggiungo una volta lo standard error, traccio una linea orizzontale da quel punto e scelgo come iperparametro quello corrispondente al primo che si ritrova sotto la linea (metodo 1 SE).  

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
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Da costruire su R un metodo che restituisca i coefficienti delle variabili usando la regressione sulle componenti principali scelte. Introducendo anche la CV per la scelta del numero di componenti.

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
la stima ridge è la [moda](https://it.wikipedia.org/wiki/Stima_del_massimo_a_posteriori) (e media) a posteriori con $$\lambda=\frac{\sigma^2}{\tau^2}$$  
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
in forma di Lagrange:  
$$\min\limits_{\beta}\left ( y-X\beta \right )^T \left ( y-X\beta \right )+\lambda 1^T \vert \beta \vert$$  
Non c'è una forma esplicita per risolvere il problema, perché il valore assoluto comporta la discontinuità della derivata prima. Bisogna usare metodi di programmazione quadratica.  

Per $$s$$ piccolo alcuni parametri vengono stimati a 0, quindi è anche un modo per selezionare le variabili. $$s$$, parametro di compressione, è da considerare come iperparametro, da scegliere ottimizzando il trade-off varianza distorsione.  

La funzione da minimizzare è un paraboloide, il cui centro è la stima di massima verosimiglianza. Nel caso a due variabili, con il Lasso il vincolo è un parallelepipedo a base quadrata, che possiamo visualizzare come quadrato (curve di livello) perché ragioniamo solo con i due coefficienti, e un cerchio nella Ridge. La soluzione con il vincolo è il punto di contatto tra il paraboloide e il vincolo. Nel Lasso, a meno di casi estremi (es 2 variabili in cui il paraboloide è perfettamente nella diagonale), uno dei due coefficienti andrà a 0.  

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

#### Pathwise cordinate descent
Con il metodo di Gauss-Newton si identifica la direzione più ripida per raggiungere il minimo. Dato che la funzione può non essere derivabile ovunque (la penalizzazione ha il modulo), invece di scendere lungo la direzione più veloce, si scende lungo le coordinate, cioè i parametri (gli assi). Si ottimizza rispetto un parametro, poi si scende verso un altro etc.  
Nel Lasso il pathwise funziona perché trovare il minimo parametro per parametro si riesce velocemente.  
Il minimo, per il modello Lasso, lo si ottiene tramite la stima della funzione soft-threshold:  
forma estesa  
$$\tilde{\beta} = \begin{cases} 
\hat{\beta}+\lambda & \mbox{se } \hat{\beta}<-\lambda \\
0 & \mbox{se } -\lambda \le \hat{\beta} \le \lambda \\
\hat{\beta}-\lambda & \mbox{se } \hat{\beta} > \lambda
\end{cases}$$  
forma compatta  
$$\tilde{\beta}=\mbox{sign}(\hat{\beta})(\vert \hat{\beta} \vert - \lambda)_{+}$$  
Per la generalizzazione con $$p$$ variabili, si iterano le variabili, si calcolano i residui e si applica la soft-threshold. Può essere visto come un problema di lasso univariato dove la variabile risposta sono i residui parziali:  
$$y_i-\tilde{y}_i^{(j)}=y_i-\sum_{k\ne j}x_{ik}\tilde{\beta}_k (\lambda)$$  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Da approfondire


## Distorsione da selezione

Sia $$\overline{X}_n-\overline{X}_N$$ la differenza tra la media ottenuta nel campione con $$n$$ osservazioni e la media dell'intera popolazione d'interesse.  
Si può esprimere come  
$$\overline{X}_n-\overline{X}_N=\sqrt{\frac{1-f}{f}}\times \sigma_X \times \rho_{R,X}$$  
- $$R$$ vettore di indicatrici della presenza di ciascuna unità della popolazione nel campione.  
- $$f$$ $$=\frac{n}{N}$$  
- difficoltà del problema $$\sigma_X$$: variabilità di $$X$$, più è elavata e più è difficile da stimare $$\overline{X}_N$$ in modo accurato  
- qualità dei dati $$\rho_{R,X}$$: con un buon campionamento probabilistico, quindi senza distorsione da selezione, la probabilità di osservare uno specifico valore di $$X$$ non dipende dal suo valore e si avrà mediamente $$\rho_{R,X}\approx 0$$.  

Se si ha distorsione da selezione:  
- $$Z_{n,N}=\frac{\overline{X}_n-\overline{X}_N}{\sqrt{\mbox{var}_{CCS}\overline{X}_n}}$$ $$=\sqrt{N-1}\cdot \rho_{R,X}$$
- Se si vuole mantenere l'errore legato alla qualità dei dati di un ordine di grandezza confrontabile con le altre componenti dell'errore complessivo $$\rho_{R,X}$$ deve essere inferiore a $$N^{1/2}$$


## Metodi non parametrici
Minimizzare funzione di perdita quadrata, mediante i minimi quadrati.  
Il valore che minimizza è la media condizionata delle $$y$$ condizionate alle $$X$$, il valore atteso condizionato cioè la funzione di regressione.  
$$f(x_0)=\mathbb{E}\left \{ y \vert x=x_0 \right \}$$  
Non conoscendo la vera distribuzione, se ne fa la media delle $$y$$ condizionate alle $$X=x_0$$.  
$$f(x_0)=\mbox{Media}(y\vert x=x_0)$$

### k-Nearest-Neighbor regression
Si stima $$f(x_0)$$ attraverso la media aritmetica delle $$y_i$$ le cui $$x_i$$ sono in una finestra di $$x_0$$. Si determina $$\hat{f}(x_0)$$ con $$k$$ numero di vicini. 

### Regressione Lineare Locale
Come il k-NN ma non effettua una media aritmetica ma una regressione lineare.  
Sul punto generico $$x_0$$ espando con Taylor:  
$$f(x)=f(x_0)+f'(x_0)(x-x_0)+\mbox{resto}$$  
Stimo con il metodo dei minimi quadrati pesati mediante la distanza tra $$x_i$$ e $$x_0$$:  
$$\hat{\alpha},\hat{\beta}=\text{arg}\,\min\limits_{\alpha , \beta} \sum_{i=1}^n \left \{ y_i -\alpha - \beta (x_i - x_0)\right \} ^2 \omega (x_i-x_0; h)$$  
- $$h$$ ampiezza di banda o parametro di lisciamento
- $$\omega (\cdot ;h)$$ densità simmetrica attorno a $$0$$, detta nucleo

Quindi si ottiene, stima esplicita e lineare nelle $$y_i$$:  
$$\hat{f}(x)=s_h^T y=s_{1h}y_i+ \cdots +s_{nh}y_{n}$$  

$$\hat{f}(x)$$ è distorto e il suo valore atteso non decresce all'aumentare di $$n$$. 

Per il caso multidimensionale la stima dei coefficienti sarà data da  
$$(X^T WX)^{-1} X^T Wy$$  
con matrice $$X_{(n\times p+1)}=\left \{1, (x_{1i}-x_{01}), (x_{2i}-x_{02}), (...), (x_{pi}-x_{0p})\right \}$$ e $$W_{(n\times n)}$$ matrice di pesi.

#### Scelta del nucleo
La scelta del nucleo è meno importande dell'ampiezza di banda.  
Posto  
$$\omega(t;h)=\frac{1}{h} \omega_0 \left ( \frac{t}{h} \right )$$ con $$t=\vert x-x_0 \vert$$  
alcune scelte possibili del nucleo:  
- normale $$\omega_0 \sim\mathcal{N}(0,h^2)$$, dominio $$\mathbb{R}$$
- biquadratico $$(1-t^2)^2$$ se $$\vert t \vert < 1$$ altrimenti $$0$$, dominio $$(-1,1)$$
- tricubico $$(1-\vert t \vert ^3)^3$$ se $$\vert t \vert < 1$$ altrimenti $$0$$, dominio $$(-1,1)$$
- rettangolare, dominio $$(-1,1)$$
- epanechnikov, dominio $$(-1,1)$$

Il nucleo a supporto limitato riduce il costo computazionale.

#### Scelta del parametro di lisciamento
$$\mathbb{E}\left \{ \hat{f}(x) \right \}$$ $$\approx f(x) + \frac{h^2}{2}\sigma^2_{\omega} f''(x)$$  
$$\mbox{var}\left \{ \hat{f}(x) \right \}$$ $$\approx \frac{\sigma^2}{nh} \frac{\alpha(\omega)}{g(x)}$$  
Per un $$h$$ piccolo la distorsione diventa nulla, ma la varianza esplode.  
Si sceglie $$h$$ che minimizza l'errore quadratico medio. Analiticamente si può esplicitare $$h$$ ottimo ma questo dipende da $$f''(x)$$ che a sua volta dipende da $$h$$.  
L'MSE tende a $$0$$ più lentamente $$O(n^{-4/5})$$ dello stimatore MV $$O(n^{-1})$$, la convergenza al valore vero è più lenta senza assunzioni.

#### LOESS
La scelta di $$h$$ può essere fissa, oppure variabile in funzione della rarefazione dei punti. Determino quindi l'ampiezza di banda affinché raggiunga un numero o una percentuale prefissata di punti. Inoltre, invece di minimizzare la funzione di perdita quadratica, si minimizza l'assoluta che genera una stima più robusta agli outliers.

### Curse of dimensionality
Per tutti i modelli non parametrici, al crescere della dimensione $$p$$ i punti sono sempre più rarefatti.  
Per mantenere costante l'errore quadratico medio (MSE) al crescere di $$p$$ la numerosità campionaria deve crescere esponenzialmente.  
Le assunzioni dei modelli lineari consentono di limitare il problema, quindi si cercono assunzioni non stringenti per gestire questa “maledizione''.

$$\mbox{MSE}\approx \frac{c}{n^{4/(4+d)}}$$ con $$c>0$$.  
Se si vuole l'MSE uguale a $$\delta$$ si impone $$\mbox{MSE}=\delta$$ e si risolve per $$n\Rightarrow n\propto \left ( \frac{c}{\delta}\right ) ^{d/4}$$, si nota che l'MSE cresce esponenzialmente per la dimensionalità $$d$$.

#### Distribuzione verso la frontiera
Dati $$n$$ punti estratti una distribuzione uniforme $$p$$-variata, $$x\sim U^p(0,1)$$, si ha che la distanza mediana dall'origine al punto più vicino, $$r(p,n)=\left ( 1-0.5^{\frac{1}{n}} \right )^{\frac{1}{p}}$$, cresce all'aumentare della dimensione, pertanto la maggior parte dei punti è più vicina al bordo dello spazio campionario che ad ogni altro punto.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) La previsione è molto più difficile vicino ai bordi (estrapolazione contro interpolazione).  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) La maggior parte dei punti è vicina all'involucro convesso del campione..  
L'intorno (ipercubo) contenente una frazione $$d$$ di punti ha lati di lunghezze $$e_p(d)=d^{\frac{1}{p}}$$. $$e_p(d)$$ esprime la percentuale di copertura del campo di variazione di ciascuna variabile esplicativa che si dovrebbe avere per ottenere una media 'locale' con $$p$$ dimensioni e $$d$$ percentuale di utilizzo dei dati.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Così gli 'intorni' non sono più locali.  


### Spline di interpolazione
Per interpolare esattamente $$K$$ punti $$(\xi_k,y_k)$$ per $$k=1,...,K$$ detti nodi.  
Interpolare funzioni lisce come polinomi, imponendo la continuità (di grado $$d-1$$) ai nodi.  
Si richiede continuità della derivata prima e della seconda  
$$f(\xi_k)=y_k$$ per $$k=1,...,K$$  
$$f(\xi_k^{-})=f(\xi_k^{+}), \quad f'(\xi_k^{-})=f'(\xi_k^{+}), \quad f''(\xi_k^{-})=f''(\xi_k^{+}), \quad$$ per $$k=2,...,K-1$$.  
Per $$d=3$$ , $$K$$ nodi comportano:
- $$4(K-1)$$ parametri
- $$K$$ vincoli per interpolare i punti
- $$3(K-2)$$ vincoli di continuità
- se $$f''(\xi_1)=f''(\xi_K)=0$$ splines cubiche naturali  

Quindi le spline, in condizioni di continuità sono funzioni polinomiali a tratti.  
Una funzione di tipo splines si può scrivere come combinazione lineare di opportuni funzioni di base (o base di funzioni):  
$$f(x)=\sum_{j=1}^{K+4}h_j(x)\hat{\theta}_j$$  

Qualsiasi polinomiale a tratti con vincolo di continuità può essere riscritta come combinazione lineare di funzione di base.  

### Splines di regressione (parametrica)
Per interpolare non esattamente $$n$$ punti, si divide l'asse $$x$$ in $$K$$ nodi e si individua una curva di tipo 'spline cubico' che li interpoli adeguatamente. Con $$K$$ nodi, la base di funzioni è composta da $$K+4$$ funzioni $$h_j(x)$$. La stima risulta:  
$$\hat{f}(x)=\sum_{j=1}^{K+4}h_j(x)\hat{\theta}_j$$ per opportuni $$\theta_j$$ si minimizza la devianza residua e si ottiene una spline di regressione.  

Si stima una funzione parametrica con molti parametri, le splines le pensiamo come combinazione lineare di funzioni di base. Si possono pensare altre forme di funzione di base, come serie di fourier, seni e coseni, o le Wavelet.

#### Multidimensionale
Generalizzazione delle splines di regressione a più dimensione.  
Si ha una funzione di base per ogni $$x$$, che si andranno a combinare mediante il loro prodotto tensoriale.  
Nel caso bidimensionale $$x=(x_1,x_2)^T\in \mathbb{R}$$ si hanno le seguenti basi di funzioni  
$$h_{1k}(x_1)$$, con $$k=1,...,K_1$$ relativa alla $$x_1$$,  
$$h_{2k}(x_2)$$, con $$k=1,...,K_2$$ relativa alla $$x_2$$  
la base prodotto tensoriale risulta  
$$g_{jk}(x)=h_{1j}(x_1)h_{2k}(x_2)$$ con $$j=1,...,K_1$$ e $$k=1,...,K_2$$  
si può usare per rappresentare la funzione bidimensionale  
$$g(x)=\sum_{j=1}^{K_1} \sum_{k=1}^{K_2} \theta_{jk}g_{jk}(x)$$  
la stima dei $$\theta_{jk}$$ viene effettuata attraverso i minimi quadrati.  

Una polinomiale a tratti in $$\mathbb{R}^2$$ è difficile, quindi costruiamo delle basi per costruire una funzione che sia combinazione lineare di funzioni di base.  

Si rischiano di ottenere un numero molto elevato di funzioni (4+1 per ogni nodo, e moltiplicarle per 4+1 per ogni nodo per l'altro asse), quindi si considerano le funzioni di base lineari a tratti e non cubiche. Il prodotto tensoriale di base lineari a tratti è comoda perché è nulla tranne in piccole porzioni.  

Il livello di complessità è dato dal numero di nodi ($$K_1, K_2$$).  

Le funzioni hanno anche le interazioni, è difficile distinguere l'effetto di ogni variabile.

### Smoothing splines
Dato il criterio dei minimi quadrati penalizzati (regressioni Ridge, LASSO):  
$$D(f,\lambda)=\sum_{i=1}^n [y_i-f(x_i)]^2+\lambda \int_{-\infty}^{\infty}\left \{ f''(t) \right \}^2 dt$$  
con $$\lambda>0$$ parametro di lisciamento moltiplicato per il grado di irregolarità della curva.  
La $$f$$ che minimizza la funzione di perdita risulta (una spline):  
$$f(x)=\sum_{j=1}^{n_0} N_j(x)\theta_j=N\theta$$  
con $$n_0$$ numero di $$x_i$$ distinti e $$N_j(x)$$ basi delle spline naturali. $$N$$ matrice in cui la $$j-$$ma colonna contiene i valori di $$N_j$$ in corrispondenza agli $$n_0$$ valori distinti di $$x_i$$.  
Il problema si può riscrivere con  
$$D(f,\lambda)=(y-N\theta)^T (y-N\theta)+\lambda \theta^T \Omega \theta$$  
con $$\Omega$$ matrice il cui generico elemento è $$\int N_j''(t)N_k''(t)dt$$  
Il $$\theta$$ che minimizza la funzione di perdita risulta:  
$$\hat{\theta}=(N^TN+\lambda\Omega)^{-1}N^Ty$$  
sostituendo in $$f(x)$$ si ottiene $$\hat{y}=S_\lambda y$$ quindi è un lisciatore lineare.  
Si parla dunque di 'smoothing splines' o spline di lisciamento.  

Si tratta di una tecnica che usa le splines, ma è uno strumento diverso dalle splines di regressione.

#### Thin-plate splines
Un modo di generalizzare le smoothing splines a più dimensioni si ottiene sostituendo $$f''$$ della funzione di perdita con il laplaciano (somma di tutti degli elementi dell'hessiano al quadrato).  
La soluzione di ottimo risulta (non è una spline ma qualcosa di simile):  
$$f(x)=\hat{\beta}_0+\hat{\beta}^T x+\sum_{j=1}^n \hat{\alpha}_j h_j(x)$$  
dove $$h_j(x)=\eta\left (\vert \vert x-x_j \vert \vert \right )$$ e $$\eta (z)=z^2 \log{z}$$  
e $$\hat{\alpha}_j$$, $$\hat{\beta}_0$$ e $$\hat{\beta}$$ determinati sostituendo la $$f(x)$$ nell'espressione dei minimi quadrati penalizzati e minimizzando.  

Sono stime non parametriche, usa i dati vicini più dei dati lontani, quindi l'operazione di estrapolazione è pericolosa, perché non si ipotizza alcuna relazione tra le $$x$$ e la $$y$$.  

Il livello di complessità è dato da $$\lambda$$.


### Gradi di libertà equivalenti
Data la teoria dei modelli lineari  
$$\hat{y}=Py,\qquad \hat{\epsilon}=(I-P)y$$  
con l'ipotesi che $$P=X(X^TX)^{-1}X^T$$ matrice simmetrica idempotente di rango $$p$$ e con $$\mbox{rank}(P)=\mbox{tr}(P)=p$$  
sappiamo che $$\mathbb{E}(\vert\vert\hat{\epsilon}\vert\vert ^2)=\sigma^2 (n-p)$$ e  
con l'ipotesi di normalità:  
$$\vert\vert\hat{\epsilon}\vert\vert ^2\sim\sigma^2\mathcal{X}^2_{n-p}, \qquad \vert\vert\hat{y}\vert\vert ^2=\hat{y}^T\hat{y}\sim\sigma^2\mathcal{X}^2_p(\delta)$$  
e $$\delta$$ parametro di non centralità.  
Si ricorda che:  
$$\vert\vert\hat{y}\vert\vert ^2$$ devianza spiegata, variabilità della regressione  
$$n-p$$ gradi di libertà dei residui  
$$p$$ gradi di libertà della regressione  
$$\vert\vert y \vert\vert ^2=\vert\vert\hat{\epsilon}\vert\vert ^2+\vert\vert\hat{y}\vert\vert ^2$$  
Inoltre la devianza spiegata si scompone in pezzi che dipendono da ciascuna variabile più una parte residua (ANOVA).  

Fissato il parametro di regolazione, tutti i metodi visti possono essere espressi come stimatori lineari:  
$$\hat{y}=S_h y$$ con $$S_h$$ matrice $$n\times n$$  
e $$\hat{\sigma}=(I-S_h)y$$  
Se si assume che l'errore $$\epsilon$$ abbia distribuzione normale, $$\vert\vert\hat{\epsilon}\vert\vert ^2$$ non risulta più $$\mathcal{X}^2$$, ma empiricamente si assomiglia  
$$\vert\vert\hat{\epsilon}\vert\vert ^2 \overset{\mbox{approx}}{\sim} \sigma^2 \mathcal{X}^2_{?}\qquad \vert\vert\hat{y}\vert\vert ^2 \overset{\mbox{approx}}{\sim} \sigma^2 \mathcal{X}^2_{??}(\delta)$$  

Sia  
$$Q=\sum_i \hat{\epsilon}^2_i=\vert\vert\hat{\epsilon}\vert\vert ^2=\hat{\epsilon}^T \hat{\epsilon}=y^T (I_n-S)^T(I_n-S)y$$  
Poiché i gradi di libertà di una $$\mathcal{X}^2$$ corrispondono al valore atteso, si determina il valore atteso di $$Q$$:  
$$\mathbb{E}(Q)\overset{*}{=}\mu^T(I_n-S)^T(I_n-S)\mu+\sigma^2 \mbox{tr}(I_n-S)^T(I_n-S)$$

\* sfruttando la seguente proprietà di una forma quadratica:  
$$\mathbb{E}\left \{ X^T AX\right \}=\mu^T A\mu+\mbox{tr}(AV)$$ con $$\mu=\mathbb{E}(X)$$ e $$V=\mbox{var}(X)$$

Utilizzando le approssimazioni  
- $$(I_n-S)\mu$$ $$\approx 0$$  
- $$(I_n-S)^T(I_n-S)\approx (I_n-S)$$ cioè idempotente

si ottiene che  
$$\mathbb{E}(Q)\approx \sigma^2\{n-\mbox{tr}(S)\}$$  
Quindi  
$$\{n-\mbox{tr}(S)\}$$ gradi di libertà equivalenti per il termine di errore  
$$\mbox{tr}(S)$$ gradi di libertà equivalenti per il lisciatore, 'quanto costa di $$n$$ per stimare il lisciatore', utile per confrontare complessità di metodi differenti ma anche per fare dei test.

Esistono altre forme di gradi di libertà equivalenti in funzione delle approssimazioni che si scelgono.


### Modelli additivi
Un modo per gestire la maledizione della dimensionalità sono i modelli additivi  
$$f(x_1,...,x_p)=\alpha+\sum_{j=1}^p f_j(x_j)+\sum_{k<j} f_{kj}(x_k,x_j)+...$$  
<!--- --->
si può usare per approssimare qualsiasi funzione.  
Ci si può fermare al termine di primo grado:  
$$y=f(x_1,...,x_p)+\epsilon=\alpha+\sum_{j=1}^p f_j(x_j)+\epsilon$$  
consentiamo una maggiore libertà di forma delle variabili rispetto il modello lineare.  
In un contesto geografico si potrebbe aggiungere come elemento di interazione le coordinate e il resto tutte in maniera additiva.  
Le $$p$$ funzioni $$f_j(x_j)$$ sono stimate mediante l'algoritmo 'backfitting'.  

#### Backfitting
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) È una variante dell'algoritmo di Gauss-Seidel.  
Iterativamente ogni funzione si può scrivere come residui parziali, fissando tutte le altre funzioni e quindi diventando univariata:  
$$f_j(x_j)=y-\left ( \alpha+\sum_{k\ne j} f_k(x_k)+\epsilon \right )$$  
a questo punto si può usare un lisciatore sui residui parziali (si può usare anche uno parametrico, nel caso si usi una retta si ottengono i minimi quadrati).  
Per evitare un eccesso di parametrizzazione dell'intercetta ogni funziona deve essere a media zero.






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

Q: slide 170, su modello scientifico e big data. Quel Rho 0.00084 è 1/sqrt(N)? perché mi viene differente. come è stato determinato quel n=400?



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

