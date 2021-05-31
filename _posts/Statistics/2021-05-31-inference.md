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

$$\mbox{Pr}(X=x;\theta)=p(x)$$

La funzione di massa di probabilità $$p:\mathcal{X}\rightarrow [0,1]$$ soddisfa la lagge delle probabilità totali  

$$\sum_{x\in\mathcal{X}}p(X=x)=1$$

Si considerino due eventi $$\left \langle X_1, X_2 \right \rangle$$, si avrà  
distribuzione congiunta: $$p(X_1,X_2)$$  
distribuzione condizionata: $$p(X_1 \vert X_2), p(X_2 \vert X_1)$$  
distribuzione marginale: $$p(X_1),p(X_2)$$  


Regola della probabilità a catena

$$p(X_1,X_2)=p(X_1)p(X_2 \vert X_1)\overset{\text{ind}}{=}p(X_1)p(X_2)$$

test



### Funzione di verosimiglianza

#### Log verosimiglianza

### Stimatore

#### Stima di Massima Verosimiglianza
Maximum Likelihood estimation  

$$\hat{\theta}_{\small{\mbox{ML}}} (x) = \text{arg}\,\max\limits_{\theta} f(x \vert \theta)$$

#### Stima del massimo a posteriori
Maximum a posteriori estimation  

$$\hat{\theta}_{\small{\mbox{MAP}}} (x) = \text{arg}\,\max\limits_{\theta} \frac{f(x \vert \theta) g(\theta)}{\int_{\theta}f(x \vert \theta) g(\theta)\,d\theta}=\text{arg}\,\max\limits_{\theta} f(x \vert \theta) g(\theta)$$










