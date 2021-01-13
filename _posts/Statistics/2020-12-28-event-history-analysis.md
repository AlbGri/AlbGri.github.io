---
title: "Statistics: Event History Analysis"
excerpt: "note"
date: 2021-01-03
tags: [statistics, math, theory, university, SAS]
mathjax: "true"
---

*in costruzione*


## Metodi per l'analisi di dati di durata

### Basi dell'analisi dei dati di durata

#### Concetti base

##### Ambiti ed esempi

##### Definizioni base
- Dominio, evento, episodio, popolazione a rischio
- Caso semplice: 1 episodio, 1 stato destinazione
- Multistato o rischi competitivi: 1 episodio, 2+ stati destinazione
- Multi-episodio: 2+ episodi, 1 stato destinazione
- Multistato e multi-episodio

##### Modellazione specifica
- Limiti modello lineare
- Censure (tipo I, II, random-non informative che non dipendono dal rischio, random-informative che dipendono dal rischio)
- Covariate (variabili o costanti rispetto il tempo)

##### Disegni longitudinali retrospettivi
- Indagini retrospettive

##### Disegni longitudinali prospettivi
- Panel (con waves)
- Studi di follow-up (studi coorte)
- Record-Linkage

#### Funzioni base nel continuo e nel discreto

##### Funzioni base con tempo continuo
- Condizioni
- Densità, Ripartizione, Sopravvivenza
- Funzione di rischio
- Rischio integrato
- Relazioni tra le funzioni

##### Funzioni base con tempo discreto
- Discreto
- Continuo discretizzato

#### Tipologie di metodi

##### Metodi per tempo continuo
- Metodi non parametrici: Kaplan-Meier (Product-Limit)
- Modelli di regressione: PH, AFT

##### Metodi per tempo discreto
- Metodi non parametrici: Life Table (Actuarial Method)
- Modelli di regressione: Logit, Probit

### Metodi non parametrici

#### Kaplan-Meier (Product Limit)
- Calcolo delle funzioni e indici
    1. Siano $$n=6$$ episodi di durata $$(4,3*,6,6*,10,18)$$
    2. Rappresento sull'asse T gli episodi nel seguente modo  
    ![png](/assets/images/Statistics/EHA_KM1.png)
    3. Siano:
        - $$R_j=N-\sum_{k=1}^{j-1}(C+E)_k$$ i soggetti a rischio di sperimentare l'evento in quel punto  
        - $$\hat{q}_j=\frac{E_j}{R_j}$$ la probabilità di sperimentare l'evento  
        - $$\hat{p}_j=1-\hat{q}_j$$ probabilità di non sperimentare l'evento  
        - $$\hat{S}_j=\prod_{k=1}^{j-1}\hat{p}_k$$ la sopravvivenza nel punto
    4. Si calcola quanto segue  
    ![png](/assets/images/Statistics/EHA_KM2.png)
    5. Si sintetizzano le informazioni  
    ![png](/assets/images/Statistics/EHA_KM3.png)
    6. Si rappresenta la sopravvivenza
- Esplorazione forma del rischio
- Funzione di sopravvivenza
	- Analisi quantili
	- Confronto tra gruppi
	- Test di omogeneità (grafico, log-rank rest, wilcoxon test)
- Funzioni di pseudo-sopravvivenza per rischi competitivi

####  Life Table (o Attuariale)
- Tavola di eliminazione: stima rischio, probabilità e sopravvivenza
- Altre funzioni (es. rischio integrato)
- Intervalli di confidenza



### Modelli a tempo continuo

#### Modelli semi-parametrici

##### Modello base
- Caratteristiche modello di Cox
- Significato PH (Proportional Hazard)

##### Parametri e risk score
- Interpretazione parametri
- Significatività statistica dei parametri
- Risk score

##### Bontà adattamento modello
- Rapporto di verosimiglianza
- AIC e BIC

##### Modello a rischi competitivi

