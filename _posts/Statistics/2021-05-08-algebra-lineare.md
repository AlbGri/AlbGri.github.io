---
title: "Richiami di algebra lineare"
excerpt: "note"
date: 2021-05-08
tags: [math, theory, university]
mathjax: "true"
---

*in costruzione*

## Concetti di base

### Prodotto scalare
$$\begin{pmatrix} 
a_1 \\ 
b_1 \\
c_1
\end{pmatrix} \cdot
\begin{pmatrix} 
a_2 & b_2 & c_2
\end{pmatrix} = a_1a_2+b_1b_2+c_1c_2$$

### Somma di matrici
$$[A+B]_{ij}=[A]_{ij}+[B]_{ij}$$

### Prodotto di matrici
$$[AB]_{ik}=\sum_{j=1}^n [A]_{ij} [B]_{jk}$$ con $$i=1,...,l$$ e $$k=1,...,m$$  
Riga × Colonna  
$$\colorbox{green}{a}\times b$$  

$$\color{green!50}{a}\times b$$  
$$\color{red}{a}\times b$$  
$${\rm\color[rgb]{1,0,0}Some~red~math}$$  

$$\require{color}\newcommand{\textwithColor}[2]{\color{#1}{\text{#2}}} \textwithColor{red}{halleo}$$




## Operazioni tra matrici
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
- Se $$Q$$ ortogonale, allora $$Q^TQ=I$$
- $$(AB)^{-1}$$ $$=A^{-1}B^{-1}$$




## Distanza tra punti e iperpiani
Generico iperpiano in $$\mathbb{R}^p$$ di equazione $$a+b^T x=0$$ con $$x\in \mathbb{R}^p$$  
identificato dai coefficienti $$a\in \mathbb{R}$$ e $$b\in \mathbb{R}$$, si ha che:  
- per ogni punto $$x'$$ che giace sull'iperpiano $$\Rightarrow b^T x'=-a$$
- se $$x'$$ e $$x''$$ sono punti che giacciono sull'iperpiano $$\Rightarrow b^T (x'-x'')=0$$
- il vettore $$b$$ è quindi ortogonale all'iperpiano
- $$b^*=b/{\vert\vert b \vert\vert}$$ vettore di norma unitaria
- la distanza da un generico punto $$X\in R^p$$ dall'iperpiano, cioè la distanza tra $$X$$ e $$x_0$$, con $$x_0$$ proiezione ortogonale di $$X$$ che giace sull'iperpiano (quindi $$b^T x_0=-a$$), è data da:  
$$\vert\vert A - x_0 \vert\vert = b^*^T(A-x_0)=\frac{1}{\vert\vert b \vert\vert} (a+b^T X)$$


## Utili

### Risorse
- [Distanze da una retta (Scuola Normale Superiore di Pisa)](https://uz.sns.it/~antonino/DispenseDCS.pdf)

