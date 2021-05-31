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

### Funzione di densità di probabilità
Dato un determinato evento, lo si può caratterizzare con un'ipotesi distributiva  

Sia $$X\in \{0,1\}$$ v.a. discreta con possibili valori $$\mathcal{X}=\{x_1,x_2,...,\}$$  

$$p(x)=\mbox{Pr}(X=x;\theta)$$

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

$$L(\theta)=p(\vec{x};\theta)=\prod_{i=1}^n p(x_i;\theta)$$

#### Log verosimiglianza
Il logaritmo è una funzione monotona crescente, pertanto l'argomento che massimizza la log verosimiglianza è il medesimo della verosimiglianza. In fase di ottimizzazione, è computazionalmente più oneroso gestire la produttoria invece della sommatoria. Inoltre, il logaritmo consente di assicurare la convessità della funzione e un dominio più stretto su cui cercare i parametri da ottimizzare. 

$$l(\theta)=\log{p(\vec{x};\theta)}=\sum_{i=1}^n \log{p(x_i;\theta)}$$

### Stimatore

#### Stima di Massima Verosimiglianza
Maximum Likelihood estimation  

$$\hat{\theta}_{\small{\mbox{ML}}} (x) = \text{arg}\,\max\limits_{\theta} f(x \vert \theta)$$

#### Stima del massimo a posteriori
Maximum a posteriori estimation  

$$\hat{\theta}_{\small{\mbox{MAP}}} (x) = \text{arg}\,\max\limits_{\theta} \frac{f(x \vert \theta) g(\theta)}{\int_{\theta}f(x \vert \theta) g(\theta)\,d\theta}=\text{arg}\,\max\limits_{\theta} f(x \vert \theta) g(\theta)$$