##### Stima di massima verosimiglianza 
- Metodo FL (Full Likelihood - “Qual è la probabilità che l'individuo i-mo sperimenti un evento nel $$t_j$$ osservato?'')
- Complicazioni: censure e rischio base
- Metodo PL (Partial Likelihood - “Dato che qualcuno sperimenta un evento al tempo $$t_j$$ qual è la probabilità che si tratti dell'individuo i-mo?'') basato sui rank dei tempi
- Massimizzazione PL con metodi numerici iterativi

##### Ties
- Exact (tutti i possibili ordinamenti)
- Breslow (come Exact ma shrinkage to 0 se ci sono molti ties)
- Efron (come Breslow ma più vicino all'Exact)
- Discrete (eventi effettivamente doppioni)

##### Stima e utilizzo delle funzioni base

##### Variabili tempo-dipendenti
- Caratteristiche VTD
- Modello con VTD
- Come tenere sotto controllo variabili TD
- Spazio stati TD
- Effetti immediati o differiti nel tempo

##### Effetti non proporzionali
- Violazione assunzione proporzionalità
- Verifica proporzionalità 
	- Analisi grafica del logaritmo del rischio cumulato  
	$$\log{(H)}=\log{(-\log{(s)})}$$
	- Residui di Schoenfeld (l'andamento dello scarto tra la covariata dell'i-esimo individuo e la sua media nel tempo è casuale)
	- Modello con interazione tra tempo e covariate (se il coeff. dell'interazione è significativamente diverso da zero)
- Superamento ipotesi proporzionalità
	- Modello stratificato ($$n$$ rischi di base quanti gli strati)
	- Modelli separati in strati ($$n$$ modelli quanti gli strati, con $$\mathcal{X}^2$$ saggio se gli $$n$$ modelli sono uguali a quello compatto)  
	$$\mathcal{X}^2_{(k-1)p}=\bigg[-2LL_{\mbox{stra}}-\Big[\sum_{i=1}^n(-2LL_{\mbox{sep}_i})\Big]\bigg]$$  
	con $$k=\mbox{n.strati}$$ e $$p=\mbox{n.predittori}$$
	- Modello con interazione tra il tempo e le covariate. 
	    - Tempo continuo
	        - Effetto lineare
	        - Effetto lineare traslato
	        - Effetto logaritmico (il parametro rappresenta la variazione del log rischio a raddoppi della durata, se il logaritmo è in base 2)
	    - Tempo discreto
	        - Main effect: effetto principale + parte lineare con dummy dell'intervallo (consente di capire se un tratto è significativamente diverso dall'altro) 
	        - Effetto a gradini: lineare con $$k$$ dummy pari al numero di intervalli senza effetto principale (l'effetto potrebbe essere significativamente diverso da quello di base ma non è strettamente non proporzionale perché non è detto che i coefficienti che si stimano siano significativamente diversi da quelli stimati nel tratto precedente)



#### Modelli parametrici

##### Calcolo delle funzioni di densità, sopravvivenza e rischio
- Trasformazioni utili:  
$$\log{X}\sim\mathcal{N}(\mu,\sigma^2)\Rightarrow X\sim\log{\mathcal{N}(\mu,\sigma^2)}$$  
$$S(t)=\mbox{Pr}\{T\ge t\}=1-F(t)=\int_t^{+\infty}f(x)dx=\exp{\Big\{-\int_0^t h(x)dx\Big\}}$$  
$$h(t)=\frac{-d[S(t)]}{dt}/S(t)=\frac{f(t)}{S(t)}=-\frac{d}{dt}\log{S(t)}$$  
$$H(t)=\int_0^t h(x)dx$$  
$$\mu=\int_0^\infty S(t)d(t)$$  
- Possibili forme funzionali: 
    - Esponenziale  
    $$f(t)=a\cdot \exp{(-at)}\mbox{ con }a>0$$  
    $$S(t)=\exp{(-at)}=\exp{\big\{-H(t)\big\}}$$  
    $$h(t)=a$$ Rischio costante, memorylessness distribution  
    $$H(t)=-\log{S(t)}=at$$ (area sottostante '$$a$$' fino a $$t$$)  
    Test grafico su Esponenziale: se l'andamento $$H(t)$$ vs $$t$$ è una linea retta che parte dall'origine allora i dati approssimano bene una durata esponenziale (quindi $$b=1$$).  
    $$F(t)=1-\exp{(-at)}$$  
    $$\log{S(t)}=-at$$  
    - Weibull  
    $$f(t)=abt^{b-1}\exp{(-at^b)}$$ con  
    $$a$$ (livello o scala), $$b>0$$ (forma), se $$b=1$$ Esponenziale  
    $$S(t)=\exp{(-at^b)}$$  
    $$h(t)=abt^{b-1}$$ Rischio costante se $$b=1$$, monotono crescente se $$b>1$$, monotono decrescente se $$b<{1}$$  
    $$H(t)=-\log{S(t)}=at^b$$  
    Test grafico su Weibull: se l'andamento $$\log{H(t)}$$ vs $$\log{t}$$ è una retta con intercetta $$\log{a}$$ e pendenza $$b$$  
    - Gompertz e Gompertz-Makeham (utile per mortalità con pochi casi)  
    $$h(t)$$ Rischio monotono  
    - Log-logistica  
    $$h(t)$$ Rischio monotono decrescente o unimodale  
    - Hernes, Sickle, Coale-McNeil  
    $$h(t)$$ Rischio unimodale  
    - Altre: Log-normale, Gamma, Gamma generalizzati  

##### Modelli di regressione parametrici
- Parametrizzazione a Rischi Proporzionali (PH)
    - La variabile dipendente è la funzione rischio (come Cox ma con baseline parametrico):  
    $$h_i(t,X_i)=h_0(t)\cdot \theta$$  
    - Trasformazioni utili  
    $$S(t)=S_0(t)^\theta$$  
    $$f(t)=f_0(t)\cdot S_0(t)^{(\theta-1)}\cdot\theta$$  
    $$H(t)=H_0(t)\cdot\theta\quad\mbox{ con }H_0(t)=-\log{S_0(t)}$$  
- Parametrizzazione a Tempi Accelarati (AFT)  
    - Si ha un effetto moltiplicativo, non più sul rischio, ma sul tempo di permanenza nello stato pre-transizione:  
    $$T_i=T_0\cdot \gamma$$ con $$\gamma$$ fattore di accelerazione, e se è $$>1$$ aumentano i tempi di sopravvivenza e il rischio diminuisce  
    - Trasformazioni utili  
    $$S(t,X)=S_0\big(\frac{t}{\gamma}\big)$$  
    $$h(t,X)=h_0\big(\frac{t}{\gamma}\big)/\gamma$$  
    $$f(t,X)=h_0\big(\frac{t}{\gamma}\big)/\gamma\cdot S_0\big(\frac{t}{\gamma}\big)=f_0(t)/\gamma$$  
- Specifiche parametrizzazioni per specifici modelli  
    - Weibul (Esponenziale): sia PH che AFT  
    - Gompertz: PH  
    - Log-normale, Log-logistico, Gamma generalizzati: AFT  

##### Parametr. PH e AFT per i modelli Esponenziale, Weibull ed Esponenziale a tratti
- Esponenziale
    - Funzioni utili  
    $$T\sim\mathcal{Exp}(a)\sim\mathcal{W}(a,\sigma =1)$$  
    $$lim_{t\rightarrow\infty}S(t,a)=0$$ eventi inevitabili  
    $$E(T)=\frac{1}{a} \qquad Var(T)=\frac{1}{a^2}$$  
    $$t_{\mbox{quantile}_q}=-\log{(q)}\cdot E(T)$$ (es. mediana $$t_{ME}=0.693/a$$)  
    $$h(t,a_k)=a_k$$ se 1 episodio, più destinazioni (rischi competitivi), con $$a_k$$ tasso di transizione (costante) verso destinazione $$k$$
    - PH (stimo il rischio assoluto)  
    $$h(t,X)=\exp{\beta_0}\cdot\exp{(\beta X)}=h_0\cdot\exp{(\beta X)}$$  
    Si noti che $\exp{(\beta X)}$ è il Rischio Relativo nel caso di $$X=1$$ (dummy)  
    Rispetto i modelli di Cox: $$h_0$$ è parametrico e il rischio non dipende dal tempo  
    Per leggerli in ottica di durata media: $$E(T\vert X=k)=\frac{1}{h(t\vert X=k)}$$
    - AFT (stimo la durata media)  
    $$T=\big[\exp{(\alpha_0)}\cdot\exp{(\epsilon)}\big]\cdot\exp{(\alpha X)}=T_0\cdot\gamma$$  
    Si dimostra che per l'esponenziale $$\alpha=-\beta$$  
    $$\alpha$$ stimato è il logaritmo della durata relativo alla variabile $$X$$  
    $$\exp{(\alpha_0^{AFT})}=\exp{(-\beta_0^{PH})}=1/\exp{(-\beta_0^{PH})}=1/h_0^{PH}=E(T_0)$$  
- Weibull  
    - PH  
    $$h(t\vert X)=\big[\exp{(\beta_0)}\cdot bt^{b-1}\big]\cdot\exp{(\beta X)}=h_0(t)\cdot\exp{(\beta X)}$$
    - AFT  
    $$\log{T}=\alpha_0+\alpha X+\sigma\epsilon$$  
    $$T=\exp{(\alpha_0+\sigma\epsilon)}\cdot\exp{(\alpha X)}=T_0\cdot\gamma$$  
    Si dimostra che $$\beta=\beta_{PH}=-\beta_{AFT}\cdot b=-\alpha\cdot b$$  
    NB. SAS stima modello Weibull solo AFT con $$\sigma=1/b\Rightarrow\beta_{PH}=-\beta_{AFT}\cdot (1/\sigma)$$  
    Inoltre, con $$a=\exp{(-\beta_{AFT}\cdot b)}$$ si ricava facilmente $$h(t)=\exp{(-\beta_{AFT}\cdot 1/\sigma)}\cdot 1/\sigma\cdot t^{(1/\sigma -1)}$$, così da ottenere il rischio dopo $$t$$ durate  
- Esponenziale a tratti (Piecewise exponential model)  
Per $$L$$ sotto-intervalli del tempo si specificano diverse distribuzioni parametriche del rischio.
    - Funzioni utili  
    $$h(t_j)=\sum_j^L a_j I_j$$ con $I_j$ variabile dummy che vale $$1$$ nel $j-$esimo intervallo. Rischio costante a tratti, con valori di $$a$$ differenti per ogni intervallo.   
    $$h(t_j,X)=a_j=\exp{(\beta_{0j}+\beta_j X)}\mbox{ con }j=1,...,L$$ è un modello a rischi non proporzionali, varia ad ogni intervallo. Se $$\beta_j=\beta$$ è a rischi proporzionali.  
    NB. in SAS la significatività di J è con Wald, in cui si saggia se il rischio è costante  
    NB. in SAS exp(-coeff.) è il valore del rischio relativo rispetto al $$j-$$esimo tratto  

##### Stima di massima verosimiglianza (da gestire le censure)  
- durate censurate senza covariate, siano $$C$$ i casi non censurati e $$E=N-C$$ i casi censurati:  
$$L(a,t_1,t_2,...,t_N)=\prod_{i\in E}f(t_i,a)\cdot \prod_{i\in C}S(t_i,a)$$  
poiché $$f=S\cdot h\rightarrow L(a,t_1,t_2,...,t_N)=\prod_{i\in E}h(t_i,a)\cdot \prod_{i\in N}S(t_i,a)$$  
Ottengo la log-verosimiglianza, derivo rispetto ad $$a$$, pongo uguale a $$0$$ e ottengo le stime.  
Nel caso di esponenziale:  
$$\hat{a}=\frac{E}{\sum_{i\in N}t_i}=$$ rapporto tra numero di eventi (casi non censurati) e totale dei tempi $$t_i$$ dell'intero campione (sia censurati che non)  
$$\hat{E}(t)=\frac{1}{\hat{a}}=$$ durata media intervallo



## Modelli Frailty
Frailty models o Mixed Proportional Hazard models (misti si intende con effetti fissi e casuali).

### Introduzione al concetto di Frailty

#### Problema
Limitare il problema della mal specificazione del modello e distorsione delle stime, aggiungendo un effetto casuale sui modelli di regressione sul rischio.  
Anche con covariate indipendenti tra loro, se una delle due è omesse andrà ad impattare le stime _selezionando_ la popolazione e rendendo le stime dipendenti dal tempo.  
La presenza di una _fragilità_ differente tra i gruppi - eterogeneità non osservata - comporta una variazione del rischio; i modelli tradizionali di Survival Analysis considerano le popolazioni omogenee, cioè che tutti gli individui hanno lo stesso rischio.  
- Funzione di sopravvivenza marginale per due popolazioni esponenziali $$(\lambda_i)$$  
$$S(t)=p\exp{(-\lambda_1 t)}+(1-p)\exp{(-\lambda_2 t)}$$ è una mistura

#### Variabile Frailty
Sia $$U>0$$ v.a. indipendente dal tempo, la cui varianza $$\sigma^2_U$$ misura l'eterogeneità non osservata della popolazione. Siano $$\mathbf{X}=(X_1,...,X_k)$$ matrice delle covariate e $$\mathbf{\beta}=(\beta_1,...,\beta_k)$$ parametri di regressione.
- Funzione di rischio  
$$h(t\vert U)=h_0(t)\cdot U$$  
$$h(t\vert X, U)=h_0(t)\exp{(\beta 'X)}\cdot U$$  
- Rischio marginale  
$$E_U\{h(t\vert U)\}=h_0(t)\cdot E_U\{U\}=h_0(t)$$  
- Funzione di sopravvivenza  
$$S(t\vert X,U)=\exp{\big\{-\int_0^t h(s\vert X,U)ds\big\}}$$
- Sopravvivenza marginale  
$$S(t)=E\big[S(t\vert U)\big]=E\big[\exp{\{-UH_0(t)\}}\big]=\mathbf{L}\big\{H_0(t)\big\}$$  
- Trasformata di Laplace  
$$L\mathbf{L}=\int e^{-zu}\cdot f(u)du$$
- La varianza della frailty può avere un valore contenuto e può modificare significativamente sia le covariate e che la forma del rischio

#### Distribuzione della Frailty

##### Gamma
- Caratteristiche  
- Funzioni  
$$...$$  
- Laplace esplicita  
$$\mathbf{L}=\big(1+\frac{z}{\gamma}\big)^{-k}$$  
- Sopravvivenza marginale  
$$...$$  
- Rischio marginale  
$$...$$  

##### Log-normale
- Caratteristiche  
- Funzioni  
$$...$$  
- Laplace non-esplicita

#### Modello Gamma-Gompertz
Modello parametrico con distribuzione Gamma-Gompertz o modello Gompertz con frailty Gamma. La distribuzione esponenziale è un caso specifico. La distribuzione descrive bene i tassi di mortalità (principalmente 30-80 anni).
- Caratteristiche  
$$...$$  
- Funzione di rischio  
$$...$$  
- Funzione di rischio con frailty Gamma (avrà forma logistica con un plateau finale)  
$$...$$  
- Rischio marginale  
$$...$$  

### Modelli Frailty Univariati

#### Modello parametrico
- Verosimiglianza (non si può massimizzare perché non si conosce la frailty)
- Verosimiglianza marginale (è una pseudo verosimiglianza, utile per ottenere le stime MV, 'liberandosi' dell'influenza della frailty)
- Integrazione della verosimiglianza marginale
    - Trasformazione di Laplace non-esplicita: integrazione numerica (approssimazione di Laplace, quadratura Gaussiana)
    - Trasformazione di Laplace esplicita

##### Esempio su R
Con le librerie [survival](https://cran.r-project.org/web/packages/survival//survival.pdf) e [parfm](https://cran.r-project.org/web/packages/parfm/parfm.pdf).
```R
## Speed-time tra modelli parametrici con frailty e 
# laplace esplicita (gamma) e non-esplicita (log-normale)
## SAS usa sempre e solo la procedura iterativa non
# utilizzando i vantaggi analitici della Laplace
```


```R
# libs
library(survival)
library(parfm) # parametric frailty models
```


```R
# df
data(kidney)
kidney$sex <- kidney$sex - 1
```


```R
# modello parametrico Weibull con frailty distribuzione gamma
system.time(
    parfm(Surv(time,status)~sex+age+as.factor(disease), 
          cluster="id", data=kidney, 
          dist="weibull", frailty="gamma"))
```


       user  system elapsed 
      4.606   0.001   4.639 



```R
# modello parametrico Weibull con frailty distribuzione log-normale
system.time(
    parfm(Surv(time,status)~sex+age+as.factor(disease), 
          cluster="id", data=kidney, 
          dist="weibull", frailty="lognormal", 
          method="Nelder-Mead", maxit=2000))
```


       user  system elapsed 
     11.775   0.000  11.784 



```R
# modello parametrico Weibull con frailty distribuzione normale inversa
system.time(
    parfm(Surv(time,status)~sex+age, 
          cluster="id", data=kidney, 
          dist="weibull", frailty="ingau"))
```


       user  system elapsed 
      2.060   0.000   2.062 



```R
# modello parametrico Weibull con frailty positive stable
system.time(
    parfm(Surv(time,status)~sex+age, 
          cluster="id", data=kidney, 
          dist="weibull", frailty="possta", 
          method="Nelder-Mead"))
```


       user  system elapsed 
      3.229   0.000   3.231 




#### Modello semi parametrico
- Rischio base non specificato
- Fattorizzazione della verosimiglianza

##### Failty note
- Verosimiglianza parziale (utile per ottenere le stime MV, 'liberandosi' dell'influenza della frailty)

##### Frailty non-note
- Algoritmo EM (Expectation-Maximization) con la verosimiglianza parziale, considerando come se le frailty fossero i dati mancanti (cfr EM)
    - Frailty Gamma
    - Stima di Nelson-Aalen del rischio cumulato di base
    - Valore atteso di $$\log{U}$$ con distribuzione log-Gamma  
- Verosimiglianza penalizzata
    - Frailty log-normale
    - Frailty Gamma (stessi risultati di EM)
    - Funzione di rischio
    - Verosimiglianza parziale penalizzata

### Shared Frailty Models
Sono l'equivalente, nell'ambito dei modelli di durata, dei modelli multilevel con gli individui (unità di primo livello) all'interno di gruppi (unità di secondo livello).

#### Univariati vs Shared

##### Mod. univariati
- Assegnano ad ogni individuo un livello di "fragilità"
- Mirano a tenere sotto controllo l'eterogeneità non osservata

##### Mod. shared
- Assegnano un livello di fragilità comune a un gruppo di unità statistiche
- Mirano a tenere sotto controllo la correlazione intraclasse, cioè la correlazione tra gli individui che appartengono agli stessi gruppi

#### Funzioni
- Funzione di rischio
- Sopravvivenza congiunta
- Sopravvivenza marginale per le unità appartenenti al $i-$esimo gruppo
- Legami con frailty e la trasformata di Laplace
- Inferenza analoga ai modelli univariati






<!---

### Modelli a tempo discreto
#### Person Period
#### Modello a odds proporzionali


## Modelli Multilevel
### Il modello Multilevel come pooling parziale dei dati
### Modelli a risposta continua
#### Modelli a intercetta casuale
#### Modelli a effetti casuali
#### Inferenza per effetti fissi e per effetti casuali
### Modelli a risposta discreta
#### Modelli logistici a effetti casuali
#### Modelli a tempo discreto con effetti casuali
#### Inferenza per effetti fissi ed effetti casuali.

--->


## SAS Labs - Parte 1
<button class="collapsible" id="es001">Esempio 1: LT e KM (0)</button>
<div class="content" id="es001data" markdown="1">

	```sas
	/*******************************************************
	Obiettivo: 
	analizzare andamento uscita mercato del lavoro con LT e KM
	*******************************************************/
	* genero il df;
	data dati;
	input time cens;
	cards;
	0.1 1
	0.2 1
	0.5 0
	0.5 1
	0.7 1
	0.8 1
	1.3 1
	1.5 1
	1.8 0
	2.5 1
	2.5 1
	2.5 0
	3.2 1
	3.7 1
	3.8 0
	;
	run;

	* stima LT;
	proc lifetest 
	data=dati
	method= lt
	intervals= 1 2 3 4
	plots =(s h) graphics  /* se una sola funzione non serve () */
	outsurv=conf1;
	time time*cens(0);
	title “analisi LT durata episodi”;
	run;

	* stima KM;
	proc lifetest 
	data=dati
	plots =(s h) graphics  
	outsurv=conf2;
	time time*cens(0);
	title “analisi KM durata episodi”;
	run;
	```
</div>
<embed src="/assets/images/Statistics/EHA_001.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es002">Esempio 2: LT e KM (1)</button>
<div class="content" id="es002data" markdown="1">

	```sas
	/******************************************************* 
	Obiettivo: 
	con LT e KM, esaminare se e come la propensione a lasciare il mercato 
	del lavoro differisce tra gli uomini e le donne nati tra 1929 e 1951. 
	*******************************************************/
	
	* carico df;
	libname dir "/home/dati";
	data pippo;
	set dir.rrdat1;
	durata=tfin-tstart+1;
	des=0;
	if tfin lt ti then des=1; 	* pongo=0 casi censurati;
	run;

	* stime con LT (unico gruppo//distinto per M e F);
	proc lifetest
		data=pippo
		method=life
		width=30
	plots =(s h) graphics   
	/* N.B: se più di 1 funzione (ls lls ...) usare () altrimenti: plots=s graphics */
		outsurv=conf1;
	time durata*des (0);
	/* chiedo S per maschi e femmine */
	*strata sex;
	title “analisi LT durata episodi lavoro uomini e donne”;
	run;

	* stime con KM per M e F;
	proc lifetest
		data=pippo
		plots=(s(cl) h(cl) ls) graphics
		outsurv=conf2;
	time durata*des (0);
	strata sex;
	title ”analisi KM su dati durata occupazione – M e F”; 
	symbol1 v=none color=black line=1;
	symbol2 v=none color=red line=2;
	run;
	proc print data=conf2;
	run;
	```
</div>
<embed src="/assets/images/Statistics/EHA_002.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es003">Esempio 3: Cox base (0)</button>
<div class="content" id="es003data" markdown="1">

	```sas
	/*******************************************************
	Obiettivo: 
	stimare predittori uscita mercato del lavoro tra un set covariate
	*******************************************************/

	* genero il df;
	data dati;
	input time cens edu edu1 edu2 age ;   * edu=B, M, A. age=anni compiuti;
	cards;
	0.1 1 1 1 0 20
	0.2 1 2 0 1 18
	0.5 0 3 0 0 29
	0.5 1 1 1 0 30
	0.7 1 2 0 1 17
	0.8 1 3 0 0 23
	1.3 1 1 1 0 29
	1.5 1 2 0 1 33
	1.8 0 3 0 0 25
	2.5 1 1 1 0 18
	2.5 1 2 0 1 20
	2.5 0 3 0 0 31
	3.2 1 1 1 0 35
	3.7 1 2 0 1 17
	3.8 0 3 0 0 24
	;
	run;

	* stimo modelli;
	proc phreg  data=dati;
	model time*cens (0) = edu1 edu2;  * anche class edu se..;
	title “predittori rischio uscita disoccupazione: education”;
	run;

	proc phreg  data=dati;
	class edu;  *NB ref=3, se non si specifica la class viene considerata come numerica;
	model time*cens (0) = edu;  
	title “predittori rischio uscita disoccupazione: education”;
	run;

	proc phreg  data=dati;
	model time*cens (0) = edu1 edu2 age;
	title “predittori rischio uscita disoccupazione: age & edu”;
	run;
	```
</div>
<embed src="/assets/images/Statistics/EHA_003.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es004">Esempio 4: Cox base (1)</button>
<div class="content" id="es004data" markdown="1">

	```sas
	/*******************************************************
	Obiettivo: 
	stimare predittori uscita mercato del lavoro tra un set covariate
	*******************************************************/
	
	libname dir "/home/dati";
	data pippo;
	set dir.rrdat1;
	durata=tfin-tstart+1;
	des=0;
	if tfin lt ti then des=1; 	* pongo=0 casi censurati;

	* calcolo data nascita e esamino distribuzione anno nascita;
	anno1=(tb-1)/12+1900; 
	anno2=int(anno1);  
	run;

	* verifico cosa ho ottenuto per sesso;
	proc freq;   
	table anno2*sex;  
	run; 
											
	* costruisco covariate necessarie per modello;
	data pluto;
	set pippo;

	* coorte nascita categoriale;
	coorte=3;
	if anno2 le 1931 then coorte=1;
	if anno2 ge 1939 and anno2 le 1941 then coorte=2;

	* coorte nascita dummy: coho1 = reference group 1929-31;
	coho2=0; coho3=0;
	if tb ge 468 and tb le 504 then coho2=1;      * nati tra 1939-41;
	if tb ge 588 and tb le 624 then coho3=1;      * nati tra 1949-11;
	* ALTERNATIVAMENTE DUMMY USANDO DIRETTAMENTE COORTE OPPURE ANNO2;

	* altre variabili utili;
	pnoj=noj-1;                 * numero lavori precedenti;
	lfx=tstart - te;            * esperienza lavorativa;
	run;

	*STIMO MODELLO COX - uso dummy coorte in model - NO SEX;

	proc phreg  data=pluto;
	model durata*des (0) = edu coho2 coho3 lfx pnoj pres;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;
	
	/* Nostre ipotesi: 
	- se l'istruzione è bassa accelera l'uscita dal mondo da lavoro 
	- Il prestigio del lavoro accelera o rallenta l'uscita? Probabilmente ritarda
	
	Risultati:
	- tranne il numero di episodi è tutto significativo
	- per ogni anno aggiuntivo di educazione il rischio di lasciare il posto di lavoro aumenta del 6%,
	l'ipotesi potrebbe essere che chi ha un educazione alta ha anche un ambizione maggiore e lo lascia
	con più facilità.
	- la coorte2 e 3 aumenta il rischio (51% e 36%), diventano più mobile, rispetto il gruppo di base, 
	si può prendere in riferimento la coorte2 e capire se la 3 è significativamente diverso
	- all'aumentare dell'esperienza lavorativa diminuisce per ogni mese il rischio di uscire
	- all'aumentare del prestigio del lavoro, diminuisce la propensione ad abbandonare quel lavoro */
	
	*L'esercizio successivo è con la variabile SEX;
	```
</div>
<embed src="/assets/images/Statistics/EHA_004.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es005">Esempio 5: Cox base (2)</button>
<div class="content" id="es005data" markdown="1">

	```sas
	/*******************************************************
	Obiettivo: 
	stimare predittori uscita dal mercato del lavoro tra un set 
	covariate separatamente per maschi e femmine (Ci sono effetti 
	delle covariate che interagiscono con il genere?)
	*******************************************************/
	
	libname dir "/home/dati";

	* con data dir.pippo rendo permanente il df;
	data dir.pippo;
	set dir.rrdat1;
	durata=tfin-tstart+1;
	des=0;
	if tfin lt ti then des=1; 	* pongo=0 casi censurati;

	* calcolo data nascita e esamino distribuzione anno nascita;
	anno1=(tb-1)/12+1900; 
	anno2=int(anno1);  

	* coorte nascita categoriale;
	coorte=3;
	if anno2 le 1931 then coorte=1;
	if anno2 ge 1939 and anno2 le 1941 then coorte=2;

	* coorte nascita dummy: coho1 = reference group 1929-31;
	coho2=0; coho3=0;
	if tb ge 468 and tb le 504 then coho2=1;      * nati tra 1939-41;
	if tb ge 588 and tb le 624 then coho3=1;      * nati tra 1949-11;

	* altre variabili utili;
	pnoj=noj-1;                 * numero lavori precedenti;
	lfx=tstart - te;            * esperienza lavorativa;
	run;

	/* Ipotizzo interazione tra maschi e femmine, stimo due modelli distinti di Cox
	Scoprire se c'è qualche covariata che influenza in modo diverso i maschi e femmine */

	proc phreg data=dir.PIPPO;;
	WHERE SEX=1;                 /* altrimenti usare prima if */     
	model durata*des (0) = edu coho2 coho3 lfx pnoj pres;
	title “MASCHI analisi predittori rischio uscita mercato lavoro”;
	run;

	*non metto data perché prende in riferimento l'ultimo df;
	proc phreg;
	WHERE SEX=2;
	model durata*des (0) = edu coho2 coho3 lfx pnoj pres;
	title “FEMMINE analisi predittori rischio uscita mercato lavoro”;
	run;
	
	/* Confrontando i due modelli emerge che 
	- EDU è prevalente maggiormente nelle femmine
	- le coorti sono crescenti per gli uomini */

	proc phreg  data=dir.PIPPO;
	CLASS COORTE;   /*il riferimento è alla COORTE3*/
	model durata*des (0) = edu COORTE lfx pnoj pres;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;
	proc phreg  data=dir.PIPPO;
	CLASS COORTE (REF=FIRST);   /*RIF=COORTE1*/
	model durata*des (0) = edu COORTE lfx pnoj pres;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;

	/* dato quello che era emerso su SEX ed EDU li aggiungo sia singolarmente
	che con la loro interazione */
	proc phreg  data=dir.PIPPO;
	CLASS COORTE (REF=FIRST);   /*RIF=COORTE1*/
	model durata*des (0) = edu COORTE lfx pnoj pres sex sex*edu;
	title “analisi predittori rischio uscita mercato lavoro”;
	run;
	/* Perde la significatività SEX e fa diventare EDU negativo
	non riusciamo a sfruttare l'interazione così com'è
	Si potrebbe rendere categoriale EDU e fare incroci con SEX */
	```
</div>
<embed src="/assets/images/Statistics/EHA_005.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es006">Esempio 6: KM e Cox base (3)</button>
<div class="content" id="es006data" markdown="1">

	```sas
	/*******************************************************
	Obiettivo: 
	con stimatore PL, si verifichi se le durate degli episodi lavorativi dipendono 
	dal tipo di progressione (verso alto, verso basso, stazionaria) nella carriera lavorativa 
	(es. progressioni verso alto sono associate a episodi lavorativi più brevi o più lunghi?)
	NB. si ha un episodio e 3 transizioni: processo multistato (o rischi competitivi)
	*******************************************************/

	libname dir "/home/dati";
	data PLUTO;
	set dir.PIPPO;

	* analisi rischi competitivi: definisco le destinazioni ; 
	desn=2;	         			                  /* laterale */
	if (presn/pres -1)  >= 0.20   then desn=1;    /* salita */
	if (presn/pres -1)<0          then desn=3;    /* discesa */
	if presn = -1                 then desn=0;	  /* censura=ultimo lavoro (censurato o meno)*/
	run;

	*creo PAPERINO con lavori <65;
	data paperino;
	set pluto;
	if pres < 65;     /*elimino i lavori con punteggio alto perché non possono andare verso l'alto*/
	run;

	* Stimo KM per ognuno dei tre movimenti;
	* KM-Movimenti in salita;
	proc lifetest
		data=paperino  /* movimenti in salita */
		plots=(s ) graphics  nocensplot notable;
	/* NOPRINT: sopprime il display dell'output - 
	NOCENSPLOT sopprime dal grafico i casi censurati
	NOTABLE: sopprime il display delle stime di S. 
	Only the number of censored and event times, plots, 
	and test results is displayed. 
	OUTSURV=SAS-data-set oppure OUTS=SAS-data-set: 
	crea un output SAS data set che contiene le stime di S
	 and corresponding confidence limits for all strata */

	* includo i censurati 0, più quelli che vanno in direzione diversa;
	time durata*desn (0, 2, 3);
	title “movimenti in salita”;
	run;

	proc lifetest
		data=pluto   /* movimenti laterali */
		plots=(s ) graphics nocensplot notable;
	time durata*desn (0, 1, 3);
	title “movimenti laterali”;
	run;

	proc lifetest                   /* movimenti in discesa */
		data=pluto
		plots=(s ) graphics nocensplot notable;
	time durata*desn (0, 1, 2);
	title “movimenti in discesa”;
	run;

	/* 	Per mettere su un unico grafico le tre curve di sopravvivenza:
	Passo 1: costruisco 3 nuovi dataset (salita, laterali, discesa) 
	che contengono i casi in salita, =, discesa: la variabile censura (opportun. classificata)
	ha sempre stesso nome=event; una nuova variabile=type classifica il tipo di destinazione */

	data salita; 
	set paperino; 
	event=0; 
	if desn=1 then event=1; 
	type=1; 
	run;

	data laterali; 
	set pluto; 
	event=0; 
	if desn=2 then event=1; 
	type=2; 
	run;

	data discesa; 
	set pluto; 
	event=0; 
	if desn=3 then event=1; 
	type=3; 
	run;

	* Passo 2: costruisco il dataset COMBINE che riunisce i 3 gruppi di episodi precedentem. costruiti;
	data combine;
	set salita laterali discesa; 
	run;

	* Passo 3: creo il grafico congiunto utilizzano variabile type come stratificatore;
	*ods html; 
	*ods graphics on; 
	PROC LIFETEST DATA=COMBINE plots=(s(nocensor)) graphics nocensplot; 
	TIME durata*event(0); 
	STRATA type; 
	RUN; 
	*ods graphics off; 
	*ods html close;

	/* Dal grafico emerge che gli episodi lavorativi sono più rapidi a 
	scendere quando si ha una condizione di prestigio di lavoro
	Negli altri casi la sopravvivenza è più elevata per il passaggio 
	sia per il passaggio verso più prestigiose o meno prestigiose
	Inoltre, per prendere 5 anni (5*12=60 mesi), graficamente si prende 
	in modo approssimativo il valore nelle curve, altrimenti si cerca nella tabella
	output il valore più prossimo a 60 per ogni curva */

	* Per mettere su un unico grafico le tre curve di sopravvivenza (modo rapido);
	*ods html; 
	*ods graphics on; 

	DATA sal; 
	SET paperino; 
	event=(desn=1); 
	type=1; 
	DATA lat; 
	SET pluto; 
	event=(desn=2); 
	type=2; 
	DATA disc; 
	SET pluto; 
	event=(desn=3); 
	type=3; 
	DATA combine; 
	SET sal lat disc; 
	PROC LIFETEST DATA=COMBINE plots=(s(nocensor)) graphics nocensplot; 
	TIME durata*event(0); 
	STRATA type; 
	RUN; 

	*ods graphics off;
	*ods html close;

	/* Stima con modelli semi-parametrici.
	Un modello per ognuna delle tre destinazioni. */

	proc phreg data=paperino; /* movimenti in salita */
	model durata*desn (0, 2, 3)= edu coho2 coho3 lfx pnoj pres ;
	title “MODELLO PER movimenti in salita”;
	run;

	proc phreg data=pluto; /* movimenti LATERALI */
	model durata*desn (0, 1, 3)= edu coho2 coho3 lfx pnoj pres ;
	title “MODELLO PER movimenti laterali”;
	run;

	proc phreg data=pluto; /* movimenti discesa */
	model durata*desn (0, 1, 2)= edu coho2 coho3 lfx pnoj pres ;
	title “MODELLO PER movimenti in discesa”;
	run;

	/* Come operano le covariate in funzione del tipo di destinazione successiva
	Per la salita:
	- L'educazione e il prestigio sono significative
	- All'aumentare del prestigio c'è meno propensione a muoversi
	- Il livello di istruzione è un propulsore che aiuta a passare a lavori di maggiore prestigio
	Per laterali:
	- All'aumentare della durata dell'esperienza lavorativa tendono meno a muoversi
	a lavori di tipo pari
	Per la discesa:
	- L'esperienza lavorativa è associata negativamente

	Attenzione che questi modelli hanno standard error differenti, non è come
	un modello a destinazione unica, le interpretazioni sono rischiose */
	```
</div>
<embed src="/assets/images/Statistics/EHA_006.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es007">Esempio 7: Cox stima funzioni base (1)</button>
<div class="content" id="es007data" markdown="1">

	```sas
	/*******************************************************
	Obiettivi:
	(Esercizio 1) Stima di S (H, logH ..) per gruppo "medie campionarie" delle covariate
	(Esercizio 2) Stima di S (H, logH ..) per gruppo di BASE (covar=0), parte non parametrica
		BASELINE + COVARIATES (= data set con valori covariate di interesse)
	(Esercizio 3) Stima di S (H, logH ..) per gruppi diversi dalla baseline
		combino stime gruppo di base + riskscore
		calcolo direttamente senza passare da gruppo di base
	*******************************************************/

	* genero il df;
	data dati;
	input time cens edu edu1 edu2 age ;
	cards;
	0.1 1 1 1 0 20
	0.2 1 2 0 1 18
	0.5 0 3 0 0 29
	0.5 1 1 1 0 30
	0.7 1 2 0 1 17
	0.8 1 3 0 0 23
	1.3 1 1 1 0 29
	1.5 1 2 0 1 33
	1.8 0 3 0 0 25
	2.5 1 1 1 0 18
	2.5 1 2 0 1 20
	2.5 0 3 0 0 31
	3.2 1 1 1 0 35
	3.7 1 2 0 1 17
	3.8 0 3 0 0 24
	1.9 1 1 1 0 18
	2.8 1 2 0 1 18
	3.4 0 3 0 0 18
	1.9 1 1 1 0 29
	0.8 1 3 0 0 18
	3.4 1 3 0 0 20
	;
	run;

	****************************** (Esercizio 1) ******************************;
	* Passo 1: PHREG + BASELINE: stimo funzioni base (che metto nel file a);
	proc phreg data=dati ;
	model time*cens (0) = edu1 edu2 age;
	baseline out=a  survival=s logsurv=ls loglogs=lls  cumhaz=H;
	run;

	* Passo 2: stampo data set «a»;
	proc print data=a;        /* funzioni a durate non censurate */
	run;
	* I valori medi sono:  Edu1=0,33 – edu2=0,28 – age=23,33;

	* Approfondimenti;
	/* 1) La funzione H, oltre che con cumhaz, è ottenibile come H=-ls
	ls che è stato stimato in «a» */
	data cum;   set a;   HAZ = -ls;    run;
	/* 2) Che succede se uso «edu» al posto di «edu1» e «edu2»? con o senza class?
	Senza class edu la tratta come continua, non è una stima uguale */
	/* 3) Se aggiungo opzioni plots in phreg: 
	"phreg dati=dati plots=S plots=cumhaz" 
	fa grafici di S e H */
				 
	* Passo 3: costruisco grafici funzioni: S vs t (o H vs t);  
	proc gplot data=a; 
	plot S*time;
	title «Sopravvivenza vs t»; 
	run;
	* NB: grafico doppio?; 

	* Per migliorare il grafico uso: "symbol value=none   interpol=joint";
	proc gplot data=a; 
	plot H*time;
	symbol /*value=none*/   interpol=joint ; 
	title «rischio cumulato vs t»; 
	run;
	* NB: se uso "frammenti codice" = menù a tendina non sdoppia grafici;

	ods graphics / reset width=6.4in height=4.8in imagemap;
	proc sort data=WORK.A out=_SeriesPlotTaskData;
		by time;
	run;
	proc sgplot data=_SeriesPlotTaskData;
		series x=time y=s /;
		xaxis grid;
		yaxis grid;
	run;
	ods graphics / reset;

	/* Per il grafico di S e H con intervalli confidenza:
	(lower= nome; upper= nome) e H (lowercumhaz= nome; uppercumhaz=nome)*/
	* Costruisco nuovo data set a1 con variabili richieste;
	proc phreg data=dati;
	model time*cens(0) = edu1 edu2 age;
	baseline out=a1 survival=s lower=lows upper=ups cumhaz=H lowercumhaz=lowch uppercumhaz=upch;
	run;
	* Per il grafico di S e H con intervalli: uso overlay;
	proc gplot data=a1;
	plot (lows s ups)*time / overlay; symbol interpol=joint;
	title "funzione sopravvivenza con intervalli confidenza";
	run;
	proc gplot;
	plot (lowch H upch)*time / overlay; symbol interpol=joint;
	title "rischio integrato con intervalli confidenza";
	run;

	/* Se volessi la stima di S per i 3 gruppi di edu a parità di 
	age = media campionaria? uso strata?
	Creo a2 con nuove stime - chiedo grafici - stratifico per edu */
	proc phreg data=dati  plots=s; 
	model time*cens(0) = age;
	baseline out=a2  survival=s;
	strata edu;
	run;
	proc print data=a2;
	run;
	/* Problema se stratifico per EDU: 
	Ho chiesto a parità di age per tutti e 3 gli strati, in questo modo strata 
	(che è usato per i modelli stratificati), va a stimare la funzione di sopravvivenza
	a parità dell'altra variabile, age, che varia di gruppo in gruppo, non mi mette
	il valore di age per tutti e 3 i gruppi, quindi non riesco a tenere sotto controllo
	la age, viene in questo modo calcolata la media campionaria per ciascun sotto-gruppo */

	****************************** (Esercizio 2) ******************************;
	/* Passo 1: creo data set servizio «null» con valori covariate gruppo base
	NB. gruppo base: edu=0=alta , età=0 */
	data null;  
	input edu1 edu2 age; cards;  
	0 0 0
	;       /* anche senza */  
	run;

	* Passo 2: stimo modello, S e H per gruppo base e metto in base0;
	proc phreg  data=dati  noprint  simple;    
	* NB. noprint non fornisce output modello. simple dà le medie camp. covariate;
	model time *cens (0) = edu1 edu2 age;
	baseline out=base0   covariates=null  survival=s cumhaz=H / method=pl  ;
	run;
	* NB pl usa KM;

	* proc print data=base0;
	* run;

	* Passo 3 (non obbligatorio): elimino da base0 variabili non utili;
	data base0;
	set base0;
	drop edu1 edu2 age; 
	run;

	* Passo 4: costruisco grafici S e H gruppo base;
	goptions reset=all;
	/* qui si può inserire alcune istruzioni forma grafico (non necessarie) 
	che si collegano ad opzioni di plot seguente */

	proc gplot data=base0;
	plot s*time;     /* inserire eventualmente title e symbol interpol=joint */
	plot H*time;
	run;

	****************************** (Esercizio 3) ******************************;
	/* Passo 1A: creo data set servizio con valori covariate gruppo: 0 0 18 
	voglio la sopravvivenza dei 18enni con istruzione alta */
	data covar;
	Input  edu1 edu2 age;
	Cards;
	0 0 18
	;
	run;

	* Passo 2A: stimo modello e S per il gruppo richiesto e metto in b (grafico in proc!);
	proc phreg data=dati  PLOTS=S;   
	model time*cens (0) = edu1 edu2 age;
	baseline out=b    covariates=covar    survival=s  lower=lcl upper=ucl ;
	run;

	* Passo 3A: stampo b (alternativam. si può costruire grafico con proc gplot);
	proc print data=b;
	run;

	/* Approccio alternativo:
	Stima funzioni per gruppo "0 0 18" indiretta
	(passo per stima funzioni gruppo di base che poi modifico con i RR)

	Passo 0B: recupero stime RR da passo 1 punto a) precedente

	Passo 1B: costruisco funzioni H  S  logH: parto da base0 - costruisco funzioni per age=18 - 
	gioco un po' con le relazioni tra funzioni */

	data base1;
	set base0;
	H02 = H *exp(-0.01371*18); *-0.01371 beta, 18 variabile continua Age;
	* se richiesto anche per altri gruppi aggiungere istruzioni per altre caratteristiche;
	s02 = exp(-H02);
	logH = log(H);   * costruisco logH per gruppo base (prima non calcolato)-NB: per H=0 log non definito;
	logH02 = logH -0.01371*18; * stima del gruppo non di base;
	run;

	* Passo 2B: grafici S H e logH per due gruppi;
	goption reset=all;
	* Definisco  alcune caratteristiche assi grafici;
	axis1 order=(0 to 4 by 0.2);                           /* scala tempo */
	axis2 order=(0 to 1 by 0.25) label=(a=90 'S(t)');      /* scala di S */
	axis3 order=(0 to 5 by .5) label=(a=90 'H(t)');        /* scala di H */
	axis4 order=(-6 to 2 by 1) label=(a=90 'logH(t)');     /* scala di logH */

	* Chiedo grafici S e H di 2 gruppi  (baseline e "18enni istruzione alta");
	proc gplot data=base1;
	plot (s s02)*time / overlay vaxis =axis2 haxis=axis1; 
	 /* NB: senza «overlay …» fa grafici distinti */
	plot (H H02)*time   /overlay vaxis=axis3 haxis=axis1;
	plot (logH logH02)*time  /overlay vaxis=axis4 haxis=axis1;
	run;
	/* Confronto la funzione di sopravvivenza per il gruppo di base con tutte le 
	covariate = 0 con quella che ne ha due di covariate, per i 18 enni */

	/*
	Voglio costruire delle funzioni di sopravvivenza di due gruppi al netto 
	dell'effetto delle covariate, per tenere sotto controllo effetti di disturbo.
	Usando strata non funziona, possiamo farlo costruendo
	in corrispondenza delle variabili metto il valore fisso delle covariate

	Stimare S per 3 gruppi di edu a parità di età media campionaria, 
	e fare su unico piano grafici usando gplot
	*/

	* Passo 1: creo edu1, edu2 edu3 con valori cov 3 gruppi;
	data edu1;
	Input  edu1 edu2 age;
	Cards;
	1 0 23.33
	;
	run;

	data edu2;
	Input  edu1 edu2 age;
	Cards;
	0 1 23.33
	;
	run;

	data edu3;
	Input  edu1 edu2 age;
	Cards;
	0 0 23.33
	;
	run;

	* Passo 2: stimo (e stampo) S per i 3 gruppi e metto in: stime1 stime2 stime3;
	proc phreg data=dati  plots=s; 
	model time*cens(0) = edu1 edu2 age;
	baseline out=stime1  covariates= edu1  survival=s;
	run;
	proc print data=stime1;
	run;

	proc phreg data=dati  plots=s; 
	model time*cens(0) = edu1 edu2 age;
	baseline out=stime2  covariates= edu2 survival=s;
	run;
	proc print data=stime2;
	run;

	proc phreg data=dati  plots=s;
	model time*cens(0) = edu1 edu2 age;
	baseline out=stime3  covariates= edu3 survival=s;
	run;
	proc print data=stime3;
	run;

	* Passo 3: unisco i 3 dataset ottenuti e codifico gruppi con edu;
	data unione;
	set stime1 stime2 stime3;
	run;

	data unione;
	set unione;
	if edu1=1 and edu2=0 then edu=1;
	if edu1=0 and edu2=1 then edu=2;
	if edu1=0 and edu2=0 then edu=3;
	run;
	proc print data=unione;
	run;

	* Passo 4: creo grafici S su unico piano;
	proc gplot data=unione;
	plot s*time = edu;
	symbol interpol=joint; 
	title "S per titolo studio";
	run;
	/* cambia l'educazione ma rimane costante l'age 
	che con strata non era possibile */
	```
</div>
<embed src="/assets/images/Statistics/EHA_007.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es008">Esempio 8: Cox stima funzioni base (2)</button>
<div class="content" id="es008data" markdown="1">

	```sas
    /* (Esercizio 1)
    Stimare i grafici di S per k gruppi 
    a lordo degli effetti delle altre covariate 
    (con LT, o KM, usando metodo non parametrico sono a lordo)

    (Esercizio 2)
    Stimare i grafici di S per k gruppi 
    al netto degli effetti delle altre covariate = phreg (perché tutte 
    le altre variabili sono tutte uguali alla loro media campionaria)

    (Esercizio 2 e mezzo)
    Ci sono differenze nell'effetto dei k gruppi con i due approcci?
    (ad esempio confrontare le due mediane)

    (Esercizio 3)
    Si verifichino le seguenti ipotesi
    - HP1: le donne con istruzione medio-alta hanno meno
    propensione a uscire dal mercato del lavoro delle donne con
    istruzione medio-bassa
    - HP2: a parità di altre condizioni, gli uomini con istruzione medio-
    alta hanno più propensione a uscire dal mercato del lavoro degli
    uomini con istruzione medio-bassa
    - HP3: a parità di altre condizioni le donne con istruzione medio-
    alta hanno meno propensione a uscire al mercato del lavoro degli
    uomini con istruzione medio-alta; il contrario avviene invece se
    l’istruzione è medio-bassa */

    libname dir "/home/dati";
    data MIO;
    set dir.PIPPO;
    * creo variabile edu_c;
    edu_c=0;                    /*istruz medio-bassa */
    if edu >= 12 then edu_c=1; /*istruzione medio-alta*/
    run;
    proc freq;
    table sex*edu_c;
    run;

    ****************************** (Esercizio 1) ******************************;
    * stimo S coorte lordo altre covariate;
    proc lifetest data=mio
	    plots= s(cl) graphics
	    outsurv=S_coorte1;
    time durata*des (0);
    strata coorte;
    title ”analisi KM per coorti al lordo altre covariate”; 
    *symbol1 v=none color=black line=1;
    *symbol2 v=none color=red line=2;
    proc print data=s_coorte1;
    run;

    ****************************** (Esercizio 2) ******************************;
    * Passo 1: stimo S per 3 coorti netto altre covariate;
    /* preliminarmenete stimo S per vettore medie 
    campionarie (conosco medie covariate)*/
    proc phreg data=mio ; 
    model durata*des (0) = sex edu coho2 coho3 lfx pnoj pres; 
    baseline out=a  survival=s; 
    run; 
    proc print data=a;   
    run; 

    /* S netto. 
    Cambio solo le prime due variabili che definiscono la coorte,
    le altre le fisso ai valori medi */
    data coorte1;
    Input  coho2 coho3 sex edu lfx pnoj pres;
    Cards;
    0 0 1.41 11.26 74.70  1.48 38.28
    ;
    run;
    data coorte2;
    Input  coho2 coho3 sex edu lfx pnoj pres;
    Cards;
    1 0 1.41 11.26 74.70  1.48 38.28
    ;
    run;
    data coorte3;
    Input  coho2 coho3 sex edu lfx pnoj pres;
    Cards;
    0 1 1.41 11.26 74.70  1.48 38.28
    ;
    run;

    * Passo 2: stimo S per i 3 gruppi;
    proc phreg data=mio  noprint; 
    model durata*des(0) = coho2 coho3 sex edu lfx pnoj pres ;
    baseline out=stime1  covariates= coorte1  survival=s;
    run;

    proc phreg data=mio  noprint; 
    model durata*des(0) = coho2 coho3 sex edu lfx pnoj pres;
    baseline out=stime2  covariates= coorte2 survival=s;
    run;

    proc phreg data=mio noprint; 
    model durata*des(0) = coho2 coho3 sex edu lfx pnoj pres;
    baseline out=stime3  covariates= coorte3 survival=s;
    run;

    * Passo 3: grafico con le 3 curve S;
    * devo creare prima un df unico con le 3 S e 3 coorti;
    data stime;
    set stime1 stime2 stime3;
    coorte=1;
    if coho2=1 and coho3=0 then coorte=2;
    if coho2=0 and coho3=1 then coorte=3;
    run;
    proc print data=stime;
    run;

    proc gplot data=stime;
    plot s*durata = coorte;
    symbol interpol=joint; 
    title "S coorti al netto altre covariate";
    run;


    ****************************** (Esercizio 3) ******************************;
    * Creo df tuo: individui nati 49-51 /187 casi;
    data tuo;
    set mio;
    if coorte=3;
    run;
    proc freq data=tuo;
    table sex*edu_c;
    run;

    * Creo 4 gruppi sex*istruz;
    data Fbassa;
    Input sex edu_c lfx pnoj pres;
    Cards;
    2 0 74.70  1.48 38.28
    ;
    run;
    data Falta;
    Input  sex edu_c lfx pnoj pres;
    Cards;
    2 1 74.70  1.48 38.28
    ;
    run;
    data Mbassa;
    Input sex edu_c lfx pnoj pres;
    Cards;
    1 0 74.70  1.48 38.28
    ;
    run;
    data Malta;
    Input sex edu_c lfx pnoj pres;
    Cards;
    1 1 74.70  1.48 38.28
    ;
    run;

    * Stimo S 4 gruppi e unisco dati;
    proc phreg data=mio  plots=s ; 
    model durata*des(0) = sex edu_c lfx pnoj pres;
    baseline out=stimeFb  covariates= fbassa survival=s;
    run;
    proc phreg data=mio  plots=s ; 
    model durata*des(0) = sex edu_c lfx pnoj pres;
    baseline out=stimeFa  covariates= falta survival=s;
    run;
    proc phreg data=mio  plots=s; 
    model durata*des(0) = sex edu_c lfx pnoj pres;
    baseline out=stimemb  covariates= mbassa survival=s;
    run;
    proc phreg data=mio  plots=s; 
    model durata*des(0) = sex edu_c lfx pnoj pres;
    baseline out=stimema  covariates= malta survival=s;
    run;

    * Crea file comune;
    data stime;
    set stimefb stimefa stimemb stimema;
    sexedu=1;  *M edu bassa;
    if sex=1 and edu_c=1 then sexedu=2;  *M edualta;
    if sex=2 and edu_c=0 then sexedu=3;
    if sex=2 and edu_c=1 then sexedu=4;
    run;
    proc print data=stime;
    run;

    proc freq;
    table sex*edu_c;
    run;

    * Creo grafici S su unico piano;
    proc gplot data=stime;
    plot s*durata=sexedu;
    symbol interpol=joint; 
    title "S MF per edu al netto altre covariate";
    run;

    /* Risultati
    Le ipotesi non sono confermate, il titolo di studio non
    fa modificare i comportamenti di abbandonare il lavoro.
    Le donne hanno un abbandono maggiore dal mercato del lavoro
    rispetto gli uomini */
	```
</div>
<embed src="/assets/images/Statistics/EHA_008.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es009">Esempio 9: Cox VTD (1)</button>
<div class="content" id="es009data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo: 
    Il figlio esce di casa per vivere da solo. 
    Ha avuto autonomia, cioè accesso ad essere indipendente?
    e_lh: età leaving home a cui se n'è andato di casa
    e_int: età intervista (serve per capire se è censurato)
    sex: 0 maschio
    e_1job: età primo lavoro
    (Esercizio 1) Modello stratificando VTD manualmente in sotto-episodi
    (Esercizio 2) Modello stratificando VTD if SAS
    *******************************************************/

    data dati;
    input id e_lh e_int sex e_1job;
    cards;
    1 34 35 0 30
    2 . 22 0 .
    3 20 25 1 .
    4 21 30 1 20
    5 28 33 1 26
    6 . 24 0 22
    7 . 19 0 .
    8 . 29 0 .
    9 . 23 1 22
    10 27 34 1 25
    11 . 27 0 24	
    12 . 20 1 .
    13 25 33 0 .
    14 . 25 1 .
    15 . 20 0 .
    16 26 28 1 27 
    ;
    run;

    ****************************** (Esercizio 1) ******************************;
    * Creo variabile durata e censura (1 se epis.censurato);
    data dati;  
    set dati;
    durata = e_lh; 
    censura = 0;
    if e_lh = . then do;
	    durata = e_int;
	    censura = 1;   * episodi censurati=1;
    end;
    run;
    proc print data=dati;
    run;

    /* La condizione di trovare lavoro è time dependent (è reversibile 
    ma la considero come irreversibile per semplicità)
    Quindi devo splittare la durata di leaving home per questa variabile
    Definisco per ogni sotto episodio nuove variabili 
    di durata, censura e stato occupazionale 
    (0=no lav tempo ind.- 1 lavoro tempo indet) */

    * Il tempo di esposizione inizia a 18 anni;
    data split;
    set dati;
    * definisco variabili sottoepisodi;
    tempo = 0; * durata episodio;
    status = 0; * se censurato;
    lav = 0; * variabile tempo dipendente;

    * Caso 1: il lavoro non è avvenuto prima fine episodio;
    if (e_1job=. or e_1job>=durata) then do;
	    /* NB. tempo coincide con durata episodio, 
	    sottoepisodio è censurato e VTD=0 */
	    tempo = durata-18;
	    status = censura;  
	    lav = 0;
	    output; * lo butta fuori dentro split;
    end;
         
    * Caso 2: il lavoro non è accaduto prima fine episodio;
    if (e_1job ne . and e_1job<durata) then do;
	    tempo = e_1job-18; 
	    status = 1;  * lo split iniziale sarà censurato;
	    lav = 0; 
	    output;
	    tempo = durata-e_1job; 
	    status = censura;  
	    lav = 1; 
	    output;
    end;    
    run;
    proc print data = split;
    run;

    * Stimo modello con variabile lav;
    proc phreg  data=split;
    model tempo*status(1) = lav sex;
    title "effetto occup tempo indeterminato su leaving home giovani - dataset splittato";
    run;

    /* Risultati
    La variabile Lav stima 3.12 con un valore 
    alto del rischio (22.8) ed è significativo

    Senza il 18 come punto di partenza, si avevano effetti più alti 
    ma non significativi, perchè il tratto veniva troppo lungo, conviene
    riportarsi all'inizio dell'esposizione, altrimenti crea distorsione
    in quanto non si lavora da minorenni e ci sarebbero 18 anni che pesano
    sulla stima */


    proc print data = dati;
    run;

    ****************************** (Esercizio 2) ******************************;
    * La if di SAS ne risente di una bassa numerosità campionaria;
    data dati;
    set dati;
    durata1 = durata-18;
    e_1job1 = .;
    if e_1job ne . then e_1job1 = e_1job-18;
    run;

    proc phreg data=dati;
    model durata1*censura(1) = lav sex ; * variabile lav la definisco dopo;
    if (e_1job1 ne . and e_1job1 < durata1) then lav=1;  else lav=0;      * 1,29 NS;
    * if (e_1job1= . or e_1job1 >= durata1) then lav=0;  else lav=1;
    title "effetto occup tempo indeterminato su leaving home giovani – uso IF";
    run;
    * Restituisce risultati diversi perché è bassa la numerosità campionaria.
	```
</div>
<embed src="/assets/images/Statistics/EHA_009.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;


<button class="collapsible" id="es010">Esempio 10: Cox VTD (2)</button>
<div class="content" id="es010data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo: 
    Essere coniugati o no, per quella generazione, ha un effetto sulla durata
    dell'episodio lavorativo? Passare da celibe a nubile ha un impatto sul rischio
    dal mercato del lavoro? Essere coniugati è una variabile tempo dipendente.

    (Esercizio 1) Modello stratificando VTD manualmente in sotto-episodi
    (Esercizio 2) Modello stratificando VTD if SAS
    *******************************************************/

    libname dir "/home/dati";
    data MIO;
    set dir.PIPPO;
    run;

    ****************************** (Esercizio 1) ******************************;
    * Costruisco i sotto-episodi;
    data split; 
    set mio;
    tempo = 0; * lunghezza sotto-episodio;
    status = 0; * censura sotto-episodio;
    mar = 0; * variabile tempo dipendente;
    * non coniugato per tutto intervallo: no matr. o matr. dopo fine episodio; 
	    if (tmar = 0 or tmar > tfin) then do;
	    tempo = tfin-tstart+1; 
	    status = des;
	    mar = 0;
	    output;
	    end;
    * coniugato per tutto episodio: matr. prima inizio episodio: td=1 tutto episodio;
	    if (tmar>0 and tmar<=tstart) then do;
	    * if (tmar>0 and tmar<tstart) then do;
	    tempo=tfin-tstart+1; 
	    status=des;
	    mar=1;
	    output;
	    end;
    * matr. durante episodio: split;
	    * parte in cui il soggetto era ancora nubile/celibe;
	    if (tstart<tmar<=tfin) then do;
	    * if (tstart<=tmar<tfin) then do;
	    tempo = tmar-tstart+1;
	    status = 0;
	    mar = 0;
	    output;
	    * parte in cui il soggetto è coniugato;
	    tempo = tfin-tmar+1;
	    status = des; 
	    mar = 1;
	    output;
	    end;
    run;

    * Modello 1: dati splittati, senza sex, con variabile fissa MAR;
    proc phreg data=split;
    model tempo*status(0) = mar edu coho2 coho3 lfx pnoj pres / risklimits;
    title "durata episodi lavorativi: effetto matrimonio dataset splittato";
    run;

    * Modello 2: dati splittati, con interazione MAR*sex;
    proc phreg data=split;
    /* Sex vale 1 e 2, 1 maschio e 2 femmina, significa che se faccio class sex
    prende come variabile di baseline la donna che vale 2. Quindi trovo l'effetto
    di sex che è di essere maschio. */
    class sex;
    model tempo*status(0) = mar sex mar*sex edu coho2 coho3 lfx pnoj pres;
    title "durata episodi lavorativi: matrimonio tempo dip dataset splittato e interazione sex";
    run;

    /* Risultati
    L'essere di uno stato civile piuttosto che un altro,
    influisce sul rischio e propensione ad abbandonare
    il mercato del lavoro?

    Modello 1:
    l'Hazard Ratio di MAR 0.91
    il rischio di coloro che sono coniugati (la baseline è 0), 
    rispetto coloro che non sono coniugati, è inferiore ad 1, 
    quindi hanno meno rischi di uscire dal mercato di lavoro i coniugati.
    Però non ha nessun effetto significativo, quindi essere
    coniugato o no non cambia.

    Modello 2:
    magari l'effetto non è vero che non è significativo, magari
    ci sono gruppi per il quale è significativo, ad esempio il genere.
    Non restituisce l'HR per le interazioni, ma basta fare 
    l'esponenziale della stima per ottenerla
    Mar è significativo, Sex no, ma l'interazione Mar*Sex è significativa,
    quindi l'essere coniugati produce un effetto che è positivo, aumenta
    il rischio di uscire da lavoro, ma con l'interazione 
    exp(parametro mar + parametro interazione), per i maschi il rischio
    di uscire dal mercato di lavoro è invece più basso, quindi:
    lo STATO CIVILE influenza in modo OPPOSTO nei due generi, l'essere
    coniugato fa si che per gli uomini ci sia una minore propensione
    di lasciare il lavoro (più responsabili), per le femmine succede 
    il contrario (abbandonano per mantenere i figli) */

    ****************************** (Esercizio 2) ******************************;
    /* Tanti episodi dello stesso soggetto
    Costruisco variabile ausiliaria DURNUB=TMAR-TSTART (=. se tmar=0=no matrimonio)
    DURNUB servirà a misurare qual è l'intervallo di tempo in cui il soggetto
    è non-coniugato (precedente al matrimonio), che si sovrappone al
    periodo dell'episodio che considero. Qui non splittiamo */
    DATA mio;
    SET mio;
    durnub=. ;
    /* Se c'è stato un matrimonio allora durnub è la differenza tra
    la data di matrimonio e la data di inizio dell'intervallo.
    Se la data di matrimonio è avvenuta prima dell'inizio dell'intervallo,
    questa differenza sarà negativa. Se avvenuta dopo sarà posiva,
    e può essere un pezzo intervallo dell'episodio può essere inferiore
    alla durata o può anche essere superiore nel caso in cui il matrimonio
    è avvenuto dopo la fine del nostro intervallo. 
    Quando non c'è stato il matrimonio durnub varrà 0

    DURNUB>0 se TMAR successiva a inizio episodio - 
    SE DURNUB<0 MATRIM PRIMA INIZIO EPISODIO */
    if tmar ne 0 then durnub = tmar-tstart;
    run;

    * Modello 1: dati con if, senza sex, con variabile fissa MAR;
    proc phreg data=mio;
    model durata*des (0) = mar edu coho2 coho3 lfx pnoj pres;
    * mar varrà 1 se il matrimonio è avvenuto entro la fine dell'episodio;
    if DURNUB ne . AND durnub < durata then mar=1; else mar=0;
    /* if tmar ne 0 and (tmar-tstart) < (tfin-tstart) then mar=1; else mar=0; */ * in alternativa;
    title "matrimonio tempo dip con IF - no interazione con sex";
    run;

    * Modello 2: dati con if, con interazione MAR*sex;
    proc phreg  data=mio;
    * impongo come baseline F= sex=2, senza class baseline=1=uomini;
    class sex;
    model durata*des (0) = mar sex mar*sex edu coho2 coho3 lfx pnoj pres;
    if DURNUB ne . AND durnub < durata then mar=1; else mar=0; 
    /* if durnub eq . or durnub>= durata then mar=0; *else mar=1; */  * in alternativa;
    title "matrimonio tempo dip con IF - interazione con sex=maschi";
    run;  

    /* Risultati
    Modello 1:
    MAR non è significativa

    Modello 2:
    MAR è significativa
    SEX*MAR negativo e significativo */
	```
</div>
<embed src="/assets/images/Statistics/EHA_010.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es011">Esempio 11: Cox non proporzionali</button>
<div class="content" id="es011data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo: 
    (Esercizio 1) Verifico assunz. proporzionalità con grafico e
    stimo modello stratificato per sesso
    (Esercizio 2) Verifico assunz. proporzionalità con test

    (Esercizio 3) Superamento assunzione proporzionalità con modelli che
    ipotizzano interazioni tra il tempo (durata) e le covariate (SEX1)
    (Esercizio 3.1) Tempo continuo: effetto lineare, 
    effetto lineare traslato, effetto lineare con log del tempo
    (Esercizio 3.2) Tempo discreto: effetto principale; 
    effetto a gradini (pochi); effetto a gradini (molti)
    (Esercizio 3.3) Qual è il modello migliore?
    *******************************************************/

    libname dir "/home/dati";
    data MIO;
    set dir.PIPPO;
    /* Genero dummy per sex invece di usare class, è più comodo
    per quando si stimano i modelli con l'interazione con il tempo*/
    sex1 = 0;      * assegno donne=0 al gruppo di base;
    if sex = 1 then sex1 = 1; 	* uomini=1;
    run;

    ****************************** (Esercizio 1) ******************************;
    /* Passo 1: stimo modello stratificato (superamento ipotesi porporzionalità)
    e costruisco "a" che contiene logH per M e F. */
    proc phreg data=mio;
    model durata*des(0) = edu coho2 coho3 lfx pnoj pres / ties = efron;
    strata sex1;
    /* Se facessimo run qua avremmo stimato un modello stratificato
    ma stima in modo non parametrico le funzioni del rischio di base per maschi 
    e femmine. Dato che non vogliamo solo la stima di edu e le altre variabili
    al netto di un possibile effetto di sex1, inseriamo anche baseline out a
    perché vogliamo l'effetto di sex1. */
    baseline out=a loglogs=lls;  
    run;

    * tranne le ultime tre, tutte le altre colonne saranno medie campionarie;
    proc print data=a (obs=10);
    run;

    * Passo 2: costruisco grafico di logH per maschi e femmine;
    proc gplot data=a;
    plot lls*durata=sex1;
    Symbol1 interpol=join color=red   line=1;
    Symbol2 interpol=join color=black line=2;
    title "verifica proporzionalità di sex"; 
    run;

    /* Risultato:
    sembra ci sia un effetto proporzionale dopo i 30 mesi,
    ma all'inizio sembra non rispettare la proporzionalità.
    Per comprendere meglio la parte iniziale posso fare 
    lls vs log(durata) */

    /* Passo 3: creo grafico logH*log(durata);
    Nota: se logH vs logt si distribuisce come una retta abbiamo una weibull */
    data b;  * NB. posso anche scrivere su "a" aggiornandolo;
    set a;
    lndur = log(durata);    * NB: in S=1 lndur non è stimato;
    drop edu coho2 coho3 lfx pnoj pres;
    run;

    proc gplot data=b;
    plot lls*lndur=sex1;
    Symbol1 interpol=join color=red  line=1;
    Symbol2 interpol=join color=blue  line=2;
    title "logH vs logt"; 
    run;
    * Ora il grafico è più chiaro;

    ****************************** (Esercizio 2) ******************************;
    /* Test sui residui di SCHOENFELD
    Nel caso in cui sono proporzionali, se facciamo
    il grafico tra i residui di schoenfeld calcolati in
    funzione di una certa covariata, cioè che sono la 
    differenza tra quello che è il valore della covariata
    con il modello rispetto il valore che avrebbe nella realtà,
    messo in relazione con la durata, dovremmo trovare un andamento
    casuale incorrelato */
    proc phreg data=mio;
    model durata*des(0)= sex1 edu lfx pnoj pres / ties=efron; 
    OUTPUT OUT=C RESSCH= schsex1 schedu SCHLFX SCHPNOJ SCHPRES; 
    run; 
    proc print data=c (obs=10); 
    run; 

    * Seleziono solo le variabili con i residui;
    data c;
    set c;
    keep durata schsex1 schedu SCHLFX SCHPNOJ SCHPRES;
    run;
    proc print data=c (obs=10);
    run;

    /* Resetto l'ambiente grafico, altrimenti se lancio tutto il
    codice mi prenderà per i grafici successivi l'impostazione
    interpol dei grafici precedenti */
    goption reset=all;

    * Grafici;
    proc gplot data=c; 
    plot schsex1*durata;
    plot schedu*durata;
    plot SCHLFX*durata;
    plot SCHPNOJ*durata;
    plot SCHPRES*durata; 
    symbol value=dot H=.5; 
    run; 

    /* Le due curve tipiche con residui con dummy.
    Non c'è un andamento parallelo, è inclinato, quindi una qualche
    relazione tra tempo le variabili c'è.
    Va meglio sulle variabili di tipo continuo EDU, sembrano proporzionali.
    Per la variabile LFX (durata) non sembrano proporzionali */


    /* Non rientra nei modelli di durata, ma possiamo stimare la correlazione,
    un'analisi di regressione lineare ORL, tra la variabile SCHPRES e DURATA, 
    in questo caso la variabile sex non è opportuna per una correlazione. 
    Chiedo p=valori predetti var.dip. e r=stime residui*/
    Proc reg data=c;
    Model schpres=durata /p;        * sintassi: y=x;
    Output out=zeta p=prev_pres r=resid;
    Run;
    /* R^2 basso, come si immaginava.
    Non ci sono evidenze quindi per dire che schpres ha effetti non proporzionali */


    ****************************** (Esercizio 3.1) ******************************;
    * Tempo continuo: effetto lineare;
    proc phreg data=mio;
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sex1 sextime;
	    sextime=sex1*durata;
	    title 'cox model - interazione t*sex1 lineare';
    run;
    /* L'effetto del sesso non sia costante al variare del tempo
    perché il rischio di uscita dal mercato di lavoro sembra dimunuire
    al variare del tempo, per gli uomini rispetto le donne (baseline) */

    * Tempo continuo: effetto lineare traslato di 12 mesi;
    proc phreg data=mio;
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sex1 sextime;
	    sextime=sex1*(durata-12);
	    title 'cox model con sex1 lineare traslato';
    run;
    /* L'interazione va nella stessa direzione, ma 
    Sex1 ora è diventato significativo */

    * Tempo continuo: effetto lineare con il log del tempo;
    proc phreg data=mio;
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sex1 sextime;
	    sextime=sex1*log(durata);
	    title 'cox model con sex1 log-lineare';
    run;
    * L'interazione è significativo ma Sex1 no;


    ****************************** (Esercizio 3.2) ******************************;
    * Tempo discreto: effetto principale: effetto dicotomico con salto a 30 mesi; 
    proc phreg data=mio;
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sex1 sextime;
	    sextime = sex1*(durata > 30);
	    /* IF DURATA>30 THEN SEXTIME=SEX1; ELSE SEXTIME=0; * alternativ.; */
    /* Un effetto principale che dice qual è l'effetto del sex per tutto 
    l'asse del tempo e poi ho un'interazione aggiuntiva che vale 
    per la seconda parte del tempo da 30 in su che va ad aggiungersi 
    all'effetto di sex1. */
    title 'cox model con sex1 step dicotomica>30';
    run;      * interpretare significato dei due effetti; 
    /* coefficente sex1: Il logaritmo del rischio di uscire dal mercato per i maschi
    per i primi 30 mesi, è di -0.11, vedendo il rischio, hanno
    una probabilità che è 10/11% inferiore rispetto quello delle
    donne sul primo tratto. Non è significativo
    coefficiente sextime: per quanto riguarda il secondo tratto è per i maschi inferiore
    a quello delle femmine molto di più, a -0.11 bisogna togliere -0.52, oppure
    exp(rischio di sex1)*exp(rischio sextime). Fatto 1 il rischio che hanno
    le femmine di uscire. è significativo. 
    è un effetto non proporzionale
    */

    * Tempo discreto: effetto a gradini (2 gradini);
    proc phreg data=mio;
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sextime1 sextime2;
	    sextime1 = sex1*(durata <= 30);
	    sextime2 = sex1*(durata > 30);
    title 'cox model con sex1 a due livelli dicotomica>30';
    run;
    /* sextime2 non sono sicuro che sia signif. diverso 
    come effetto da sextime1, mentre nel precedente si vedeva
    sextime è significativo che va ad aggiungersi a quello che già c'è.
    Va utilizzato dopo che si è sicuri che c'è differenza, e a gradini 
    viene più facile da leggere */

    * Tempo discreto: effetto a gradini (pochi);
    proc phreg data=mio;
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sextime1 sextime2 sextime3;
	    sextime1 = sex1*(durata < 20);
	    sextime2 = sex1*(20 <= durata < 40);
	    sextime3 = sex1*(durata >= 40);
	    title 'cox model con sex1 a (pochi) gradini';
    run;
    /* non c'è più sextime come effetto principale 
    Il primo tratto ha -0.15 e non è significativo, 
    il secondo tratto è poco significativo e il terzo è significativo.
    Nel primo tratto i maschi hanno un rischio di uscire dal mercato del lavoro
    che è inferiore del 15% (ma non è significativo).
    Nel secondo tratto il rischio degli uomini rispetto le donne è inferiore
    di quasi il 30% (significativo) e poi va ulteriormente riducendosi.
    Gli uomini man mano che passa il tempo, rispetto le donne, hanno
    meno rischi dal mercato di lavoro.
    L'effetto di sex, è coerente sul fatto che sia diversificato per uomini
    e donne.
    Il secondo tratto però non ci dice se la differenza è statisticamente
    significativa rispetto il tratto precedente perché lavoro sul totale
    del coefficiente. */

    * Tempo discreto: effetto a gradini (molti);
    proc phreg data=mio;
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sextime1 sextime2 
			    sextime3 sextime4 sextime5 sextime6 sextime7;
	    sextime1 = sex1*(durata < 20);
	    sextime2 = sex1*(20 <= durata < 40);
	    sextime3 = sex1*(40 <= durata < 60);
	    sextime4 = sex1*(60 <= durata < 80);
	    sextime5 = sex1*(80 <= durata < 100);
	    sextime6 = sex1*(100 <= durata < 160);
	    sextime7 = sex1*(durata ge 160);
	    title 'cox model con sex1 a (molti) gradini';
    run;   
    * Si può migliorare la suddivisione del tempo?;
    * Da confrontare i modelli;

    ****************************** (Esercizio 3.2) ******************************;
    * lineare continuo con log del tempo traslato della mediana;
    proc phreg data=mio; 
    model durata*des(0)= edu coho2 coho3 lfx pnoj pres sex1 sextime; 
	    sextime=sex1*(log(durata)-4.7);  /* traslo della mediana log tempo*/ 
	    title 'cox model con sex1 log-lineare traslato'; 
    run;
    /* L'interazione è significativa con il logaritmo.
    Il modello migliore sembra essere a tempo continuo con effetto lineare 
    con il log del tempo (traslato del log del tempo medio/mediano) */
	```
</div>
<embed src="/assets/images/Statistics/EHA_011.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es012">Esempio 12: Modelli parametrici: Esponenziale e Weibull (1)</button>
<div class="content" id="es012data" markdown="1">

	```sas
    /*******************************************************
    Obiettivi: 
    (Esercizio 1A) Modello Esponenziale (AFT) senza covariate
    (Esercizio 1B) Test grafico per il modello Esponenziale
    (Esercizio 2) Modello Esponenziale (AFT) con covariate

    (Esercizio 3) Test grafico per il modello Weibull
    (Esercizio 4) Modello Weibull (AFT) senza covariate
    (Esercizio 5) Modello Weibull (AFT) con covariate
    *******************************************************/
    
    libname dir "/home/dati";
    data MIO;
    set dir.PIPPO;
    * RICODIFICO SEX CON SEX1 E pongo donne gruppo di base;
    sex1=0;               /*donne*/
    if sex=1 then sex1=1; /*uomini*/
    run;

    ****************************** (Esercizio 1A) ******************************;
    /* Nel modello parametrico possiamo non mettere le covariate,
    mentre nel modello di Cox erano obbligatorie perché è semiparametrico,
    qui possiamo chiedere di stimare solo l'intercetta */
    proc lifereg  data=mio; 
    model durata*des (0)= / dist=exponential; * default weibull;
    title “stima modello esponenziale senza covariate”; 
    run;
    /* La scala di Weibull è l'esponenziale dell'intercetta, che stimando
    un modello AFT, è la durata media dell'episodio.
    Il moltiplicatore di Lagrange, verifica H0 scale=1, è rigettato quindi
    la scelta dell'esponenziale non è opportuno. 
    EXP(-coef. intercetta ATF) è il rischio di uscita 
    dal mercato del lavoro(PH).
    EXP(-coef. intercetta)*t è il numero medio di uscite 
    dal lavoro al tempo t (relazione con Poisson).
    EXP(coef.intercetta)=E(T)=1/a=durata media dell'episodio lavorativo */

    ****************************** (Esercizio 1B) ******************************;
    /* Il parametro di scala non risultava accettato uguale ad 1,
    va fatto (prima) un test grafico esponenziale -logS vs t */
    proc lifetest data=mio plots=ls graphics
    outsurv=a;
    * Aggiunge S ma non H sebbene faccia il plot;
    time durata*des(0);
    run;
    proc print data=a (obs=10);   
    run;

    * Costruisco H da S (così posso migliorarne il grafico);
    data a;
    set a;
    s = survival;
    neg_logs = -log(s);
    run;
    proc print data=a (obs=10);
    run;

    * Grafico H=-logS vs t;
    proc gplot;
    plot neg_logs*durata;
    symbol1 value=none i=join; *join unisce i punti;
    title "test grafico esponenziale: -ls vs t - retta che parte da origine?";
    run;
    * Parte dall'origine ma non è una retta;

    ****************************** (Esercizio 2) ******************************;
    * Esponenziale AFT con covariate;
    proc lifereg  data=MIO;
    model durata*des (0) = edu coho2 coho3 lfx pnoj pres / dist=exponential;
    title “stima modello esponenziale con covariate”;
    run;
    /* Stima intercetta e l'effetto di ciascuna covariata 
    sul logaritmo del tempo (modelli AFT).
    Effetti forniti da ciascuna covariata, rispetto al rischio del 
    valore della stessa covariata con il gruppo di base, in termini di
    durate. 
    Il coefficiente è alpha e impatta il logaritmo della durata */

    ****************************** (Esercizio 3) ******************************;
    * Verifica se Weibull. Grafico logH vs logt;
    proc lifetest data=mio  
    plots = lls graphics
    outsurv=c;
    * in c solo S;
    time durata*des(0);
    title «esame grafico su parametrizzazione weibull»;
    run;
    * Più simile ad una retta;
    * Si ipotizza sigma>1 monotono decrescente con t (cioè b<1);

    * Grafico migliore;
    data c;
    set c;
    s = survival;
    ldur = log(durata); * !durate =0;
    lls=log(-log(s));
    run;
    proc gplot;
    symbol1 value=none i=join;
    plot lls*ldur;
    title "test grafico weibull: -lls vs logt";
    run;

    ****************************** (Esercizio 4) ******************************;
    * Modello Weibull senza covariate;
    proc lifereg data= mio; 
    model durata*des (0) = / dist=weibull;
    title “stima modello weibull senza covariate”;
    run;
    /* 1.15 parametro di scala, quindi il rischio è 
    decrescente a passare del tempo */

    ****************************** (Esercizio 5) ******************************;
    * Modello Weibull con covariate;
    proc lifereg data= mio; 
    model durata*des (0) = edu coho2 coho3 lfx pnoj pres / dist=weibull;
    title “stima modello weibull con covariate”;
    run;
    /* Rispetto al precedente, ora abbiamo la stima delle covariate
    sul gruppo di base. Le stime influenzano il logaritmo del tempo rispetto
    il gruppo di base
    EDU: per ogni aumento unitario di educazione, l'effetto è quello di ridurre
    il logaritmo del tempo rispetto il punto precedente di educazione.
    Per ottenere il fattore di accelerazione bisogna fare l'exp. 
    Per passare a rischi proporzionali (PH) bisogna fare le conversioni:
    negativo del parametro e dividere per il parametro di scala 1.09.
    Shape=b<1 <=> Scale=(1/b)=Sigma>1: anche dopo le covariate il rischio è
    decrescente. */
	```
</div>
<embed src="/assets/images/Statistics/EHA_012.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es013">Esempio 13: Modelli parametrici: Esponenziale a tratti (2)</button>
<div class="content" id="es013data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo: 
    (Esercizio 1) Modello esponenziale a tratti senza covariate
    (Esercizio 2) Modello esponenziale a tratti con covariate
    *******************************************************/
    libname dir "/home/dati";
    data MIO;
    set dir.PIPPO;
    run;

    /* Preparo il df per modellazione a tratti.

    Splitto ogni episodio in un numero di tratti pari a quelli
    che si ottengono in base alla sua durata originaria.
    Poiché la durata media degli episodi non censurati è di circa 49 mesi (4
    anni e 1 mese), provo 96 mesi in J=9 intervalli da 12 mesi (ultimo aperto).
    è improbabile trovare un valore più alto di 96 mesi quando la media è 49. 
    Costruisco 8 periodi di 12 mesi + 1 intervallo aperto

    Passo 1. costruisco la variabile n che mi dice quanti sono 
    i tratti di ciascun episodio tratti da 12 mesi 
    fino a 96 poi intervallo aperto

    Passo 2. costruisco tre nuove variabili che servono 
    per model: tempo - evento - j */
    data n;
    set mio;
    /* Creo num. di intervalli (variabile per individuo): 
    (n-1) completi e n residuo (con evento o censura)*/
	    if durata le 96 then n=ceil (durata/12);  * ceil arrotonda per eccesso;
	    if durata gt 96 then n=9;
    /* Creo le specifiche di durata per ciascun tratto e 
    j = contatore intervalli, con n = num. di intervalli. 
    Ogni episodio al suo numero di sotto-episodi associati */
	    do j=1 to n;
	    if j le (n-1) then do;
	    tempo=12;
	    evento=0;
	    end;
		    if j=n then do;
		    tempo = durata-12*(n-1);
		    evento = des;
		    end;
	    output;
    end; 
    run;
    proc print data=n (obs=15);
    run;
    /* L'ID 1 è stato splittato in 9, quindi sono molto lunghi, 
    si prendono tutto il tempo. Il primo ID ha 9 tratti, il secondo ne ha 4.
    I primi 8 del primo ID sono di 12 mesi, e l'ultimo è lunghissimo.
    Il secondo ID, primi 3 da 12 mesi e l'ultimo da 10 mesi con l'evento. */

    ****************************** (Esercizio 1) ******************************;
    * Stimo esponenziale a tratti senza covariate;
    proc lifereg  data=n;
    class j; 
    /* j varia da 1 a n, dato che diventa categoriale la 
    baseline è l'ultimo tratto */
    model tempo * evento (0)= j / dist=exponential ;
    title “stima esponenziale a pezzi senza covariate”;
    run;
    /* è una stima a tempi accelerati AFT.
    Per ogni j si ottiene dei valori di beta. L'ultimo, 9, vale 0.
    Per capire l'andamento del rischio negli intervalli, creo la stima PH:
    intervallo k vs exp(-intercetta -coeff. j=k), 
    l'andamento è crescente e decrescente, due non sono significativi. 
    Da inesperto rischia e poi no, soprattutto nella prima fase */

    ****************************** (Esercizio 2) ******************************;
    * Stimo esponenziale a tratti senza covariate;
    proc lifereg  data=n;
    class j;
    model tempo * evento(0) = edu coho2 coho3 lfx pnoj pres j / dist=exponential;
    title “stima esponenziale a pezzi con covariate”;
    run;
    /* Comportamento analogo al modello senza covariate
    Il test Lagrange non ha senso qui per questa a tratti.
    Si sarebbe potuto usare il modello di Cox ma avremmo ottenuto
    rischi relativi, mentre in questo modo otteniamo rischi assoluti */
	```
</div>
<embed src="/assets/images/Statistics/EHA_013.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

<!---

&nbsp;
&nbsp;

<button class="collapsible" id="es014">Esempio 14: Modelli parametrici (3)</button>
<div class="content" id="es014data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistics/EHA_014.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

--->

## SAS Labs - Parte 2
<button class="collapsible" id="es015">Esempio 15: Modelli parametrici (3)</button>
<div class="content" id="es015data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo:
    simulare durate provenienti da una distribuzione Weibull con 
    parametro di scala pari a 1 (esponenziale) e parametro di forma 
    pari a 0.002 (il rischio di base) mentre il rischio di censura 
    è pari a 0.004. Simulo 1250 osservazioni (250 gruppi di 5 individui)
    *******************************************************/

    data simfrail;
      beta1 = 2; * effetto di x1;
      beta2 = -1; * effetto di x2;
      lambdat = 0.002; * rischio di base;
      lambdac = 0.004; * rischio censura;
      do i = 1 to 250; * genero le frailty, i=identificativo del gruppo;
        frailty = normal(1999) * sqrt(.5); * 1999 seed, varianza 0.5;
        do j = 1 to 5; * j=identificativo dell'individuo;
          x1 = normal(0);
          x2 = normal(0);
          * nuovo modello con la frailty;
          linpred = exp(-beta1*x1 - beta2*x2 + frailty);
          t = rand("WEIBULL", 1, lambdaT * linpred);
            * durata;
          c = rand("WEIBULL", 1, lambdaC);
            * tempo di censura;
          time = min(t, c);    * il tempo osservato è il minimo tra le due;
          censored = (c lt t); * è censurato se c <(lt) t;
        output;
        end;
      end;
    run;
    /* Le frailty sono uguali all'interno del gruppo ma 
    diverse tra gruppi. 
    Generiamo da modello parametrico (esponenziale) e 
    stiamo da modello semi parametrico, non è un problema
    in quanto il modello AFT per la Weibull è analogo
    ad un modello PH. Un modello semi parametrico non è un
    problema perché ho simulato da modello Esponenziale
    che è anche un modello a effetti proporzionali, non
    avrò solo la stima del rischio di base.
    Se avessi generato da un modello AFT con distrib. 
    log-normale, la stima avrebbe problemi */

    * modello a rischi proporzionali;
    proc phreg data=simfrail;
      model time*censored(1) = x1 x2;
    run;
    /* Il vero valore non rientra dei due intervalli stimati.
    Abbiamo stime distorte, causate da un'eterogeneità non
    osservata. La frailty simulata è indipendente dalle X, ma
    genera distorsione nel tempo, diversamente da un modello
    classico lineare */

    * aggiungo la frailty;
    proc phreg data=simfrail;
      class i;
      model time*censored(1) = x1 x2;
      random i / dist=gamma initialvariance=0.5 noclprint;
      * initialvariance, con varianza penalizzata, iterativo;
    run;
    /* I veri parametri rientrano negli intervalli stimati */
	```
</div>
<embed src="/assets/images/Statistics/EHA_015.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

<!---

&nbsp;
&nbsp;

<button class="collapsible" id="es016">Esempio 16: Modelli parametrici (3)</button>
<div class="content" id="es016data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistics/EHA_016.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

--->

<!---

&nbsp;
&nbsp;

<button class="collapsible" id="es017">Esempio 17: Modelli parametrici (3)</button>
<div class="content" id="es017data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistics/EHA_017.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

--->

<!---

&nbsp;
&nbsp;

<button class="collapsible" id="es018">Esempio 18: Modelli parametrici (3)</button>
<div class="content" id="es018data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistics/EHA_018.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

--->

<!---

&nbsp;
&nbsp;

<button class="collapsible" id="es019">Esempio 19: Modelli parametrici (3)</button>
<div class="content" id="es019data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistics/EHA_019.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

--->

<!---

&nbsp;
&nbsp;

<button class="collapsible" id="es020">Esempio 20: Modelli parametrici (3)</button>
<div class="content" id="es020data" markdown="1">

	```sas
	codice
	```
</div>
<embed src="/assets/images/Statistics/EHA_020.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

--->












































## Utili
### Century Months
$$\mbox{C.M.}=\mbox{YY}\times 12+\mbox{MM}$$  
$$\mbox{YY}=(\mbox{C.M.}-1)/12+1900$$  
$$\mbox{MM}=\mbox{C.M.}-(\mbox{intero(YY)}\times 12)$$






...
