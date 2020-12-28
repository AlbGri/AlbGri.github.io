---
title: "Appunti di teoria della probabilità"
excerpt: ""
date: 2020-12-28
tags: [probability, math, theory, university]
mathjax: "true"
---


## Propedeuticità

### Insiemi

Proprietà commutativa: $$A\cup B=B\cup A \qquad AB=BA$$  

Proprietà associativa: $$(A\cup B)\cup C=A\cup (B\cup C) \qquad (AB)C=A(BC)$$  

Proprietà distributiva: $$A(B\cup C)=AB\cup AC$$  

Formula di de Morgan: $$\bigcup_{i=1}^\infty A_i=\overline{\bigcap_{i=1}^\infty \bar{A}_i}$$  

Esempio de Morgan con due insiemi: $$A_1\cup A_2=\overline{\bar{A}_1\cap \bar{A}_2}$$  
![png](/assets/images/Università/Probabilità_1.png)
### Funzioni

Una funzione è una associazione fra gli elementi di un insieme A (detto insieme di definizione) e un insieme B.

La seguente funzione associa ad ogni elemento di A uno ed un solo elemento di B $$f:A\rightarrow B$$  
In alternativa  
$$x\in A \mbox{ e } f(x)\in B$$  

Se l'insieme A è discreto allora la funzione viene detta successione. Si definisce indice la variabile $$n$$.    
$$n \in A \equiv \Im$$  
$$s[n]\in B\Leftrightarrow s_n \in B$$  

### Integrali
Sia  
$$f(x)=\frac{dF(x)}{dx}$$  
con $$F(x)$$ primitiva della funzione $$f(x)$$.

Sia $$E$$ una unione numerabile di insiemi disguinti $$A_i \mbox{ per } i=1,2,...,\infty$$, si ha che  
$$\int_E{f(x)dx}=\sum_{i=1}^\infty\int_{A_i}{f(x)dx}$$  

