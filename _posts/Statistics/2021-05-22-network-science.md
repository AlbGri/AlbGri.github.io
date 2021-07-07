---
title: "Statistics: Network Science"
excerpt: "note"
date: 2021-05-22
tags: [statistics, math, theory, university]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire.`

## Struttura della rete
Una rete è un grafo composto da nodi e archi.  
Teoria dei [sei gradi di separazione](https://it.wikipedia.org/wiki/Sei_gradi_di_separazione).  

Variabili di nodo: misurate sui nodi  
Variabili diadiche: misurate su coppie di nodi (diadi)  

Gli attributi (variabili di nodo) definiscono le caratteristiche delle singole entità (nodi). Si può rappresentarli con una matrice $$X_{(n\times q)}$$ con $$n$$ numero di nodi e $$q$$ numero di variabili di nodo.  

Le variabili diadiche (esistono anche le triadiche), che definiscono le relazioni, possono essere rappresentate dalle socio matrici.  

## Relazioni
Le relazioni $$y_{i,j}$$ tra nodo $$i$$ e $$j$$ possono essere influenzate, ma non determinate, dagli attributi delle singole entità.

**Relazione indiretta (o simmetrica)**  
$$y_{i,j}=y_{j,i}$$ stessa relazione per entrambi i versi. Nodi e archi non orientati.  
**Relazione diretta**  
$$y_{i,j}$$ uguale o diverso da $$y_{j,i}$$. Nodi e archi orientati.  

**Relazioni binarie (dicotomica)** 
si hanno solo due possibili valori: presenza o assenza  
**Relazioni pesate**  
ordinale se i valori hanno un ordine;  
qualitativa (o categoriale) se i valori non hanno un ordine  

## Grafo
Il grafo $$G(N,E)$$ con $$N$$ insieme di vertici (nodi) e $$E$$ insieme di connessione di archi (linee o connessioni).  
Il grafo orientato contiene relazioni dirette in cui si tiene conto del verso della connessione.  

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Le proprietà dipendono dalla struttura del resto del grafo (es. misure di centralità)  

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Esempi di relazioni  
- rete di comunicazioni: $$y_{i,j}$$ numero di messaggi spediti da $$i$$ a $$j$$, $$y_{i,j}=0,1,2,...$$ 
- rete di conflitti: $$y_{i,j}$$ relazioni militari tra $$i$$ e $$j$$, $$y_{i,j}=-1,0,1$$

### Sottografo
Un grafo $$G_S=(N_S,E_S)$$ è sottografo (indotto) di $$G=(N,E)$$ se  
$$N_S$$ è un sottoinsieme di $$N$$  
$$E_S$$ è un sottoinsieme di $$E$$ e tutti gli archi in $$E_S$$ sono tra i nodi in $$N_S$$  

## Rappresentazioni

### Socio matrice
Rappresentazione matriciale delle relazioni (non per forza 0/1 binarie ma anche pesate).  
Se binaria, caratterizza la presenza o assenza della relazione tra coppie di nodi.  
Se le relazioni sono dirette binarie allora la matrice sarà simmetrica binaria, si possono caratterizzare con tutte le precedenti tipologie di relazioni.  
Può contenere anche dati mancanti.  

Sparsità della matrice: la dimensione della matrice cresce in maniera quadratica con il numero di osservazioni $$n$$, ma il numero di presenze di relazioni (es. 1) cresce linearmente con $$n$$.

### Matrice di adiacenza
Caso specifico della socio matrice, in cui si identificano solo relazioni binarie (dirette o indirette), senza dati mancanti.  
Matrice sparsa, per rappresentare una rete in maniera efficente si possono usare la lista di archi (insieme degli archi).  

### Lista di archi
Nel caso di nodi isolati (un nodo senza archi), è necessario rappresentare sia la lista degli archi che i nodi isolati.  
La lista di archi è una rappresentazione compatta e il suo vantaggio aumenta al crescere di $$n$$ con una percentuale $$p$$ di relazioni presenti su tutte.  

### Lista di adiacenza
Due nodi $$i$$ e $$j$$ sono adiacenti se esiste l'arco $$(i,j)$$ o $$(j,i)$$.  
Una lista (orientata) che definisce per ogni nodo quali sono i suoi adiacenti (orientati).  


## Proprietà delle reti

### Mondo piccolo (Small World)
si ha quando una rete (es. rete sociale del mondo) ha la maggior parte dei nodi non connessi direttamente, ma quasi ogni nodo può essere raggiunto con un numero piccolo di collegamenti.  

Si ha uno Small World se  
- vale la proprietà di invarianza di scala (l'andamento della distribuzione dei gradi e del livello di betweenness è esponenziale negativa)
- si ha una bassa densità
- per connettere due nodi servono mediamente pochi archi (lunghezza media di shortest path è bassa)
- vale la transitività

### Invarianza di scala (Scale Free)
un nuovo nodo ha più probabilità di connettersi con nodi con tante connessioni. Si hanno pochi nodi con tante connessioni e tanti nodi con poche connessioni.  
Se la relazione tra numero di nodi $$n$$ e numero di connessioni (gradi o betweenness) $$L$$ è esponenziale negativa $$n\approx e^{\gamma \cdot L}$$ allora vale l'invarianza di scala.  

### Omofilia (Homophily)
un nuovo nodo ha più probabilità di connettersi a nodi simili per alcune caratteristiche.  

### Altre proprietà
Strutture di comunità (Community structure): i nodi tendono a formare gruppi con un elevato numero di connessioni interne e poche tra gruppi.  

Hub: nodi con molte connessioni, spesso cruciali per la formazione del piccolo mondo.  

## Misure di sintesi

### Indicatori di nodo
**Shortest path della coppia di nodi $$(i,j)$$**  
numero di nodi minimi dal nodo $$i$$ al nodo $$j$$  

**Lunghezza dello shortest path $$s_{ij}$$**  
numero di archi di cui si compone lo shortest path tra due nodi  

**Grado del nodo $$i$$**  
numero di nodi a cui è connesso il nodo $$i$$-esimo  
$$d_i=\sum_{i=1}^V Y_{ij}$$  
con $$V$$ nodi e $$Y_{ij}=1$$ se il nodo $$i$$ è connesso con il nodo $$j$$, 0 altrimenti.  

**Livello di betweenness del nodo $$i$$**  
è la somma, per tutte le coppie di nodi diverse da $$i$$, del rapporto tra il numero di shortest path della coppia $$c$$ che passano per $$i$$ e il numero degli shortest paths totali della coppia $$c$$.  
$$g_i = \sum_{c \in S(i)} \frac{n_{c \vert i}}{n_{c}}$$  
con  
$$S(i)=$$ insieme composto da tutte coppie di nodi con shortest path passanti dal nodo $$i$$  
$$c=$$ c-esimo elemento (coppia di nodi) dell'insieme $$S(i)$$  
$$n_{c \vert i}=$$ numero di shortest path del $$c$$-esimo elemento passanti dal nodo $$i$$  
$$n_{c}=$$ numero di shortest path del $$c$$-esimo elemento  

**Transitività locale**  
...  

**Vicinanza**  
...  

**Centralità di autovettore**  
...  


### Indicatori di coppie di nodi
**Lunghezza minima di path**  
matrice con il numero di archi di cui si compongono gli shortest path (lunghezza $$s_{ij}$$) di tutti i nodi  

### Indicatori di rete
**Densità di $$Y$$**  
frequenza relativa del numero totale di archi osservati (considerando il verso della relazione) sul totale di archi possibili  
$$D=\frac{1}{V\cdot (V-1)} \sum Y_{ij}$$  

**Diametro di $$Y$$**  
Lunghezza massima degli shortest path  
$$\max{(s_{ij})}$$  

**Lunghezza media degli shortest path**  
Per connettere due nodi servono mediamente $$L$$ archi, cioè $$L-1$$ nodi intermedi.  
$$L=\frac{1}{V\cdot (V-1)}\sum s_{ij}$$  

**Omofilia tra gruppi**  
L'omofilia è massima quando i $$K$$ gruppi sono connessi internamente e non ci sono connessioni tra gruppi distinti.  
$$e_{k_1,k_2}=$$ (numero di archi che hanno inizio nel gruppo $$k_1$$ e fine nel gruppo $$k_2$$)/(numero totale di archi nella rete): omofilia del gruppo $$k_1$$ con il gruppo $$k_2$$  
$$a_{k_1}=$$ (numero di archi che hanno inizio (o fine) nel gruppo $$k_1$$)/(numero totale di archi nella rete): omofilia marginale del gruppo $$k_1$$  

**Modularità**  
Indice di omofilia. Frazione di archi che connette nodi dello stesso tipo meno il valore atteso della stessa quantità in una rete con connessioni casuali (analogia con il test $$\chi^2$$ per tabelle di contingenza).  
Sia $$k$$ il $$k$$-esimo gruppo  
$$Q=\sum_k^K e_{kk} - \sum_k^K a_k^2$$  
Utile per confrontare due rete, ma se si vuole assoluto bisogna normalizzarlo.  
Una modularità bassa indica che non c'è discriminazione tra i livelli della variabile gruppo.  

**Assortatività**  
Modularità normalizzata.  
$$R=\frac{\sum_k^K e_{kk} - \sum_k^K a_k^2}{1-\sum_k^K a_k^2}$$  
diviso il suo massimo che dipende dal numero di nodi della rete e dalla distribuzione marginale dei gruppi.  
Una assortatività bassa indica che non c'è discriminazione tra i livelli della variabile gruppo.  

**Distribuzioni**  
Distribuzione di frequenza del grado dei nodi di una rete (numero di connessioni).  
Distribuzione di frequenza del livello di betweenness (numero di connessioni importanti).  
Se è presente l'andamento esponenziale negativo si tratta di Small World.  

Grafico tra grado e betweenness per valutare se i nodi che hanno un elevato numero di connessioni sono gli stessi che sono i più importanti.  

## Rappresentazione grafica
Dimensione dei nodi proporzionale al grado o betweenness (hub).  
Forma e colore dei nodi in funzione dei gruppi.  
Posizione dei nodi: nodi connessi e/o con comportamenti simili collocati più vicini (comunità) 

### Force-Directed Placements
Una proposta di posizione ottimale dei nodi.  
Nodi come particelle di un sistema fisico con forze repulsive (maggiore energia per nodi vicini) e attrattive (maggiore nergia per nodi lontani).  
La posizione ottimale minimizza l'energia totale.  

## Community Detection
Per raggruppare i nodi e identificare comunità.  

- Algoritmo di Girvan-Newman: f(betweenness di arco)
- Metodo di Louvain: f(modularità)
- Modelli a blocchi stocastici: cluster bayesiano
- ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) altri

### Metodo di Louvain
Algoritmo iterativo.  
Si sceglie inizialmente il numero di comunità a cui si vuole arrivare.  
Inizialmente ogni nodo è un gruppo diverso, si sposta iterativamente un nodo raggruppandolo ad un altro (se connesso) misurando la variazione di modularità generata dallo spostamento di un nodo da una comunità ad un'altra.  
Allo step $$i$$ un nodo che è stato raggruppato viene rappresentato dalla sua comunità, che verrà valutata allo step $$i+1$$ per essere eventualmente accorpata ad un'altra comunità.  
Si cerca di raggruppare nodi il cui aumento di modularità è maggiore.  

## Modelli di rete
Da un problema non supervisionato a supervisionato, la target sono gli archi.  
Un modello che prevede il vettore delle connessioni (arco).  
Si vettorizza la socio matrice la cui lunghezza nel caso di matrice diretta sarà pari al numero di elementi della matrice meno la diagonale, nel caso di rete indiretta è pari alla lunghezza degli elementi della matrice triangolare superiore o inferiore.  

Nel caso di rete indiretta con relazioni binarie, si ha un vettore  
$$Y=\left \{ Y_{21},...,Y_{V1},...,Y_{ij},...,Y_{V,V-1} \right \}$$  
di lunghezza $$V\cdot (V-1) /2$$.  
Si può considerare come un vettore di v.a. bernoulliane, quindi modellabile con un modello logistico la cui risposta identifica la presenza o assenza di un arco. Però non può valere l'indipendenza tra gli archi.  

### Exponential Random Graph Models (ERGM)
$$\mathbb{P}(Y=y)$$ densità di una famiglia esponenziale in funzione di indicatori della rete.  

La probabilità di osservare una certa rete $$y=\left \{ y_{21},...,y_{V1},...,y_{ij},...,y_{V,V-1} \right \}\in \mathcal{Y}$$ è  
$$\mathbb{P}(Y=y;\theta)=\frac{\exp{\left \{ \theta ^T g(y) \right \}}}{\kappa(\theta)}=\exp{\left \{ \theta^T g(y) - log_\kappa (\theta) \right \} }$$  
dove  
$$\theta \in \Theta \subset \mathfrak{R}^p$$ vettore di $$p$$ parametri  
$$g(y)\in\mathfrak{R}^p$$ vettore di $$p$$ staitstiche di rete  
$$\kappa(\theta)=\sum_{Z\in \mathcal{Y}} \exp{\{ \theta ^T g(Z) \}}$$ costante di normalizzazione indipendente da $$y$$ ma molto difficile da calcolare  

#### Indipendenza degli archi
Il modello più semplice si ottiene assumendo che gli archi $$Y_{ij}\overset{\text{iid}}{\sim}\mbox{Bern}(\pi_{ij})$$  
$$\mathbb{P}(Y=y;\pi_{ij})=\prod_{i>j} \mathbb{P}(Y_{ij}=y_{ij};\pi)=\prod_{i>j} \pi_{ij}^{y_{ij}} (1-\pi_{ij})^{1-y_{ij}}=\exp{ \left \{ \sum_{i>j} \theta_{ij} y_{ij} \right \} }/\kappa(\theta)$$  
dove $$\mbox{logit}(\pi_{ij})=\theta_{ij}$$   

Si perde la possibilità di modellare gli effetti di eterogeneità degli attori, omofilia, transitività e clustering.  

##### Modello di Erdos-Rényi
non è un modello utile.  
Si ipotizza che l'effetto di presenza assenza di ciascun nodo è costante  
$$\theta_{ij}=\theta$$, $$\quad\forall \{i,j\}$$ con $$i>j$$  
$$\mathbb{P}(Y=y;\theta)=\exp{ \left \{ \theta \sum_{i>j} y_{ij} \right \} }/\log{(1+e^\theta)^{V(V-1)/2}}$$  

##### Modello $$p_1$$
è un modello poco utile.  
$$\theta_{ij}=p+\alpha_i+\alpha_j$$, $$\quad\forall \{i,j\}$$ con $$i>j$$  
$$\mathbb{P}(Y=y;\theta_{ij})=\exp{ \left \{ p \sum_{i>j} y_{ij} +\sum_i \alpha_i d_i \right \} }/\kappa (p, \alpha_1,...,\alpha_V)$$  
La probabilità di un arco tra $$i$$ e $$j$$ è data dalla propensione globale $$p$$ a formare connessioni nella rete e dalla propensione individuale dei due nodi a connettersi ad altri $$\alpha_i$$ e $$\alpha_j$$ senza interazioni.  
La costante di normalizzazione è difficile da calcolare.

#### Modelli Markoviani
Due archi sono indipendenti se non hanno neanche un nodo in comune.  
Si costruisce una dipendenza locale.  
$$\mathbb{P}(Y=y;\theta)=\exp{\left \{ \sum_{k=1}^{V-1} \theta_k S_k(y) +\theta_\tau T(y) \right \}}/\kappa(\theta)$$  
dove  
$$\theta_k$$ ora tengono conto delle interazioni  
$$S_k(y)$$ e $$T(y)$$ sono statistiche locali della rete vicino al nodo d'interesse  
$$S_1(y)=\sum_{i>j} y_{ij}$$ numero di archi  
$$S_k(y)=\sum_{i=1}^V {d_i\choose k}$$ numero di $$k$$-stelle ($$k\ge 2$$)  
$$T(y)=(1/6)\sum_{i,j,k} y_{ij} y_{ik} y_{jk}$$ numero di triangoli  

##### Miglioramenti
Le strutture precedenti possono portare una sottostima della dipendenza tra nodi. 
- $$k$$-stelle alternate: le stelle entrano in un solo termine con pesi esponenziali alternati $$\theta_{\small{\mbox{AKS}}}$$
- $$k$$-triangoli alternati: $$\theta_{\small{\mbox{AKT}}}$$

#### Variabili esplicative
Si include nel predittore lineare dell'ERGM il termine $$\beta^T h(x,y)$$ con $$h(\cdot)$$ vettore di statistiche dipendenti sia dalla rete che dalle informazioni di nodo. Tra le scelte più comuni per $$h$$  
- Popolarità del nodo: $$\beta \sum_i x_i d_i $$
- Similarità tra nodi: $$\beta \sum_{i>j} y_{ij} (x_i+x_j) $$
- Omofilia tra gruppi: $$\beta \sum_{i>j} I(x_i=x_j) $$


#### Stima
La stima MV dei ERGM non è possibile calcolarla per la costante di normalizzazione.  

##### MCMC
Si può ottenere la stima di MV via simulazione (simulated maximum likelihood).  

##### Pseudoverosimiglianza
dato un modello ERGM con log-verosimiglianza  
$$l(\theta)=\theta^T g(Y)-\log{\kappa(\theta)}$$  
se $$Y=(Y_{ij},Y_{(-ij)})$$ e $$y=(y_{ij}, y_{(-ij)})$$ si ha  
$$\mathbb{P}(Y_{ij}=1\vert Y_{(-ij)}=y_{(-ij)};\theta)$$ esplicita,  
quindi si massimizza la pseudo-verosimgilianza  
$$\mbox{ps-}L(\theta)=\prod_{i>j} \mathbb{P}(Y_{ij}=y_{ij} \vert Y_{-(ij)}=y_{-(ij)};\theta)$$  
che equivale alla stima di un modello di regressione logistica con risposta  
$$y=\left \{ y_{21},...,y_{V1},...,y_{ij},...,y_{V,V-1} \right \}$$ e  
matrice delle esplicative $$\Delta=\left \{ g(1,y_{-(ij)}) - g(0,y_{-(ij)}) \right \}_{i>j}$$  
Lo stimatore è consistente per $$V\rightarrow \infty$$.  


### Stochastic Block Model (SBMs)
Modelli a blocchi stocastici o blocchi stocastici a comunità mista.  
$$\mathbb{P}(Y=y)$$ funzione della probabilità di appartenenza alle comunità per ogni nodo e della probabilità di connessioni tra nodi in diverse comunità.

### Latent Position Models
Modelli a spazi latenti.  
$$\mathbb{P}(Y=y)$$ funzione della posizione di ciascun nodo in uno spazio latente.



## Utili

### Risorse
- ...


