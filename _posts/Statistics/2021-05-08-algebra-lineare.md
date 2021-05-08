---
title: "Richiami di algebra lineare"
excerpt: "note"
date: 2021-05-08
tags: [math, theory, university]
mathjax: "true"
---

*in costruzione*

## Concetti di base

### Norma
Norma nello [spazio $$L^p$$](https://it.wikipedia.org/wiki/Spazio_Lp) di ordine $$p$$  
$$\parallel \vec{x} \parallel _p := \left ( \sum_{i=1}^n \vert x_i \vert ^p \right ) ^{\frac{1}{p}}$$  

Norma euclidea ($$\ell ^2$$) di ordine $$p=2$$  
$$\parallel \vec{x} \parallel := \sqrt{\left \langle \vec{x}, \vec{x} \right \rangle }$$  



### Versore
Un [versore](https://it.wikipedia.org/wiki/Versore) è un vettore in uno [spazio normato](https://it.wikipedia.org/wiki/Spazio_normato) di [modulo](https://it.wikipedia.org/wiki/Norma_(matematica)) unitario, utilizzato per indicare una particolare direzione e verso. Dato un qualunque vettore $$\mathbf{v}$$ (diverso dal vettore nullo che è l'unico ad avere modulo pari a zero) è possibile formarne un versore moltiplicandolo per il reciproco del suo modulo

### Somma vettoriale
$$\vec{x}+\vec{y}=
\begin{pmatrix} 
x_1 + y_1 \\ 
x_2 + y_2 \\
... \\
x_n + y_n
\end{pmatrix}$$

### Prodotto scalare
Il prodotto scalare tra due vettori è uno scalare (un numero).  
$$\vec{x}\cdot \vec{y}=\left \langle \vec{x}, \vec{y} \right \rangle = \sum_{i=1}^n x_i y_i$$  
Il prodotto scalare tra vettori è nullo se e solo se i due vettori sono perpendicolari.  
Se i vettori sono identificati come riga di matrice, si può esprimere come prodotto matriciale: $$[x]_{1\times n} [y^T]_{n \times 1}$$  
Se i vettori sono identificati come colonna di matrice, si può esprimere come prodotto matriciale: $$[x^T]_{1\times n} [y]_{n\times 1}$$  

Esempio prodotto due vettori in forma matriciale (≡ prodotto matriciale Riga × Colonna)  
$$\begin{pmatrix} 
y_1 & y_2 & y_3
\end{pmatrix} 
\begin{pmatrix} 
x_1 \\ 
x_2 \\
x_3
\end{pmatrix} = x_1 y_1 + x_2 y_2 + x_3 y_3$$

### Prodotto vettoriale
Il [prodotto vettoriale](https://it.wikipedia.org/wiki/Prodotto_vettoriale) tra due vettori è un vettore.  
$$\vec{x} \times \vec{y}=\vec{z}$$


### Somma matriciale
$$[A+B]_{ij}=[A]_{ij}+[B]_{ij}$$

### Prodotto matriciale
$$[AB]_{ik}=\sum_{j=1}^n [A]_{ij} [B]_{jk}$$ con $$i=1,...,l$$ e $$k=1,...,m$$  
Riga × Colonna  

$$\begin{pmatrix} 
\mathbf{\color{ForestGreen}{a_{11}}} & \mathbf{\color{ForestGreen}{a_{12}}} & \mathbf{\color{ForestGreen}{a_{13}}} \\ 
a_{21} & a_{22} & a_{23} \\ 
a_{31} & a_{32} & a_{33}
\end{pmatrix} \cdot
\begin{pmatrix} 
\mathbf{\color{ForestGreen}{b_{11}}} & b_{12} \\ 
\mathbf{\color{ForestGreen}{b_{21}}} & b_{22} \\ 
\mathbf{\color{ForestGreen}{b_{31}}} & b_{32}
\end{pmatrix} =
\begin{pmatrix} 
\mathbf{\color{ForestGreen}{a_{11}b_{11}+a_{12}b_{21}+a_{13}b_{31}}} & ... \\ 
... & ... \\ 
... & ...
\end{pmatrix}$$








## Operazioni tra matrici
- $$(A^T)^T$$ $$=A$$
- $$(AB)^T$$ $$=A^T B^T$$
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
- [Distanze da una retta](https://uz.sns.it/~antonino/DispenseDCS.pdf) (Scuola Normale Superiore di Pisa)
- [Identità trigonometriche](https://trigids.com/)