##### Integrali notevoli utili
[Youmath](https://www.youmath.it/lezioni/analisi-matematica/integrali/596-integrali-notevoli.html)  
$$f\big(g(x)\big)+c=\int{f'\big(g(x)\big)\cdot g'(x)dx}$$  
$$e^{f(x)}+c=\int{e^{f(x)}\cdot f'(x)dx}$$  
##### Integrazione per parti  
$$\int_a^b k dx=kx|_a^b-\int_a^b xdx$$  

### Misura di insiemi
Sia $$A$$ sottoinsieme di $$\Re$$, la sua misura risulta  
$$|A|=\int_A dx$$  
dato un intervallo $$A=[a,b]$$ risulta  
$$|A|=\int_a^b dx=b-a$$  

## Probabilità

### Risultati, eventi e probabilità
Sia $$\Omega$$ insieme dei possibili risultati.

Sia $$\mathcal{P}(\Omega)$$ l'insieme delle parti, cioè l'insieme di tutti i sottoinsiemi di $$\Omega$$.

Sia $$\Phi$$ l'insieme degli eventi, che a meno di rari casi in cui alcuni sottoinsiemi vengono esclusi, coincide con $$\mathcal{P}(\Omega)$$. Ogni suo elemento, cioè ogni sottoinsieme di $$\Omega$$ viene definito evento.

La misura numerica della possibilità che ha di realizzarsi un evento è detta _probabilità_ ed è una funzione $$P:\Phi\rightarrow R$$.  
Dato un evento $$A\in\Phi$$ la sua probabilità verrà indicata $$P(A)$$.

L'unione tra insiemi corrisponde all'operatore _or_  
L'intersezione tra insiemi corrisponde all'operatore _and_  
Il complementare di un insieme corrisponde all'operatore _not_  

e.g. Dato l'evento  
$$A=\mbox{"Esce un numero pari"}=\{2,4,6\}$$  
la sua probabilità sarà  
$$P(A)=P(\{2,4,6\})=P(\mbox{"Esce un numero pari"})$$

Per l'assegnazione della probabilità si può seguire l'approccio frequentistico o quello assiomatico.

### Approccio frequentistico
Si supponga di ripetere il fenomeno $$n$$ volte, è possibile contare quante volte il risultato è stato favorevole all'evento $$n_A$$. Si definisce il rapporto di frequenza per l'evento $$A$$ sulle $$n$$ prove, indicato con $$f(A)$$, come il rapporto fra il numero di prove favorevoli su quelle totali.  
$$f(A)=\frac{n_A}{n}$$  
Si definisce la probabilità dell'evento $$A$$ come il limite del rapporto di frequenza quando il numero di prove tende all'infinito  
$$P(A)=\lim_{n\rightarrow\infty}\frac{n_A}{n}$$  
Questo limite però non può essere calcolato con metodi analitici, in quanto $$n_A$$ è casuale e non è legato ad $$n$$. L'esistenza del limite deve quindi essere postulata.  
Inoltre, su $$n$$ ripetizioni di un fenomeno aleatorio, un evento $$A$$ si verificherà un numero di volte $$n_A\approx nP(A)$$.

### Spazi di probabilità
##### Definizione di probabilità
Dato un insieme $$\Omega$$ e considerato $$\Phi=\mathcal{P}(\Omega)$$, diremo che una funzione $$P:\Phi\rightarrow\Re$$ è una probabilità su $$\Phi$$ se risulta che
1. $$P\ge 0, P(\Omega)=1$$
2. Se $$A_i\in \Phi \mbox{ per } i=1,...,\infty$$ è una successione di eventi disgiunti e cioè tali che $$A_iA_j=\emptyset \mbox{ per }i\neq j$$ allora (sigma-additività) – nb. vale anche per un numero $$n$$ finito di eventi.  
$$P\Big(\bigcup_{i=1}^\infty A_i\Big)=\sum_{i=1}^\infty P(A_i)\label{eq:Prob1}\tag{Prob1}$$  

##### Definizione di spazio di probabilità
Uno spazio di probabilità è una coppia $$<\Omega,P>$$ in cui $$\Omega$$ è un insieme e $$P$$ è una probabilità su $$\Phi=\mathcal{P}(\Omega)$$.

### Proprietà
Dato uno spazio $$<\Omega,P>$$ consideriamo due eventi $$A,B$$.  
$$A\cup\bar{A}=\Omega$$  
$$B=B\Omega$$  
$$B=B(A\cup\bar{A})=(BA)\cup (B\bar{A})$$  
poiché $$BA$$ e $$B\bar{A}$$ sono disgiunti, con la ([Prob1](#mjx-eqn-eq:Prob1)) si ottiene  
$$P(B)=P(BA)+P(B\bar{A})\label{eq:Prob2}\tag{Prob2}$$  
$$P(\bar{A})=1-P(A)\label{eq:Prob3}\tag{Prob3}$$  

Dati due eventi $$A,B$$ tali che $$A\subset B$$ cioè che $$A$$ è contenuto o coincidente con $$B$$:    
$$A=AB \mbox{ e } P(B\bar{A})\ge 0 \Rightarrow P(B)\ge P(A)$$  

Dati due eventi $$A,B$$ non necessariamente disgiunti:    
$$A\cup B=A\cup (B\bar{A})$$  
![png](/assets/images/Università/Probabilità_2.png)
con i due elementi alla destra dell'uguale disgiunti, allora  
$$P(A\cup B)=P(A)+P(B\bar{A})\stackrel{(Prob2)}{=}P(A)+P(B)-P(AB)$$  

### Spazi interi, probabilità uniformi
Uno spazio è intero quando $$\Omega\subset\Im$$, cioè $$\Omega$$ è un insieme di numeri interi.
##### Definizione di densità intera
Una funzione $$p:\Im\rightarrow\Re$$ è detta una densità intera se risulta che  
$$p(i)\ge 0 \mbox{ per }i\in\Im \qquad \sum_{i=-\infty}^\infty p(i)=1$$  

$$A$$ è un insieme di numeri interi, può essere espresso come unione dei suoi elementi, cioè $$A=\cup_{i\in A}\{i\}$$, per $$i$$ che varia su $$A$$, gli eventi $$\{i\}$$ sono eventi elementari disgiunti con probabilità $$P(i)$$. Applicando la sigma-additività si ottiene  
$$P(A)=P(\cup_{i\in A}\{i\})=\sum_{i\in A} P(i)$$  
In uno spazio intero, la probabilità di qualsiasi evento si può calcolare sommando le probabilità degli eventi elementari corrispondenti ai suoi elementi.

Si può quindi definire una funzione $$p:\Im\rightarrow \Re$$ data da  
$$p(i)=P(i)\quad i\in \Omega\qquad\qquad p(i)=0\quad i\notin \Omega$$  
Si ottiene quindi la forma canonica per la probabilità di uno spazio intero:  
$$P(A)=\sum_{i\in A}p(i)$$  

##### Densità uniforme
Cardinalità $$\Omega$$ è finita e pari a $$|\Omega|=n$$. Sia la densità uniforme  
$$p(i)=\frac{1}{n}\quad i\in \Omega \qquad\qquad p(i)=0\mbox{ altrove}$$  
La probabilità degli eventi sarà  
$$P(A)=\sum_{i\in A} P(i)=\sum_{i\in A}\frac{1}{n}=\frac{|A|}{n}$$  

Con cardinalità di $$A$$ si può intendere il numero di eventi favorevoli (la probabilità si può definire come casi favorevoli su casi possibili)

### Spazi discreti
Uno spazio è discreto quando $$\Omega$$ è un insieme numerabile di numeri reali, cioè i cui elementi possono essere messi in corrispondenza con i numeri naturali. Ogni spazio intero è uno spazio discreto, ma non è vero il contrario.  
Si può quindi definire una funzione $$p:\Re\rightarrow \Re$$ data da  
$$p(x)=P(x)\quad x\in \Omega\qquad\qquad p(x)=0\quad x\notin \Omega$$  
viene detta densità (discreta) dello spazio.  
Si ottiene quindi la forma canonica per la probabilità di uno spazio discreto:  
$$P(A)=\sum_{x\in A}p(x)$$  

### Eventi condizionati
##### Definizione di probabilità condizionata (nell'approccio assiomatico)
Siano dati uno spazio di probabilità $$<\Omega,P>$$ e due eventi $$A$$ e $$B$$ con $$P(A)>0$$. Si definisce la probabilità condizionata di $$B$$ dato $$A$$  
$$P(B|A)=\frac{P(AB)}{P(A)}\label{eq:Cond1}\tag{Cond1}$$  
Si può pensare che $$A$$ sia un evento fisso e noto, mentre $$B$$ è un qualsiasi evento di $$\Phi=\mathcal{P}(\Omega)$$.  
Dalla precedente equazione si ottiene  
$$P(AB)=P(B|A)P(A)\label{eq:Cond2}\tag{Cond2}$$  
Si dimostra che  
$$P(B|A)\le 0 \mbox{ e } P(\Omega |A)=\frac{P(\Omega A)}{P(A)}=\frac{P(A)}{P(A)}=1$$  
inoltre se gli eventi $$B_i$$ sono disgiunti  
$$P\Big[\Big(\bigcup_{i=1}^\infty B_i\Big)|A\Big]=\frac{P\Big[\Big(\bigcup_{i=1}^\infty B_i\Big)A\Big]}{P(A)}=\frac{P\Big[\Big(\bigcup_{i=1}^\infty A B_i\Big)\Big]}{P(A)}=\sum_{i=1}^\infty \frac{P(AB_i)}{P(A)})=\sum_{i=1}^\infty P(B_i|A)$$  

##### Probabilità condizionata nell'approccio frequentista
Effettuiamo $$n$$ ripetizioni del fenomeno,  
contiamo le volte in cui si è verificato l'evento $$A$$ e le indichiamo con $$n_A$$ e  
contiamo quante volte in cui si è verificato l'evento $$AB$$ e le indichiamo con $$n_{AB}$$.  
Poi si definisce un nuovo fenomeno aleatorio, il fenomeno condizionato all'evento $$A$$, scartando dalla sequenza dei risultati tutti quelli in cui non si è verificato $$A$$.  
Quindi si avrà  
$$f(B|A)=\frac{n_{AB}}{n_A}=\frac{n_{AB}}{n}\frac{n}{n_A}$$  
quando $$n\rightarrow \infty$$ si ottiene  
$$P(B|A)=\lim_{n\rightarrow \infty}\frac{n_{AB}}{n}\frac{n}{n_A}=P(AB)\frac{1}{P(A)}=\frac{P(AB)}{P(A)}$$  

### Bayes e probabilità totali
##### Definizione di partizione
Dato un insieme $$\Omega$$, una successione di suoi sottoinsiemi $$A_i \mbox{ per } i=1,...,n$$ si dice una partizione di $$\Omega$$ se sono verificate due condizioni:
1. $$A_i A_j=\emptyset \mbox{ per }i\neq j$$ cioè che i sottoinsiemi siano mutuamente disgiunti
2. $$\bigcup_{i=1}^n A_i=\Omega$$ cioè che l'unione di tutti gli insiemi della successione sia pari a $$\Omega$$  
o equivalentemente $$\sum_{i=1}^n P(A_i)=1$$

##### Probabilità totali
Dati uno spazio di probabilità, una partizione $$A_i$$ ed un evento $$B$$, il teorema delle probabilità totali:  
$$P(B)=\sum_{i=1}^n P(B|A_i)P(A_i)\label{eq:PrTot1}\tag{PrTot1}$$  
dimostrazione:  
visto che $$A_i$$ è una partizione  
$$B=B\Omega=B\Big(\bigcup_{i=1}^n A_i\Big)=\bigcup_{i=1}^n BA_i$$  
$$P(B)=P\Big(\bigcup_{i=1}^n BA_i\Big)\stackrel{(Prob1)}{=}\sum_{i=1}^n P(BA_i)\stackrel{(Cond2)}{=}\sum_{i=1}^n P(B|A_i)P(A_i)$$  

##### Bayes
Formula o regola di Bayes  
$$P(A|B)=\frac{P(B|A)P(A)}{P(B)}\label{eq:Bayes1}\tag{Bayes1}$$  
Teorema di Bayes  
$$P(A_i|B)=\frac{P(B|A_i)P(A_i)}{\sum_{k=1}^n P(B|A_k)P(A_k)}\label{eq:Bayes2}\tag{Bayes2}$$  


### Indipendenza e prove ripetute
##### Definizione di eventi indipendenti
Dato uno spazio di probabilità e $$n$$ eventi $$A_i \mbox{ per } i=1,...n$$ gli eventi si dicono (statisticamente) indipendenti se, assegnati in qualsiasi modo $$k\le n$$ numeri $$n_1,n_2,...,n_k$$ tutti diversi e compresi fra $$1$$ e $$n$$ risulta  
$$P(A_{n_1} A_{n_2} \cdots A_{n_k})=P(A_{n_1})P(A_{n_2})\cdots P(A_{n_k})\label{eq:Indip1}\tag{Indip1}$$  
vale anche con le probabilità condizionate, ad esempio nel caso di due eventi indipendenti $$A$$ e $$B$$ condizionati ad un terzo evento $$C$$, si ha  
$$P(AB|C)=P(A|C)\cdot P(B|C)$$  

##### Prove ripetute
Dato il fenomeno aleatorio associato ad uno spazio intero $$<\Omega,P>$$, possiamo di ripetere il fenomeno $$n$$ volte e considerare l'insieme delle ripetizioni come un altro fenomeno aleatorio, detto di prove ripetute, associato allo spazio $$<\Omega^n,P^n>$$ la cui probabilità è specificata dalla densità intera multidimensionale.

### Spazi continui
Uno spazio è continuo quando $$\Omega$$ è un insieme continuo, e cioè i cui elementi possono essere messi in corrispondenza biunivoca con i numeri reali $$\Re$$.

## Variabili aleatorie

Una variabile aleatoria $$X$$ stabilisce una associazione fra sottoinsiemi di $$\Re$$ ed eventi (sottoinsiemi di $$\Omega$$).  
Per ogni assegnato insieme $$A\subset \Re$$ è possibile identificare tutti gli elementi di $$\Omega$$ che, tramite la $$X$$, vengono associati ad un elemento di $$A$$.  
$$E=\big\{\omega\in\Omega|X(\omega)\in A\big\}\stackrel{(Compatto)}{\Leftrightarrow}E=\{X\in A\}$$  

##### Insieme delle determinazioni
Data una variabile aleatoria $$X=X(\omega)$$, facendo variare $$\omega$$ su tutti i risultati, si ottengono tutte le determinazioni della variabile, il cui insieme viene indicato con $$\Omega_X\subset \Re$$.

### Variabili intere
##### Definizione di v.a. intera
Una variabile aleatoria è intera quando i valori che assume sono numeri interi.
##### Supporto di una densità intera
Data una densità intera $$p(i)$$ il suo supporto $$S$$ è l'insieme di indici per cui la densità è maggiore di zero  
$$S=\{i\in \Im |p(i)>0\}$$  
ovviamente, data una variabile con densità $$p(i)$$, il supporto coincide con le possibili determinazioni della variabile, e cioè $$S=\Omega_X$$

### Densità binomiale e geometrica
##### Densità binomiale $$B(n,\pi)$$
Sia $$X$$ una v.a. che sprime il numero $$k$$ di successi in uno schema successo/insuccesso con $$n$$ ripetizioni ed una probabilità di successo pari a $$\pi$$:  
$$p(k)=P(X=k)={n\choose k}\pi^k(1-\pi)^{(n-k)}\mbox{ per } k=0,...,n \qquad p(k)=0\mbox{ altrove}$$  

##### Densità geometrica $$\mathcal{G}(\pi)$$
Sia $$X$$ una v.a. che esprime il numero $$k$$ tentativi prima del primo successo (al $$k$$-esimo tentativo).    
$$p(k)=P(X=k)=\pi(1-\pi)^{k-1}\mbox{ per } k=1,2,... \qquad p(k)=0\mbox{ per }k\le 0$$  
Sia $$Y$$ una v.a. che esprime il numero $$k$$ di insuccessi prima del primo successo.    
$$p(k)=P(Y=k)=\pi(1-\pi)^{k}\mbox{ per } k=0,1,2,... \qquad p(k)=0\mbox{ per }k< 0$$  
Utili:  
1. $$\{X>k-1\}=\{X=k\}\cup \{X>k\}$$
2. $$P(X\ge k+m|X\ge k)=P(X\ge m)$$ proprietà di assenza di memoria:  
se non si è avuto nessun successo fino al passo $$k$$, la probabilità di avere un successo $$m$$ passi più avanti è la stessa di avere un successo dopo $$m$$ passi dall'inizio. In altre parole, se non ci sono stati successi fino al passo $$k$$ la probabilità di avere successi nei passi successivi non è modificata rispetto all'inizio.

### Variabili discrete
##### Definizione di v.a. discreta
Una variabile aleatoria è discreta quando l'insieme dei valori che può assumere è un insieme numerabile, e cioè i cui elementi possono essere messi in corrispondenza con i numeri interi o naturali.  
$$P(X\in A)=\sum_{x\in A}p(x)$$  

### Variabili continue
##### Definizione di densità continua
Una funzione $$p:\Re \rightarrow \Re$$ si dice una densità continua se risulta  
$$p(x)\ge 0 \quad x\in \Re \qquad\qquad \int_{-\infty}^\infty p(x)dx=1$$  
è funzione integrabile, sommabile e continua su tutto l'asse tranne, al più, in un insieme discreto di punti.
##### Definizione di v.a. continua
Una variabile aleatoria è continua quando esiste una densità continua, tale che la probabilità dell'evento $$\{X\in A\}$$ con $$A\subset \Re$$ (e $$A$$ appartiene alla sigma-algebra dei Borelliani e che l'integrale sia un integrale di Lebesgue)  
$$P(X\in A)=\int_A p(x)dx$$  
##### Supporto di una densità continua
Data una densità continua $$p(x)$$, il suo supporto $$S$$ è l'insieme di  numeri reali per cui la densità è maggiore di zero. Cioè $$S=\{x\in \Re|p(x)>0\}$$. Il supporto coincide con le possibili determinazioni della variabile ($$S=\Omega_X$$).

### Densità esponenziale $$Exp(\lambda)$$
Sia $$X$$ una v.a. la cui determinazione indica il tempo passato fra l'accensione e la rottura del dispositivo, e cioè tale che un evento del tipo $$\{X=t\}$$ indica che l'evento si verifichi all'istante $$t$$.  
Proprietà di assenza di memoria: $$P(X\ge t+s|X\ge t)=P(X\ge s)$$  

Densità esponenziale di parametro $$\lambda$$  
$$p(x)=\lambda e^{-\lambda x}\quad \mbox{ per } x\ge 0\mbox{ e }\lambda >0 \qquad\qquad p(x)=0 \quad \mbox{ per }x<0$$  
$$P(X\ge y)=\int_y^\infty \lambda e^{-\lambda x} dx \stackrel{(z=-\lambda x)}{=}\int_{-\lambda y}^{-\infty} e^z dz=e^{-\lambda y}$$  

### Funzione di ripartizione
Data una v.a. $$X$$ la sua  funzione di ripartizione è una funzione $$F:\Re \rightarrow \Re$$ definita come segue  
$$F(x)=P(X\le x)$$  
restituisce la probabilità dell'evento $$\{X\le x\}$$, ossia la determinazione della v.a. è miniore di o uguale a $$x$$.  
Dato l'evento $$\{a<X\le b\}$$ con $$a<b$$ si avrà che  
$$\{X\le b\}\equiv \{X\le a\}\cup \{a<X\le b\}$$  
$$P(X\le b)=P(X\le a)+P(a<X\le b)$$  
$$P(a<X\le b)=F(b)-F(a)$$  

Le v.a. possono anche essere definite intere, discrete o continue in base alle caratteristiche della funzione di ripartizione.

##### Proprietà della funzione di ripartizione
1. $$F(X)\in [0,1]$$
2. $$lim_{x\rightarrow -\infty}F(x)=0$$
3. $$lim_{x\rightarrow \infty}F(x)=1$$
4. Non decrescente $$F(x_1)\ge F(x_0)\Leftrightarrow x_1 \ge x_0$$  

##### Variabili intere e discrete
La funzione di ripartizione è costante a tratti e cambia valore solo in corrispondenza ai valori appartenenti a $$\Omega_X$$ (interi nel caso di v.a. intere o un insieme numerabile di punti del'asse reale nel caso di v.a. discrete)  
$$F(i)=\sum_{n=-\infty}^i p(n)$$  
$$p(i)=F(i)-F(i-1)$$  

##### Variabili continue
La funzione di ripartizione di una v.a. continua è continua e derivabile  
$$F(x)=\int_{-\infty}^x p(u)du$$  
$$p(x)=\frac{d}{dx}F(x)$$  

### Trasformazioni
Dato uno spazio di probabilità $$<\Omega, P>$$,  
una v.a. $$X=X(\omega)$$ e una funzione $$f:\Re \rightarrow \Re$$,  
sia $$Y$$ una funzione di variabile aleatoria $$Y=f(X)=f(X(\omega))=Y(\omega)$$ quindi $$Y:\Omega\rightarrow\Re$$
  
$$p_Y(y)=\bigg|\frac{df^-1(y)}{dy}\bigg| p_X\big[f^-1(y)\big]$$  

### Densità condizionate
Dato uno spazio di probabilità $$<\Omega, P>$$, una v.a. $$X$$ e un evento $$B$$ con probabilità $$P(B)>0$$.    
$$F(x|B)=\frac{P(\{\omega \in \Omega | X(\omega)\le x, \omega \in B\})}{P(B)}=\frac{P(X\le x,B)}{P(B)}\stackrel{A\equiv\{X\le x\}}{=}\frac{P(AB)}{P(B)}=P(A|B)$$  

Nell'intero  
$$p(i|B)=F(i|B)-F(i-1|B)=P(X=i|B)\mbox{ per }i\in \Im$$  
$$P(X\in A|B)=\sum_{x\in A}p(x|B)$$  

Nel continuo  
$$p(x|B)=\frac{d}{dx}F(x|B)$$  
$$P(X\in A|B)=\int_A p(x|B)dx$$  

##### Probabilità totali
Sia una partizione $$A_i$$ per $$i=1,...,n$$ di $$\Omega$$ e X una v.a. continua, intera o discreta  
$$p(x)=\sum_{i=1}^n p(x|A_i)P(A_i)$$  



## Variabili multidimensionali

### Variabili e densità marginali
Dato uno spazio di probabilità $$<\Omega,P>$$ consideriamo una variabile bidimensionale $$Z=(X,Y)$$ con densità $$p(x,y)$$. Per definizione di $$Z$$, $$X$$ e $$Y$$ sono a loro volta due variabili aleatorie unidimensionali, e vengono dette variabili marginali, mentre $$Z$$ è la congiunta.  

L'evento marginale $$\{X\in A\}$$ si può anche esprimere come $$\{Z\in B\}$$ dove $$B=\{(X,Y)\in\Re^2|X\in A\}$$

Sia $$Z=(X,Y)$$ v.a. intera  
$$p_X(i)=\sum_{j=-\infty}^\infty p_{XY}(i,j)\qquad\qquad p_Y(j)=\sum_{i=-\infty}^\infty p_{XY}(i,j)$$  

Sia $$Z=(X,Y)$$ v.a. continua  
$$p_X(i)=\int_{-\infty}^\infty p_{XY}(x,y)dy\qquad\qquad p_Y(j)=\int_{-\infty}^\infty p_{XY}(x,y)dx$$  
$$F(x)=\int_{u=-\infty}^x\bigg[\int_{y=-\infty}^\infty p_{XY}(u,y)dy\bigg]du$$  

### Densità condizionate, Indipendenza e Bayes
##### Desità condizionate
Densità condizionata della v.a. $$X$$ posto che $$Y=y$$  
$$p_{X|Y}(x|y)=\frac{p_{XY}(x,y)}{p_Y(y)}\quad\mbox { per }x\in \Re$$  

Nel caso intero  
$$p_{X}(i)=\sum_{j=-\infty}^\infty p_{X|Y}(i|j)p_Y(j)$$  

Nel caso continuo  
$$p_{X}(x)=\int_{-\infty}^\infty p_{X|Y}(x|y)p_Y(y)dy$$  
$$\int p_{X|Y}(x|y)dx=\int\frac{p_{XY}(x,y)}{p_Y(y)}dx=\frac{p_Y(y)}{p_Y(y)}=1$$  

##### Bayes  
$$p_{Y|X}(y|x)=\frac{p_{XY}(x,y)}{p_X(x)}=\frac{p_{X|Y}(x|y)p_Y(y)}{p_X(x)}$$  

##### Indipendenza
Due v.a. $$X$$ e $$Y$$ si dicono indipendenti ($$X\bot Y$$) se  
$$p_{XY}(x,y)=p_X(x)p_Y(y)$$  

Alcune conseguenze  
$$p_{X|Y}(x|y)=p_X(x)$$  
$$p_{Y|X}(y|x)=p_Y(y)$$  
  
$$F_{XY}(x,y)=F_X(x)F_Y(y)$$  
$$P(X\le x, Y\le y)=P(X\le x)P(Y\le y)$$  
  
$$p_{(X+Y)|Y}(x|y)=p_X(x-y)$$  
$$p_{(X+Y)}(x)=\int_{-\infty}^\infty p_{(X+Y)|Y}(x|y)p_Y(y)dy=\int_{-\infty}^\infty p_X(x-y)p_Y(y)dy$$  

## Valore atteso

##### Definizione di valore atteso
Data una v.a. continua $$X$$ con densità $$p(x)$$  
$$E\{X\}=\int_{-\infty}^\infty xp(x)dx$$  

Data una v.a. intera $$X$$ con densità $$p(k)$$  
$$E\{X\}=\sum_{k=-\infty}^\infty kp(k)$$  

##### Teoremi e proprietà
- $$E\{Y\}=E\{f(X_1,...,X_n)\}=\int_{-\infty}^\infty \dots \int_{-\infty}^\infty f(x_1,...,x_n)p_X(x_1,...,x_n)dx_1\dots dx_n $$
- $$E\big\{\sum_{i=1}^n a_iX_i\big\}=\sum_{i=1}^n a_i E(X_i)$$ Linearità del valore atteso
- $$E\{XY\}\stackrel{ind}{=}E\{X\}E\{Y\}$$
- $$E\{a\}=a$$ con $$a$$ costante
- Se $$X(\omega)\ge Y(\omega) \Rightarrow E\{X\}\ge E\{Y\}$$
- Se $$X(\omega)\ge 0\Rightarrow E\{X\}\ge 0 \Rightarrow E\{|X|\}\ge |E\{X\}|$$

### Momenti, media e varianza

$$E\{X^k\}$$ momento di ordine $$k$$ della v.a. $$X$$  
$$E\{(X-\mu_X)^k\}$$ momento centrato di ordine $$k$$ della v.a. $$X$$

$$\mu_X=E\{X\}$$ valore medio  
$$\pi_X=E\{X^2\}$$ valore quadratico medio  
$$\sigma_X^2=E\{(X-\mu_X)^2\}=\pi_X-\mu_X^2$$ varianza

##### Teoremi e proprietà
Per $$Y=aX$$
- $$\mu_Y=a\mu_X$$
- $$\sigma_Y^2=a^2\sigma_X^2$$
- $$\pi_Y=a^2\pi_X$$

Per $$Y=X+a$$
- $$\mu_Y=\mu_X+a$$
- $$\sigma_Y^2=\sigma_X^2$$

Se $$Z$$ è somma di combinazioni lineari di $$X_i$$ indipendenti $$Z=\sum_i a_i X_i$$
- $$\sigma_Z^2=\sum_i a_i^2 \sigma_{X_i}^2$$

### Correlazione e covarianza

Siano $$X$$ e $$Y$$ due v.a.  
$$E\{X^yY^k\}$$ momento (misto) di ordine $$h,k$$  
$$E\{(X-\mu_X)^h (Y-\mu_Y)^k\}$$ momento centrato  
$$R_{XY}=E\{XY\}$$ correlazione  
$$C_{XY}=E\{(X-\mu_X) (Y-\mu_Y)\}$$ covarianza  
$$\rho_{XY}=\frac{C_{XY}}{\sigma_X \sigma_Y}$$


##### Teoremi e proprietà
- $$R_{XY}=R_{YX}$$
- $$C_{XY}=C_{YX}$$
- $$C_{XY}=R_{XY}-\mu_X \mu_Y$$
- $$X\bot Y\Rightarrow C_{XY}=0$$
- $$C_{XY}=\sigma_X\sigma_Y\Leftrightarrow Y=aX\mbox{ con }a>0$$
- $$C_{XY}=-\sigma_X\sigma_Y\Leftrightarrow Y=aX\mbox{ con }a<0$$
- $$C_{XY}^2\le \sigma_X^2 \sigma_Y^2$$
- $$|C_{XY}|\le \sigma_X \sigma_Y$$

### Valori attesi condizionati e parziali
Data una v.a. continua $$X$$ e un evento $$A$$  
$$E\{X|A\}=\int_{-\infty}^{\infty}xp_{X|A}(x|A)dx$$  
Date due v.a. continue $$X$$ e $$Y$$  
$$E\{X|Y=y\}=\int_{-\infty}^{\infty}xp_{X|Y}(x|y)dx$$  
Sia $$Z=f(X,Y)$$ funzione di due v.a. continue $$X$$ e $$Y$$, il suo valore atteso parziale rispetto ad una delle due variabili è definito come  
$$E_Y\{Z\}=\int_{-\infty}^{\infty}f(X,y)p_Y(y)dy$$  

## Teorema del limite centrale
Data una successione $$X_i$$ di v.a. continue, indipendenti e con la stessa densità e quindi stessa varianza $$\sigma^2$$, ossia una successione _iid_, inoltre $$E(X_i)=0\mbox{ per }i=1,...,n$$  
$$G_n=\frac{1}{\sqrt{n}}\sum_{i=1}^n X_i$$  
Si dimostra per $$n\rightarrow\infty$$  
$$G_n\stackrel{\infty}{\sim}\mathcal{N}(0,\sigma^2)\qquad p_{G_n}(n)\rightarrow\frac{1}{\sqrt{2\pi\sigma^2}}e^{-\frac{x^2}{2\sigma^2}}$$  
Si può anche estendere anche al caso in cui le variabili $$X_i$$ hanno media diversa da zero oppure distribuzione diverse.

## Legge dei grandi numeri
##### Disuguaglianza di Chebyshev
Data una v.a. $$X$$ con media $$\mu$$ e varianza $$\sigma^2$$ finite, per un qualsiasi numero $$\epsilon >0$$ risulta  
$$P(|X-\mu|>\epsilon)\le\frac{\sigma^2}{\epsilon^2}$$  
##### Legge dei grandi numeri
Data una v.a. $$X$$ con
- media $$\mu_X$$
- varianza $$\sigma^2_X$$
- media campionaria $$\bar{X}_n=\frac{1}{n}\sum_{i=1}^n X_i$$
- varianza campionaria $$\sigma_{\bar{X}_n}^2=\frac{1}{n}\sigma_X^2$$

TLC  
$$lim_{n\rightarrow\infty}P(|\bar{X}_n-\mu_X|>\epsilon)=0$$  
quindi per $$n$$ alto a sufficienza    
$$\mu_X\approx \frac{1}{n}\sum_{i=1}^n x_i$$  
la media campionaria fornisce un metodo per stimare il valore medio di una variabile.

## Funzioni utili

##### Somma della serie geometrica
per $$q\neq 1$$  
$$\sum_{k=0}^n q^k=\frac{1-q^{n+1}}{1-q}$$  
da cui, per $$|q|<1$$  
$$\sum_{k=0}^\infty q^k=\frac{1}{1-q}$$  

##### Somma primi interi  
$$\sum_{i=1}^n i=\frac{n(n+1)}{2}$$  
$$\sum_{i=1}^n i^2=\frac{n(n+1)(2n+1)}{6}$$  

##### Calcolo combinatorio  
$${n\choose k}=\frac{n!}{k!(n-k)!}$$  


### Funzione di Heaviside
#### Esempio 1
Sia $$f(t)$$ la funzione definita a tratti nel seguente modo  
$$f(t)=\begin{cases} 
k_1 & \mbox{se }t \in [a;b] \longleftarrow \mbox{ramo I} \\ 
k_2 & \mbox{se }t \in (b;c] \longleftarrow \mbox{ramo II} \\ 
0 & \mbox{altrove }
\end{cases}$$  
Sia $$u(t)$$ la funzione di Heaviside  
$$u(t)=\begin{cases} 
1 & \mbox{se }t \ge 0 \\ 
0 & \mbox{se }t < 0
\end{cases}$$  
nb. a volte in $$0$$ viene definita con uno dei seguenti valori  
$$u(0)=0 \quad u(0)=1 \quad u(0)=\frac{1}{2}$$  
Sappiamo che  
$$f(t)=k_1 \mbox{ quando } t\ge a \mbox{ e } t\le b$$  
$$t\ge a \Rightarrow t-a\ge 0$$  
$$t\le b \Rightarrow t-b\le 0$$  
Quindi il ramo I $$f_{R_I}(t)$$ può essere espresso come  
$$f_{R_I}(t)=k_1\cdot [u(t-a)-u(t-b)] \mbox{ con } t\in [a;b]$$  
si determina il ramo II in modo analogo, quindi l'intera funzione sarà la somma dei due rami.

#### Esempio 2
Data la funzione  
$$f(t)=min(t,1) \mbox{ con } t\ge 0$$  
si può riscrivere come  
$$f(t)=\begin{cases} 
t & \mbox{se }0\le t<1 \\ 
1 & \mbox{se }t\ge 1
\end{cases}$$  
utilizzando la funzione Heaviside si ottiene  
$$t\big[u(t)-u(t-1)\big]+u(t-1)$$  

### Trasformata di Laplace  
$$F(s)=L\big[f(t)\big]=\int_0^\infty e^{-st}f(t)dt$$  
es. $$f(t)=1$$  
$$F(s)=\int_0^\infty e^{-st}\cdot 1dt=\left[-\frac{1}{s}e^{-st}\right]_0^\infty=\frac{1}{s}$$  

#### Prodotto di convoluzione  
$$\big(f*g\big)(t)=\int_0^t{f(t-\tau)g(\tau)d\tau}\equiv L^{-1}\Big\{L\big[f(t)\big]L\big[g(t)\big]\Big\}$$  


$$\{X>k-1\}=\{X=k\}\cup \{X>k\}$$
$$\{X>k-1\}=\{X=k\}\cup \{X>k\}$$

$$\{X>k-1\}=\{X=k\}\cup \{X>k\}$$  

  $$\{X>k-1\}=\{X=k\}\cup \{X>k\}$$





...
