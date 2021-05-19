---
title: "Statistics: Deep Learning"
excerpt: "note"
date: 2021-03-08
tags: [statistics, math, theory, university, R]
mathjax: "true"
---

*in costruzione*

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) `Da approfondire.`


## Deep Neural Network
Neural Network con più strati latenti.  
La struttura classica è la feed-forward neural network (FFNN) con nodi (parametri, peso) e archi.  
Il numero di nodi in output definisce la risposta.  


### Modellazione
$$a^{(l)}$$ vettore di nodi corrispondenti allo strato $$l$$-esimo  
$$W^{(l)}$$ matrice di parametri associati agli archi che collegano lo strato $$l$$ al successivo  
$$w_0^{(l)}$$ vettore di parametri associato allo strato $$l$$-esimo (analogia con l'intercetta)  

Legame tra lo strato $$l$$ e il suo precedente  
$$a^{(l)}=g^{(l)}\left ( z^{(l)} \right )$$  
con $$z^{(l)}=w_0^{(l-1)}+W^{(l-1)}a^{(l-1)}$$ e $$g^{(l)}(\cdot )$$ funzione d'attivazione  

### Funzione d'attivazione per l'ultimo strato latente
Le più utilizzate

#### Identità
$$g^{(l)}\left ( z^{(l)} \right )=z^{(l)}$$  
per un problema di regressione univariata ($$1$$ nodo output)  

#### Sigmoidale
Funzione logistica  
$$g^{(l)}\left ( z^{(l)} \right )=\frac{1}{1+e^{-z^{(l)}}}$$  
per un problema di classificazione dicotomico ($$1$$ nodo output)  

#### Softmax
Funzione logistica multinomiale  
$$g^{(l)}\left ( z^{(l)} \right )=\frac{e^{z^{(l)}}}{\sum_{j=1}^K e^{z^{(l)}}}$$  
per un problema di classificazione multiclasse ($$K$$ nodi output)  

### Ottimizzazione
$$\hat{W}=\text{arg}\,\min \left \{ \frac{1}{n} \sum_{i=1}^n D \left [ y_i, f(x_i;W) \right ] \right \}$$  

#### Funzioni di perdita
Errore quadratico medio: $$\frac{1}{n}\sum_{i=1}^n \left ( y_i - f(x_i; W) \right )^2$$  
Cross-entropia: $$-\sum_{i=1}^n \sum_{k=1}^K y_{ik} \log{f_k (x_i; W)}$$

### Backpropagation
Backward propagation of errors.  
Algoritmo per risolvere il problema di minimo.  

Epoca (epoch): singola iterazione dell'algoritmo (del gradient descent per risolvere il problema di ottimo), in cui tutto il dataset è passato avanti e dietro la rete una volta.  

Passo in avanti (forward pass): si ottiene $$\hat{f}(x_i;W)$$ (si calcolano tutti i nodi intermedi e output) tenendo fisso $$W$$.  
Passo in dietro (backwards pass): si tengono fissi tutti i nodi e si aggiorna $$W$$ (diviso in propagazione e aggiornamento).  

#### Propagazione
Fase in cui si calcolano tutte le derivate prime della funzione di perdita rispetto i parametri.  

1. Si calcolano tutte le derivate prime rispetto a $$z$$ rispetto all'ultimo strato
2. Equazione di back-propagation: consente di ottenere la derivata dello strato $$l-1$$ utilizzando la derivata dello strato $$l$$ (quindi utilizzando più volte l'equazione, dall'ultima derivata si ottengono tutte quelle precedenti)
3. Calcolate tutte le derivate rispetto a $$z$$, si applica una trasformazione lineare e si ottengono le derivate rispetto i parametri

#### Aggiornamento
Fase di aggiornamento dei parametri con le derivate calcolate nella propagazione.  
Per calcolare le derivate è comune usare il gradient descent (metodo numerico iterativo), simile a Newton Raphson (senza la derivata seconda e l'intensità della derivata prima è regolata dal parametro $$\eta$$ learning rate).  
$$W_{i+1}^{(l)}=W_t^{(l)}-\eta \cdot \Delta D (W_t^{(l)})$$  
dove $$\Delta D\left ( W^{(l)} \right ) = \frac{1}{n} \sum_{i=1}^n \delta_i^{(l)} (W)$$  

La parte di propagazione (step derivate) viene effettuata su tutte le osservazioni, successivamente viene fatta la media dei gradienti ottenendo $$\Delta D$$ da inserire nel gradient descent. Dopo di che si può effettuare lo step di aggiornamento.  
Questo modo di procedere è lento perché l'aggiornamento avviene soltanto dopo aver analizzato l'intero dataset. Il "mini-batch" o stochastic gradient consente di superare questo problema.  

Un approccio per velocizzare l'identificazione del parametro di regolazione $$\eta$$ learning rate, può essere quello di valutarlo solo sulla prima epoca così da velocizzare l'identificazione dei parametri di regolazione.  

Una tecnica per esplorare velocemente lo spazio dei parametri di regolazione è la Bayesian Hyper-Parameter Optimization, che funziona molto meglio rispetto la semplice Grid Search.  

#### Stochastic Gradient Descent (SGD)
Per ogni epoca (permutata casualmente)  
si divide il dataset in $$K$$ batch (sottoinsiemi del dataset, generalmente di numerosità 32/64/.. record) e per ogni batch
1. calcolo del gradiente per le osservazioni all'interno del batch
2. calcolo della media del batch
3. step di aggiornamento

Si ottengono così $$K$$ aggiornamenti. La permutazione dei dati ad ogni epoca prima della creazione dei batch consente di avere batch differenti in ogni epoca.  

Vantaggi:  
- Tempi di training più veloci
- Caricando i dati a blocchi si hanno meno problemi di memoria
- Maggiore variabilità delle stime con meno osservazioni e più aggiornamenti, consente di esplorare maggiormente lo spazio parametrico e ridurre la probabilità di fermarsi in minimi locali


##### Adaptive Learning Rate
Utilizzano learning rate adattivi in base ai parametri scelti.  
Esempi: Adagrad, Adadelta, RMSprop, Adam

##### Learning Rate Schedules
Si predefinisce un percorso (es scheduling ciclico) di aggiornamento del learning rate nel corso delle epoche per ridurre la probabiltà di rimanere in minimi locali.

### Funzioni d'attivazione per gli strati intermedi

#### Sigmoidale
Funzione logistica  
$$f(z)=\frac{1}{1+e^{-z}}$$  

#### Tangente iperbolica
$$tanh(z)=\frac{e^{z}-e^{-z}}{e^{z}+e^{-z}}=2 \cdot f(2z) - 1$$  

Problema 1: il codominio delle precedenti funzioni d'attivazione è vincolato a $$[0,1]$$. I lunghi asintoti creano poca sensibilità di variazione per valori del dominio lontani da $$0$$.  
Problema 2: "scomparsa del gradiente" in fase di stima. Quando i valori di $$z$$ si avvicinano agli assintoti orizzintali della funzione di attivazione il gradiente tende a 0. Questo accade spesso con più strati latenti.  

#### ReLU
Rectified Linear Unit.  
Consente di superare i problemi della funzione d'attivazione sigmoidale e tangente iperbolica.  

ReLU: $$g(z)=z_+=max(0,z)$$  

Vantaggi:  
- non è una funzione di attivazione limitata nel codominio ed è quindi più sensibile
- la derivata è $$1$$ per $$z>0$$ e $$0$$ altrimenti, quindi per circa la metà dei nodi della rete l'aggiornamento dei parametri avviene sempre e gli altri no. Assicura che il gradiente si propagherà sempre.
- computazionalmente semplice
- introduce una sparsità dei nodi: nel caso in cui si hanno un numero di nodi più alto di quello che si ha bisogno, è probabile che assegni $$0$$ alle relazioni ridondanti. Con le funzioni precedenti tutti i nodi devono essere diversi da zero, andando in contro a ridondanza.  

È analoga alla funzione 'parte positiva' delle splines (come funzione di base) e MARS.  

### Limitare l'overfitting
Per la scelta del modello ottimale bisogna trovare il giusto compromesso tra varianza e distorsione.  

#### Tuning architettura
Si regola la complessità del modello (nodi e strati latenti) in funzione della minimizzazione dell'errore di CV.

#### Early Stopping
Con l'avanzare delle epoche nel training set l'errore si riduce mentre nell'insieme di verifica l'errore andrà a risalire rischiando il sovradattamento.  
L'idea è di bloccare l'algoritmo di backpropagation nel momento in cui l'errore nell'insieme di verifica è minimo.  

#### Penalizzazione
$$\hat{W}=\text{arg}\,\min \left \{ \frac{1}{n} \sum_{i=1}^n D \left [ y_i, f(x_i;W) \right ] + \lambda J(W) \right \}$$  
con $$J(W)$$ termine di regolarizzazione non negativo e $$\lambda \ge 0$$ parametro di regolarizzazione.  
La penalizzazione comprime i parametri verso lo zero, maggiore è $$\lambda$$ maggiore è lo shrinkage dei parametri, incrementando la distorsione e riducendo varianza.

##### Weight decay
Il Weight decay o penalità $$L_2$$ è una penalizzazione diffusa.  
$$J(W)=\frac{1}{2} \vert \vert W  \vert  \vert ^2_2 = \frac{1}{2} \sum_{l=1}^{L-1} \sum_{i=1}^{p_l} \sum_{i=1}^{p_{l+1}} \left ( w_{ij}^{(l)} \right ) ^2$$  
è la norma quadratica dei pesi (analogia alla regressione ridge).  

Si può applicare una correzione al gradient descent consentendo di ottenere facilmente un risultato analogo all penalità $$L_2$$.  

#### Dropout
Ad ogni epoca (iterazione) cambia la configurazione della rete.  
Sia $$p$$ (parametro di regolazione) la probabilità di conservare (o escludere) un nodo dal processo di training per quella determinata epoca.  
Si ottiene un risultato simile agli Ensemble methods che combinano classificatori deboli.  
Funziona bene con un numero elevato di osservazioni.  


## Convolutional Neural Network
Generalmente applicata ad immagini.  

Tensore: è una struttura spesso considerata come la generalizzazione a $$d$$ dimensioni delle matrici. La dimensione del tensore è definito rango. Non è soltanto una matrice più ampia, ma gode di alcune proprietà che rendono le dimensioni interdipendenti.  
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) Nell'algebra multilineare e nel calcolo tensoriale, si definisce covariante il cambio effettuato ad un nodo (dimensione) che rende i pesi un 'tensore controvariante'.  

Un'osservazione, nel caso delle immagini, si converte in un tensore a 3 dimensioni: le prime due legate alle coordinate dei pixel, se l'immagine è in bianco e nero si ha solo una dimensione in profondità e quindi la struttura è una matrice con i valori che rappresentano le tonalità di grigio, se è a colori la terza dimensione è un vettore di 3 elementi RGB (tensore tridimensionale, come se fossero tre matrici).  

### Parte convoluzionale
Alternanza tra convoluzione e pooling.

#### Strato convoluzionale
Lo strato è composto da $$p$$ trasformazioni dell'immagine tramite l'operazione di convoluzione che applica dei filtri (che contengono i parametri).


##### Convoluzione
Input tensore $$k\times k \times 3$$ rappresentante l'immagine.  
Il tensore viene trasformato da un filtro (kernel) $$q\times q$$ generando un output $$k\times k \times 1$$, come se il filtro fosse una lente d'ingrandimento e si esplorano tutte le porzioni del tensore (es. 3x3 o 5x5 pixel alla volta), sintetizzandole in un solo pixel (con un prodotto interno tra il filtro e la porzione di riferimento).  
L'operazione viene ripetuta per tutti e $$p$$ filtri, generando un tensore $$k\times k \times p$$.  
Parametri di regolazione: numero e dimensione dei filtri.  


#### Strato di pooling
L'output dello strato convoluzionale è l'input dello strato di pooling.  
L'immagine viene divisa in una griglia (spesso a celle da 4 pixel) di piccole tante immagini e viene preso il valore massimo per ciascuna cella. Così riducendo il numero di parametri.  

I primi strati di pooling consentiranno di concentrarsi su dettagli grafici più specifici, all'aumentare del numero di pooling l'immagine sarà meno dettagliata e la rete si concentrerà sugli aspetti generici dell'immagine.  


### Parte fully connected
Come una feed-forward neural network


## Recurrent Neural Network
FFNN con strati ricorrenti.  

Strato ricorrente:  
prende le osservazioni in input e genera degli output (hidden state) applicando una trasformazione.  
La caratteristica è che ciascun output è di input per lo strato successivo ma dipende sequenzialmente dal precedente output dello stesso strato, permettendo così di modellare una dipendenza tra le osservazioni.  
$$h_t = \tanh{(W\cdot x_t + U \cdot h_{h-1} + b)}$$  

Per una dipendenza temporale più lunga (e non markoviana), la propagazione della dipendenza non avviene facilmente. Per ovviare ciò si è sviluppato il layer Long-Short Term Memory (LSTM).  

### LSTM
La connessione tra gli output dello stesso strato verrà influenzato sia dall'hidden state che dal cell state.  
Il cell state permette di propagare la dipendenza.  

### NLP
Per l'analisi del testo viene inserito uno strato di embedding.  







<!---
entailment: due frasi capire se sono in accordo disaccordo neutrali

detect anomalies: considera ogni carta di credito come una sequenza temporale
--->






## Utili

### Risorse
- The Elements of Statistical Learing [ESLII](https://web.stanford.edu/~hastie/ElemStatLearn/printings/ESLII_print12_toc.pdf)
- An Introduction to Statistical Learning [ISLR](https://www.statlearning.com/)

