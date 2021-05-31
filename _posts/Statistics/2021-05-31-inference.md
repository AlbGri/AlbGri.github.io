---
title: "Statistics: Inference"
excerpt: "note"
date: 2021-05-31
tags: [statistics, math, theory, university]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire.`


<!---
https://home.ttic.edu/~shubhendu/Slides/Estimation.pdf
--->


### Notazioni

#### Sigle
- Funzione di Densità di Probabilità - Probability Density Function - PDF
- Funzione di ripartizione - Cumulative Distribution Function - CDF

#### “|'' e “;''
[L'operatore di Sheffer](https://it.wikipedia.org/wiki/Operatore_di_Sheffer) $$\vert$$ si legge “dato che'' o “condizionato da''. Quindi $$p(x\vert y)$$ rappresenta la densità di probabilità di $$x$$ dato che è avvenuto qualche evento $$y$$. Simbolo tipicamente legato alla probabilità e statistica.

Il punto è virgola $$;$$ è leggermente differente e non è necessariamente legato alla probabilità e statistica. $$f(x;y)$$ è una funzione di una variabile $$x$$, definibile $$g(x)=f(x;y)$$. Indica che vi è un valore implicito o scelto di $$y$$ quando si esamina $$g(x)$$ ma non è parte della funzione. Il valore di $$y$$ è un parametro fisso, non avrebbe senso ad esempio farne la derivata.

Generalmente il condizionante è una v.a. osservata per uno specifico valore, mentre l'argomento dopo il punto e virgola è un parametro.

#### Discreto e continuo
Le seguenti notazioni sono puramente soggettive  

Sia $$X$$ v.a. discreta  
$$p_X(x)=\mathbb{P}(X=x)$$ è la funzione di massa di probabilità 

Sia $$X$$ v.a. continua  
$$f_X(x)=\mathbb{P}(X\in A)$$ è la funzione di densità di probabilità




### Funzione di probabilità
Dato un determinato evento, lo si può caratterizzare con un'ipotesi distributiva  

Sia $$X\in \{0,1\}$$ v.a. discreta con possibili valori $$\mathcal{X}=\{x_1,x_2,...,\}$$  

$$p(x)=\mathbb{P}(X=x;\theta)$$

La funzione di massa di probabilità $$p:\mathcal{X}\rightarrow [0,1]$$ soddisfa la legge delle probabilità totali  

$$\sum_{x\in\mathcal{X}}p(X=x)=1$$

Dati due eventi $$\left \langle X_1, X_2 \right \rangle$$
- distribuzione congiunta: $$p(X_1,X_2)$$
- distribuzione condizionata: $$p(X_1 \vert X_2), p(X_2 \vert X_1)$$
- distribuzione marginale: $$p(X_1),p(X_2)$$


Regola della probabilità a catena

$$p(X_1,X_2)=p(X_1)p(X_2 \vert X_1)\overset{\text{ind}}{=}p(X_1)p(X_2)$$

Quindi, data una sequenza i.i.d di $$n$$ eventi si otterrà

$$p(x_1,...,x_n;\theta)=\prod_{i=1}^n p(x_i;\theta)$$

### Funzione di verosimiglianza
Data una sequenza di $$n$$ eventi $$x_1,...,x_n\in \{0, 1\}^n$$ si vuole stimare $$\theta$$. Si può considerare $$p(x;\theta)$$ non più come funzione di $$x$$, ma di $$\theta$$ con un certo campione $$x$$ osservato.

Sia $$\vec{x}=[x_1,...,x_n]$$ sequenza i.i.d.

$$L(\theta)=p(\theta;\vec{x})=\prod_{i=1}^n p(\theta;x_i)$$

#### Log verosimiglianza
Il logaritmo è una funzione monotona crescente, pertanto l'argomento che massimizza la log verosimiglianza è il medesimo della verosimiglianza. In fase di ottimizzazione, è computazionalmente più oneroso gestire la produttoria invece della sommatoria. Inoltre, il logaritmo consente di assicurare la convessità della funzione e un dominio più stretto su cui cercare i parametri da ottimizzare. 

$$l(\theta)=\log{p(\theta;\vec{x})}=\sum_{i=1}^n \log{p(\theta;x_i)}$$

### Stimatore

#### Stima di Massima Verosimiglianza
Maximum Likelihood estimation  

$$\hat{\theta}_{\small{\mbox{ML}}} (x) = \text{arg}\,\max\limits_{\theta} f(x ; \theta)$$

##### Moltiplicatori di Lagrange



#### Stima del massimo a posteriori
Maximum a posteriori estimation  

Utilizzando il teorema di Bayes

$$f(\theta \vert x)=\frac{f(x\vert \theta)f(\theta)}{f(x)}$$

Risulta

$$\hat{\theta}_{\small{\mbox{MAP}}} (x) = \text{arg}\,\max\limits_{\theta} \frac{f(x ; \theta) f(\theta)}{\int_{\theta}f(x ; \theta) f(\theta)\,d\theta}=\text{arg}\,\max\limits_{\theta} f(x ; \theta) f(\theta)$$


### Matrix Notation

#### Distribuzione Normale

Sia $$\vec{x}=\{x_1,...,x_d\}$$ vettore aleatorio in $$\mathbb{R}^d$$

PDF:

$$f(\vec{x};\mu,\Sigma)=\frac{1}{(2\pi)^{d/2} \vert \Sigma \vert ^{1/2}} \exp{\left \{ -\frac{1}{2} ( \vec{x}-\mu ) ^T \Sigma ^{-1} (\vec{x}-\mu) \right \}}$$

Log-Likelihood:

$$l(\mu,\Sigma;\vec{x})=-\frac{1}{2}\log{(\vert \Sigma \vert )} -\frac{1}{2}(\vec{x}-\mu)^T \Sigma^{-1} (\vec{x}-\mu) -\frac{d}{2} \log{(2\pi)}$$

Dato un insieme $$\vec{X}$$ di $$n$$ vettori i.i.d, risulta:

$$l(\mu,\Sigma;\vec{X})=-\frac{n}{2}\log{(\vert \Sigma \vert )} -\frac{1}{2}\sum_{i=1}^n (\vec{x}_i-\mu)^T \Sigma^{-1} (\vec{x}_i-\mu) + \mbox{c}$$

Le stime MV risultano

$$\hat{\mu}_{\small{\mbox{ML}}}=\frac{1}{n}\sum_{i=1}^n \vec{x}_i, \qquad \hat{\Sigma}_{\small{\mbox{ML}}}=\frac{1}{n}\sum_{i=1}^n (\vec{x}_i-\mu)(\vec{x}_i-\mu)^T$$





