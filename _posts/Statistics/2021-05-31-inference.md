---
title: "Statistics: Inference"
excerpt: "note"
date: 2021-05-31
tags: [statistics, math, theory, university]
mathjax: "true"
---

*in costruzione*

<!---
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire.`
--->

<!---
https://home.ttic.edu/~shubhendu/Slides/Estimation.pdf
--->


### Notazioni

#### Sigle
- Funzione di Densità di Probabilità - Probability Density Function - PDF
- Funzione di ripartizione - Cumulative Distribution Function - CDF

#### “|'' e “;''
[L'operatore di Sheffer](https://it.wikipedia.org/wiki/Operatore_di_Sheffer) $$\vert$$ si legge “dato che'' o “condizionato a''. Quindi $$p(x\vert y)$$ rappresenta la densità di probabilità di $$x$$ dato che è avvenuto qualche evento $$y$$. Simbolo tipicamente legato alla probabilità e statistica.

Il punto è virgola $$;$$ è leggermente differente e non è necessariamente legato alla probabilità e statistica. $$f(x;y)$$ è una funzione di una variabile $$x$$, definibile $$g(x)=f(x;y)$$. Indica che vi è un valore implicito o scelto di $$y$$ quando si esamina $$g(x)$$ ma non è parte della funzione. Il valore di $$y$$ è un parametro fisso, non avrebbe senso ad esempio farne la derivata.

Generalmente il condizionante è una v.a. osservata per uno specifico valore, mentre l'argomento dopo il punto e virgola è un parametro.

#### Discreto e continuo
Le seguenti notazioni sono puramente soggettive  

Sia $$Y$$ v.a. discreta  
$$p_Y(y)=\mathbb{P}(Y=y)$$ è la funzione di massa di probabilità 

Sia $$Y$$ v.a. continua  
$$f_Y(y)=\mathbb{P}(Y\in A)$$ è la funzione di densità di probabilità




### Funzione di probabilità
Dato un determinato evento, lo si può caratterizzare con un'ipotesi distributiva  

Sia $$Y\in \{0,1\}$$ v.a. discreta con possibili valori $$\mathcal{Y}=\{y_1,y_2,...,\}$$  

$$p(y)=\mathbb{P}(Y=y;\theta)$$

La funzione di massa di probabilità $$p:\mathcal{Y}\rightarrow [0,1]$$ soddisfa la legge delle probabilità totali  

$$\sum_{y\in\mathcal{Y}}p(Y=y)=1$$

Dati due eventi $$\left \langle Y_1, Y_2 \right \rangle$$
- distribuzione congiunta: $$p(Y_1,Y_2)$$
- distribuzione condizionata: $$p(Y_1 \vert Y_2), p(Y_2 \vert Y_1)$$
- distribuzione marginale: $$p(Y_1),p(Y_2)$$


Regola della probabilità a catena

$$p(Y_1,Y_2)=p(Y_1)p(Y_2 \vert Y_1)\overset{\text{ind}}{=}p(Y_1)p(Y_2)$$

Quindi, data una sequenza i.i.d di $$n$$ eventi si otterrà

$$p(y_1,...,y_n;\theta)=\prod_{i=1}^n p(y_i;\theta)$$

### Funzione di verosimiglianza
Data una sequenza di $$n$$ eventi $$y_1,...,y_n\in \{0, 1\}^n$$ si vuole stimare $$\theta$$. Si può considerare $$p(y;\theta)$$ non più come funzione di $$y$$, ma di $$\theta$$ con un certo campione $$y$$ osservato.

Sia $$\vec{y}=[y_1,...,y_n]$$ sequenza i.i.d.

$$L(\theta)=p(\theta;\vec{y})=\prod_{i=1}^n p(\theta;y_i)$$

#### Log verosimiglianza
Il logaritmo è una funzione monotona crescente, pertanto l'argomento che massimizza la log verosimiglianza è il medesimo della verosimiglianza. In fase di ottimizzazione, è computazionalmente più oneroso gestire la produttoria invece della sommatoria. Inoltre, il logaritmo consente di assicurare la convessità della funzione e un dominio più stretto su cui cercare i parametri da ottimizzare. 

$$l(\theta)=\log{p(\theta;\vec{y})}=\sum_{i=1}^n \log{p(\theta;y_i)}$$

### Stimatore

#### Stima di Massima Verosimiglianza
Maximum Likelihood estimation  

$$\hat{\theta}_{\small{\mbox{ML}}} (y) = \text{arg}\,\max\limits_{\theta} f(y ; \theta)$$

##### Moltiplicatori di Lagrange



#### Stima del massimo a posteriori
Maximum a posteriori estimation  

Utilizzando il teorema di Bayes

$$f(\theta \vert y)=\frac{f(y\vert \theta)f(\theta)}{f(y)}$$

Risulta

$$\hat{\theta}_{\small{\mbox{MAP}}} (y) = \text{arg}\,\max\limits_{\theta} \frac{f(y ; \theta) f(\theta)}{\int_{\theta}f(y ; \theta) f(\theta)\,d\theta}=\text{arg}\,\max\limits_{\theta} f(y ; \theta) f(\theta)$$


### Matrix Notation

#### Distribuzione Normale

Sia $$\vec{y}=\{y_1,...,y_d\}$$ vettore aleatorio in $$\mathbb{R}^d$$

PDF:

$$f(\vec{y};\mu,\Sigma)=\frac{1}{(2\pi)^{d/2} \vert \Sigma \vert ^{1/2}} \exp{\left \{ -\frac{1}{2} ( \vec{y}-\mu ) ^T \Sigma ^{-1} (\vec{y}-\mu) \right \}}$$

Log-Likelihood:

$$l(\mu,\Sigma;\vec{y})=-\frac{1}{2}\log{(\vert \Sigma \vert )} -\frac{1}{2}(\vec{y}-\mu)^T \Sigma^{-1} (\vec{y}-\mu) -\frac{d}{2} \log{(2\pi)}$$

Dato un insieme $$\vec{X}$$ di $$n$$ vettori i.i.d, risulta:

$$l(\mu,\Sigma;\vec{X})=-\frac{n}{2}\log{(\vert \Sigma \vert )} -\frac{1}{2}\sum_{i=1}^n (\vec{y}_i-\mu)^T \Sigma^{-1} (\vec{y}_i-\mu) + \mbox{c}$$

Le stime MV risultano:

$$\hat{\mu}_{\small{\mbox{ML}}}=\frac{1}{n}\sum_{i=1}^n \vec{y}_i, \qquad \hat{\Sigma}_{\small{\mbox{ML}}}=\frac{1}{n}\sum_{i=1}^n (\vec{y}_i-\mu)(\vec{y}_i-\mu)^T$$





