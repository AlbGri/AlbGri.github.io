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
- Dominio (es variabile qualitativa d'interesse) e spazio degli stati (modalità della variabile qualitativa)
- Evento: failure, comporta una transizione dello stato
- Episodio: episode, spell length, survival time, duration, il tempo tra l'esposizione al rischio e il failure
- Evento origine: evento che porta l'esposizione al rischio
- Popolazione a rischio

##### Processi
- Caso semplice: 1 episodio, 1 stato destinazione
- Multistato o rischi competitivi: 1 episodio, 2+ stati destinazione
- Multi-episodio: 2+ episodi, 1 stato destinazione
- Multistato e multi-episodio

##### Limiti modello lineare
Il tempo è sempre positivo, non è normale e sono presenti le censure, inoltre le esplicative possono essere tempo dipendenti (cambiano stato durante l'episodio).

##### Censure
Scegliere sono episodi non censurati comporta dei bias di selezione. Il tempo dell'episodio si caratterizza da una variabile dummy che definisce la eventuale censura.

Censure in ambito bio-statistico  
- a destra: l'evento avviene dopo la fine del periodo di osservazione
- a sinistra: l'evento avviene prima dell'inizio del periodo di osservazione

Censure in ambito sociale  
- a destra: l'evento avviene dopo la fine del periodo di osservazione
- a sinistra: l'evento origine avviene prima dell'inizio del periodo di osservazione

Tipi di censure  
- Tipo I (generati dalla fine del periodo di analisi) 
- Tipo II (osservazione termina dopo che si è verificato un certo numero di eventi)
- Random-non informative (non dipendono dal rischio) 
- Random-informative (dipendono dal rischio, sono problematiche)

#### Disegni di indagine

##### Trasversali
Rilevano stati in un preciso istante di tempo. Esempi: censimento ISTAT

##### Longitudinali prospettivi
Rilevano stati nel corso del tempo.

Panel puro o con ricostruzione retrospettiva (tra waves)  
Pro: non si perdono individui per emigrazioni, no problemi di memoria, consente la rilevazione di dati non fattuali (opinioni).  
Contro: costi, troncamento a sinistra (puro), difficile per fenomeni rari o emergenti, possibili incoerenze tra waves, rischio selezione (attrito), re-test effect (ridondanza di risposte).  
Esempi: EU-SILC panel puro; SHARE panel con retrospettiva. 

Studi di follow-up  
Sono panel molto lunghi, si seguono specifiche coorti e si ricostruiscono gli eventi più importanti tra i follow-up.  
Pro: tempi di osservazioni lunghi, valutazioni degli effetti a lungo termine, legami intergenerazionali.  
Contro: attrito, costi, vuoti informativi, tempi di sopravvivenza troncati (non si supera una certa età).  
Esempi: Millennium Cohort Study UK; National Longitudinal Survey USA; paesi nord europei. 

Record-Linkage  
collegano informazioni di eventi e/o stati da fonti amministrative o statistiche. Linkage deterministico o probabilistico.  
Esempi: Linkage danese; analisi ISTAT  

##### Longitudinali retrospettivi
Si rilevano cross-section ma si ricostruisce la storia degli stati avvenuti in passato (es. Famiglie e Soggetti Sociali FSS ISTAT; Gender & Generation Survey).  
Pro: ricostruzione tratti lunghi, bassi costi, rilevazione continua, tempi brevi.  
Contro: memoria, selezione, non adatto per dati non fattuali.  
La data dell'intervista serve per ricostruire la durata degli episodi censurati: se non c'è l'evento (si ha quindi censura), la differenza tra l'intervista e l'evento di origine definisce la durata dell'episodio, se non è censurato è la differenza tra l'intervista e la data dell'evento.  

#### Funzioni base nel continuo e nel discreto

##### Funzioni base con tempo continuo
- Condizioni
- Densità, Ripartizione, Sopravvivenza  
$$S(t)=1-F(t)=1-\int_0^t f(t)dt=\int_t^{\infty} f(t) dt$$  
La distribuzione di $$T$$ è impropria o difettosa in quanto la sopravvivenza può non raggiungere 0. $$S(+\infty)=g$$ con $$g$$ probabilità di essere immune all'evento ('long-term survivors')  
- Funzione di rischio Hazard (propensione al cambiamento)  
$$h(t)=\lim_{t'\rightarrow t}\frac{\mathbb{P}(t\le T \le t' \vert T \ge t)}{t'-t}\equiv\frac{f(t)}{S(t)}$$  
Come la densità, non è una probabilità ma lo è se si moltiplica il suo valore per l'intervallo di tempo in cui la si stima.  
- Rischio integrato (utile per informazioni sul rischio quando non si può determinare)  
$$H(t)=\int_0^t h(t)dt=-\log{S(t)}$$  
- Relazioni tra le funzioni

##### Funzioni base con tempo discreto
- Discreto
- Continuo discretizzato

Probabilità nel punto $$\mathbb{P}(T=t_i)=f(t_i)$$  
Sopravvivenza $$\mathbb{P}(T\ge t_i )=\sum f_s$$  
Hazard $$\mathbb{P}(T\ge t_i \vert T \ge t_i)=f(t_i)/S_i$$  


#### Tipologie di metodi
Metodi non parametrici e modelli di regressione.  
I modelli di regressione possono essere parametrici (assumendo forma della baseline e del link tra covariate e baseline - tutti i modelli AFT) o semiparametrici (assumendo solo il link tra covariate e baseline - solo modelli di Cox)

##### Metodi per tempo continuo
- Metodi non parametrici: Kaplan-Meier (Product-Limit)
- Modelli di regressione (le covariate influenzano):
    - Rischi proporzionali PH $$h(t)=h_0(t) \cdot \exp{(\beta X)}$$
    - Tempi accelerati AFT $$T=T_0 \cdot \exp{(\beta X)}$$

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
- Metodi per la stima del rischio integrato (le stime dirette sono errate, come $$f$$, perché dipendono dalla variabilità delle ampiezze degli intervalli e il numero di eventi in ogni intervallo è teoricamente sempre 1)
    1. $$\hat{H}(t)=\hat{H}_j=-\log{\hat{S}_j}$$ (prima si stima $$S_{\small{\mbox{KM}}}$$ e poi $$H$$)
    2. Stimatore Nelson-Aalen: somma di prodotti tra stime del rischio in punti medi (si può stimare anche $$S_{\small{\mbox{NA}}}$$ e solitamente è sovrastimata)
- Esplorazione forma del rischio: esame grafico di $$H$$ se cresce linearmente $$h$$ è costante, oppure differenziando numericamente $$H(t)$$ previa lisciatura

Pro: la stima $$S$$ è MV; non è influenzato dalla scelta degli intervalli; usa tutta l'informazione  
Contro: difficile da tabulare con molti episodi; non utilizzabile se il tempo non è misurato esatto; non consente stima diretta del rischio

####  Life Table (o Attuariale)
- Tavola di eliminazione: stima rischio, probabilità e sopravvivenza  
$$N_j=N_{j-1}-(E_{j-1}+C_{j-1})$$  
$$R_j=N_{j}-0.5\cdot C_j$$  
$$\hat{p}_j=1-\frac{E_j}{R_j}$$  
$$\hat{S}_j^*=\hat{p}_{j-1}\cdot S_{j-1}$$  
- Altre funzioni  
Formula di Greenwood $$\mbox{SE}(\hat{S}_j)\approx \hat{S}_j^* \cdot \left [ \sum_{k=1}^{j-1} \frac{\hat{q}_k}{(1-\hat{q}_k)R_k} \right ]^{1/2}$$  
Sopravvivenza nell'intervallo $$\overset{\approx}{S}(t)=\hat{S}_j+(\hat{S}_{j+1}-\hat{S}_j)\frac{t-t_j}{t_{j+1}-t_j}$$  
Sopravvivenza a metà intervallo $$\bar{S}_j=0.5\cdot (S_j+S_{j+1})$$  
Ripartizione $$\hat{F}_j=1-\hat{S}_j$$  
Densità di probabilità $$\hat{f}_j=\frac{\hat{F}_{j+1}-\hat{F}_j}{t_{j+1}-t_j}=\frac{S_{j+1}-S_j}{t_{j+1}-t_j}$$  
Standard Error approssimato $$\mbox{SE}(\hat{f}_j)\approx \frac{\hat{q}_j\hat{S}_j}{t_{j+1}-t_j}\cdot \left [ \sum_{s=1}^{j-1} \frac{\hat{q}_s}{(1-\hat{q}_s)R_s} + \frac{(1-\hat{q}_s))}{\hat{q}_sR_s} \right ]^{1/2}$$  
Tasso di transizione $$\hat{h}_j=\frac{\hat{f}_j}{\overset{\approx}{S}_j}$$ non costante all'interno dell'intervallo (diversamente dalla densità)  
Standard Error approssimato $$\mbox{SE}(\hat{h}_j)\approx \frac{\hat{h}_j}{\sqrt{\hat{q}_j\hat{R}_j}} \cdot \sqrt{1-\left ( \frac{\hat{h}_j(t_{j+1}-t_j)}{2} \right )^2}$$  
Tasso di transizione a metà intervallo $$\bar{h}_j=\frac{\hat{f}_j}{\bar{S}_j}$$  
Intervallo di sopravvivenza $$\hat{S}(t)\pm z_{\frac{\alpha}{2}} \cdot \mbox{SE}(\hat{S}(t))$$
- Esplorazione forma del rischio: esame grafico di $$H$$ se cresce linearmente $$h$$ è costante, oppure differenziando numericamente $$H(t)$$ previa lisciatura

Pro: semplice; veloce; consente la stima anche con tempo impreciso; stima diretta di $$h(t)$$ e $$f(t)$$  
Contro: l'ampiezza degli intervalli è soggettiva, non adatto per piccoli campioni; approssimare ad un intervallo significa non usare tutta l'informazione disponibile


#### Confronti e omogeneità
Per analizzare le differenze tra funzioni di sopravvivenza appartenenti a gruppi differenti si possono confrontare i quantili, le funzioni di sopravvivenza mediante i grafici (se gli intervalli di sopravvivenza si sovrappongono) o effettuare test di omogeneità.

I test di omogeneità saggiano se le distribuzioni degli episodi tra i gruppi sono significativamente diverse.  
I dati censurati non consentono metodi standard come il Kruskal-Wallis, in questo contesto si utilizzano test simili al chi quadro  
- Log-rank test (Mantel-Cox; generalized savage test): somma quadratica degli scarti tra il numero di eventi nel gruppo e il suo corrispettivo valore atteso (ipotesi distribuzione delle durate uguale per tutti) diviso la varianza dello scarto. Più utile per i punti finali della curva.
- Wilcoxon test (Wilcoxon Breslow Gehan), come il Log-rank ma pesa le differenze tra gli scarti con il numero di individui a rischio. Più utile per i punti iniziali della curva.
- Tarone-Ware
- Peto-Prentice

#### Rischi competitivi
Quando si ha un episodio e più stati di destinazione, si può stimare la pseudo-sopravvivenza.  
La procedura è gestibile sia con stime KM che LT.  
Come nel caso della transizione singola, ma gli episodi che non terminano nella destinazione k-esima si trattano come censurati (se vale l'ipotesi di indipendenza).  
Ipotesi di indipendenza: l'eliminazione di un rischio non modifica la sopravvivenza rispetto agli altri.


### Modelli a tempo continuo

#### Modelli semi-parametrici
Se il numero di gruppi aumenta e la dimensione campionaria è piccola, l'approccio parametrico non è adeguato e si usano i modelli di regressione.

##### Modello di Cox
Si vuole stimare la propensione per i soggetti di sperimentare un certo evento.  
Il rischio è dato dal rischio base (non parametrico) con tutte covariate nulle e un fattore (parametrico) legato alle covariate  
$$h_i(t,X)=h_0(t)\cdot \exp{(\beta x_i)}$$  

Per covariate continue, alla variazione unitaria della variabile d'interesse, il logaritmo del rischio varia di $$\beta$$.  
Per covariate dicotomiche, il cambio di classe fa variare il logaritmo del rischio di $$\beta$$ rispetto la classe base.  
Proportional Hazard: il rapporto tra i rischi di due individui con differenti covariate è costante nel tempo.  

Pro: robusto (i coefficienti approssimano bene in modo parametrico); con poche assunzioni fornisce informazioni sulla sopravvivenza; flessibile (estensioni tempo dipendenti e con effetti non proporzionali); non richiede una stima del rischio di base.  

Si sceglie la baseline soggettivamente per dare senso all'interpretazione.  


##### Significatività
Per valutare se i parametri sono significativamente diversi da 0, si usa la statistica di Wald (chi-quadro o z).  
Gli intervalli di confidenza  
coefficienti: $$\beta=\pm 1.96 \cdot \mbox{SE}(\beta)$$  
hazard ratio: $$\exp{\beta}$$  


##### Risk Score
Dato $$i$$-esimo individuo con $$X_1,...,X_k$$ caratteristiche, il risk score risulta  
$$\mbox{RS}=\exp{\left ( \sum_{i=1}^k \beta_i X_i \right ) }$$  
è una misura relativa rispetto la baseline ed è utile quando si stimano modelli con numerosi predittori.  
Rischio Relativo $$\exp{\beta_i}$$ di una variabile dummy $$X_1$$  


##### Bontà di adattamento
Per modelli nidificati: test rapporto di verosimiglianza (verosimiglianza parziale) LR che saggia l'ipotesi nulla tutte le covariate nulle  
$$\mbox{LR}=-2\log{L_{\small{Reduced}}} - (-2\log{L_{\small{Unreduced}}})\sim \mathcal{X}^2_g$$  
$$g=p_{\small{Unreduced}}-p_{\small{Reduced}}$$ con $$p$$ numero di parametri  

Per modelli non nidificati: AIC, BIC  

##### Stima di massima verosimiglianza 
Full Likelihood - “Qual è la probabilità che l'individuo i-mo sperimenti un evento nel $$t_j$$ osservato?''  
la verosimiglianza in situazioni di censura si decompone nel seguente modo  
$$L(\alpha, t_1,...,t_N)=\prod_{i\in E} f(t_i,\alpha) \cdot \prod_{i\in C} S(t_i,\alpha)=\prod_{i\in E} h(t_i,\alpha) \cdot \prod_{i\in N} S(t_i,\alpha)$$  
con $$\alpha$$ parametro generico, $$E=N-C$$ casi non censurati, $$C$$ casi censurati, $$f=S\cdot h$$  
successivamente si applica il logaritmo e si massimizza rispetto $$\alpha$$, ma il rischio di base non è specificato (non si conosce a distribuzione dei tempi di sopravvivenza e non si può trovare un unico set di parametri che massimizza la verosimiglianza). Soluzione: Partial Likelihood.  

Partial Likelihood - “Dato che qualcuno sperimenta un evento al tempo $$t_j$$ qual è la probabilità che si tratti dell'individuo i-mo?''  
Si ordinano tutti i tempi (censurati e non) in modo crescente e si calcola il contributo al rischio di ciascun soggetto alla PL ($$t^*_{ij}$$ probabilità condizionata che l'unità $$i$$ sperimenti l'evento al tempo $$t_j$$).  
$$\mbox{PL}=\prod_E \frac{h(t^*_{ij})}{\sum_R h(t^*_{ij})}$$  
con $$R$$ insieme a rischio di eventi avvenuti al tempo $$t^*_{ij}$$ e successivi (sia censurati che no, ma il numeratore è solo per gli eventi).  
Divido num. e den. per rischio di base, ne faccio la trasformata logaritmica e massimizzo con metodi numerici iterativi.  

Pro: stime PML asintoticamente normali e non distorte.  

Note: sulla stima FL entrano tutti i casi, mentre nella PL solo al denominatore i censurati. Basato sui rank dei tempi non sono rilevanti i tempi ma l'ordinamento e l'aggiunta di una costante (parte non parametrica) non influisce sulle stime dei parametri.


##### Ties
Il metodo PL assume che non ci sono episodi coincidenti, bisogna correggere la PL.
- Exact (tutti i possibili ordinamenti)
- Breslow (come Exact ma shrinkage to 0 se ci sono molti ties)
- Efron (come Breslow ma più vicino all'Exact)
- Discrete (eventi effettivamente doppioni)

##### Stima e utilizzo delle funzioni base
Il modello di Cox stima i rischi relativi, e non consente di capire l'entità del rischio in termini assoluti, in quanto non si ha una stima del rischio di base $$H_0(t)$$.  
Senza variabili tempo dipendenti, si può stimare il rischio di base con metodi non parametrici (es. KM, Nelson-Aelen), oppure usando le seguenti relazioni  
$$S(t,X)=S_0(t)^{\exp{\left ( \sum_{i=1}^k \beta_i X_i \right ) }}$$  
con $$S_0$$ non parametrico, la parte esponenziale (risk score) stimata con Cox e si possono combinare le componenti per stimare la funzione di sopravvivenza per qualsiasi gruppo diverso dal base.  
$$H(t,X)=H_0(t) \cdot \exp{\left ( \sum_{i=1}^k \beta_i X_i \right ) }$$  
Inoltre, $$S(t,X)=\exp{(-H(t,X))}$$ quindi si può stimare dall'una l'altra


##### Variabili tempo-dipendenti
- Processi: micro (dettagli su individui), meso (vite, gruppi piccoli), intermedio (contesti aziendali), macro (processi storici)
- Caratteristiche VTD
- Modello con VTD (esempio con due covariate di cui una tempo dipendente)  
$$h_i(t,X)=h_0(t)\cdot \exp{(\beta_1 X_{i1}+\beta_2 X_{i2}(t))}$$
- Episode splitting per tenere sotto controllo le VTD:
    1. Trasformazione della tabella dati in person-period (si splittano gli gli episodi con variazione della VTD in sotto episodi censurati e non): le unità con un cambiamento della esplicativa al tempo $$t_1$$ dentro l'episodio $$[t_0,t_2]$$, si splittano in due eventi, il primo censurato di lunghezza $$t_1-t_0$$, il secondo $$t_2-t_0$$ con l'evento (censurato o no), con le altre covariate fisse.
    2. Applicazione dei modelli di durata alla nuova tabella dati
- Spazio stati TD
    - Dicotomizzazione non reversibile
    - Dicotomizzazione reversibile (stati ricorrenti)
    - Strutture complesse
- Effetti immediati o differiti nel tempo

##### Effetti non proporzionali
- Violazione assunzione proporzionalità
- Verifica proporzionalità 
	- Analisi grafica del logaritmo del rischio cumulato (se non sono parallele)  
	$$\log{(H)}=\log{(-\log{(S)})}$$  
	Se il rapporto tra i rischi di due soggetti è costante (PH), anche la differenza tra $$\log{H}$$ dei due soggetti differisce per una costante al variare di $$t$$  
	- Residui di Schoenfeld (se l'andamento dello scarto tra la covariata dell'i-esimo individuo e la sua media nel tempo non è casuale) 
	- Modello con interazione tra tempo e covariate (se il coeff. dell'interazione è significativamente diverso da zero)  
	$$h_i(t,X)=h_0(t) \cdot \exp{(\beta_1 X_i + \beta_2 X_i \cdot g(t))}$$  
- Superamento ipotesi proporzionalità
	- Modello stratificato ($$n$$ rischi di base quanti gli strati)  
	$$h_{ig}(t,X)=H_{0g}(t) \cdot \exp{\left ( \sum_{i=1}^k \beta_i X_i \right ) }$$  
	- Modelli separati in strati ($$n$$ modelli quanti gli strati, con $$\mathcal{X}^2$$ saggio se gli $$n$$ modelli sono uguali a quello compatto)  
	$$\mathcal{X}^2_{(k-1)p}=\bigg[-2LL_{\mbox{stra}}-\Big[\sum_{i=1}^n(-2LL_{\mbox{sep}_i})\Big]\bigg]$$  
	con $$k=\mbox{n.strati}$$ e $$p=\mbox{n.predittori}$$
	- Modello con interazione tra il tempo e le covariate (non solo per valutare la proporzionalità ma anche per superarla). Bisogna scegliere $$g(t)$$
	    - Tempo continuo
	        - Effetto lineare
	        - Effetto lineare traslato
	        - Effetto logaritmico (il parametro rappresenta la variazione del log rischio a raddoppi della durata, se il logaritmo è in base 2; pro-tip incrementare di 1 il tempo evita valori negativi)
	    - Tempo discreto
	        - Main effect: effetto principale (variabile senza dummy) + parte lineare con dummy (della stessa variabile) dell'intervallo (consente di capire se un tratto è significativamente diverso dall'altro) 
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
    Test grafico su Esponenziale: se l'andamento $$H(t)$$ vs $$t$$ è una linea retta che parte dall'origine allora i dati approssimano bene una durata esponenziale (quindi Weibull con $$b=1$$).  
    $$F(t)=1-\exp{(-at)}$$  
    $$\log{S(t)}=-at$$  
    - Weibull  
    $$f(t)=abt^{b-1}\exp{(-at^b)}$$ con  
    $$a$$ (livello o scala), $$b>0$$ (forma), se $$b=1$$ Exp (test $$H_0:b=1\rightarrow\mathcal{X}^2_1$$)  
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
    L'exp dei singoli coefficienti è il tempo relativo.  
    $$\alpha$$ stimato è il logaritmo della durata relativo alla variabile $$X$$  
    $$\exp{(\alpha_0^{AFT})}=\exp{(-\beta_0^{PH})}=1/\exp{(-\beta_0^{PH})}=1/h_0^{PH}=E(T_0)$$  
    $$\hat{a}_{\small{\mbox{MV}}}=\frac{E}{\sum_{i\in N}t_i}=$$ rapporto tra numero di eventi (casi non censurati) e totale dei tempi $$t_i$$ dell'intero campione (sia censurati che non)  
    $$\hat{E}(t)=\frac{1}{\hat{a}_{\small{\mbox{MV}}}}=$$ durata media intervallo  
- Weibull  
    - PH  
    $$h(t\vert X)=\big[\exp{(\beta_0)}\cdot bt^{b-1}\big]\cdot\exp{(\beta X)}=h_0(t)\cdot\exp{(\beta X)}$$
    - AFT  
    $$\log{T}=\alpha_0+\alpha X+\sigma\epsilon$$  
    $$T=\exp{(\alpha_0+\sigma\epsilon)}\cdot\exp{(\alpha X)}=T_0\cdot\gamma$$  
    Si dimostra che $$\beta=\beta_{PH}=-\beta_{AFT}\cdot b=-\alpha\cdot b$$  
    NB. SAS stima modello Weibull solo AFT con $$\sigma=1/b\Rightarrow\beta_{PH}=-\beta_{AFT}\cdot (1/\sigma)$$  
    Inoltre, con $$a=\exp{(-\beta_{AFT}\cdot b)}$$ si ricava facilmente $$h(t)=\exp{(-\beta_{AFT}\cdot 1/\sigma)}\cdot 1/\sigma\cdot t^{(1/\sigma -1)}$$, così da ottenere il rischio dopo $$t$$ durate  
    $$\alpha=(1/\sigma -1)$$ incremento di rischio all'aumento dello $$0.01$$ del tempo.
- Esponenziale a tratti (Piecewise exponential model)  
Per $$L$$ sotto-intervalli del tempo si specificano diverse distribuzioni parametriche del rischio.
    - Funzioni utili  
    $$h(t_j)=\sum_j^L a_j I_j$$ con $I_j$ variabile dummy che vale $$1$$ nel $j-$esimo intervallo. Rischio costante a tratti, con valori di $$a$$ differenti per ogni intervallo.   
    $$h(t_j,X)=a_j=\exp{(\beta_{0j}+\beta_j X)}\mbox{ con }j=1,...,L$$ è un modello a rischi non proporzionali, varia ad ogni intervallo. Se $$\beta_j=\beta$$ è a rischi proporzionali.  
    NB. in SAS la significatività di J è con Wald, in cui si saggia se il rischio è costante  
    NB. in SAS exp(-coeff.) è il valore del rischio relativo rispetto al $$j-$$esimo tratto  



## Modelli Frailty
Frailty models o Mixed Proportional Hazard models (misti si intende con effetti fissi e casuali).

### Introduzione al concetto di Frailty

#### Problema
Limitare il problema della mal specificazione del modello e distorsione delle stime, aggiungendo un effetto casuale sui modelli di regressione sul rischio.  
Anche con covariate indipendenti tra loro, se una delle due è omesse andrà ad impattare le stime _selezionando_ la popolazione e rendendo le stime dipendenti dal tempo (rischio ad U, individui fragili escono prima e si selezionano i più resistenti nel tempo).  
La presenza di una _fragilità_ differente tra i gruppi - eterogeneità non osservata - comporta una variazione del rischio; i modelli tradizionali di Survival Analysis considerano le popolazioni omogenee, cioè che tutti gli individui hanno lo stesso rischio.  
- Funzione di sopravvivenza marginale per due popolazioni esponenziali $$(\lambda_i)$$  
$$S(t)=p\exp{(-\lambda_1 t)}+(1-p)\exp{(-\lambda_2 t)}$$ è una mistura e se si calcola il rischio (derivando $$\log{S}$$) non è più costante.

#### Modello Frailty
Sia $$U>0$$ v.a. indipendente dal tempo, la cui varianza $$\sigma^2_U$$ misura l'eterogeneità non osservata della popolazione. Siano $$\mathbf{X}=(X_1,...,X_k)$$ matrice delle covariate e $$\mathbf{\beta}=(\beta_1,...,\beta_k)$$ parametri di regressione.
- Funzione di rischio  
$$h(t\vert U)=h_0(t)\cdot U$$  
$$h(t\vert X, U)=h_0(t)\exp{(\beta 'X)}\cdot U$$  
- Rischio marginale  
$$\mathbb{E}_U\{h(t\vert U)\}=h_0(t)\cdot \mathbb{E}_U\{U\}=h_0(t)$$  
- Funzione di sopravvivenza  
$$S(t\vert X,U)=\exp{\big\{-\int_0^t h(s\vert X,U)ds\big\}}=\exp{\left \{ -U \exp{(\beta'X)}H_0(t) \right \}}$$
- Sopravvivenza marginale  
$$S(t)=\mathbb{E}\left \{ S(t\vert U)\right \}=\mathbb{E}\left \{\exp{\left [ -U \exp{(\beta'X)}H_0(t) \right ]} \right \}=\mathbf{L}\left\{ \exp{(\beta'X)} H_0(t)\right\}$$  
- Trasformata di Laplace  
$$\mathbf{L}=\int e^{-zu}\cdot f(u)du$$
- La varianza della frailty può avere un valore contenuto e influenzare significativamente sia le covariate (sia come significatività che il valore) che la forma del rischio


#### Distribuzione della Frailty

##### Gamma
- Caratteristiche  
	- Facile da standardizzare  
	per ottenere $$\mathbb{E}(U)=1$$ si impone $$U\sim\Gamma(k=\lambda, \lambda)$$ con $$\sigma^2=1/\lambda$$  
	- La vera distribuzione della frailty tra i sopravviventi tende a Gamma per $$t\rightarrow \infty$$  
- Laplace esplicita  
$$\mathbf{L}=\int e^{-zu} f(u)du=\big(1+\frac{z}{\gamma}\big)^{-k}$$  
- Sopravvivenza marginale  
$$S(t)=1/\left [ 1+\sigma^2 H_0(t) \right ]^{1/\sigma^2}$$  
- Rischio marginale  
$$h(t)=h_0(t)/\left [ 1+\sigma^2 H_0(t) \right ]$$


##### Log-normale
- Caratteristiche  
$$X\sim\mathcal{N}(m,s^2)\rightarrow U=e^X \sim \log{N}\left (e^{\left ( m+\frac{s^2}{2}\right )},e^{\left ( 2m+s^2 \right )}(e^{s^2}-1) \right )$$  
$$f(u)=\frac{1}{\sqrt{2\pi}su}\exp{\left ( - \frac{\log{(u)}^2}{2s^2} \right )}$$
	- Forte legame con modello lineare ad effetti casuali  
	- Più semplice la generalizzazione al caso multivariato  
- Laplace non-esplicita

#### Modello Gompertz
Il modello esponenziale è un caso specifico.  
$$f(t)=\lambda e^{\phi t} e^{-\frac{\lambda}{\phi} \left [\exp{(\phi t)}-1 \right ]}$$ con $$\lambda > 0$$  
$$S(t)=e^{-\frac{\lambda}{\phi} \left [\exp{(\phi t)}-1 \right ]}$$  
$$h(t)=\lambda e^{\phi t}$$  
$$h(t_i\vert X_i)=e^{\phi t_i} e^{\beta_0 +X_i' \beta}$$ con $$\lambda=e^{\beta_0}$$  
$$H(t)=\frac{\lambda}{\phi} \left [e^{\phi t}-1 \right ]$$  
Se $$\phi=0$$ allora è esponenziale  
Se $$\phi<0$$ rischio decrescente con il tempo (non applicabile alla mortalità)  
<!--- --->

##### Modello Gomperz-Makeham
$$h(t)=\lambda e^{\phi t}+c$$ con $$c$$ componente indipendente dal tempo dominante con l'avanzare del tempo.  
Il modello distribuzione descrive bene i tassi di mortalità (principalmente 30-80 anni), successivamente il tasso di mortalità cresce più lentamente (late-life mortality deceleration), portando il rischio ad essere costante (plateau).  

#### Modello Gamma-Gompertz
La late-life mortality decelation è come una selezione (all'aumentare del tempo, sopravvivono gli individui più resistenti), quindi si introducono modelli con frailty per limitarne l'effetto (Mixed Proportional Hazard Model).  
$$h(t_i\vert X_i)=e^{\phi t_i} e^{\beta_0 +X_i' \beta}\cdot Z_i$$ con frailty Gamma $$Z$$  
quindi risulterà  
$$h(t_i\vert X_i)=\frac{\exp{(\phi t_i)} \exp{(\beta_0 +X_i' \beta)}}{1+\sigma \frac{\exp{(\beta_0 +X_i' \beta)}}{\phi} \left [\exp{(\phi t)}-1 \right ]}$$  
con $$\sigma$$ varianza della distribuzione gamma. Il rischio marginale ha forma di logistica con asintoto (plateau) che dipende dai parametri $$\phi$$ e $$\sigma^2$$ (se $$\sigma^2=0$$ si ritorna a Gompertz).  
Quindi con la frailty si ottiene la decelerazione della crescita del rischio.  
Con $$\sigma^2$$ bassa comunque la frailty può essere molto utile, bisogna valutare se variano gli effetti delle covariate rispetto al modello senza frailty e il livello di bontà di adattamento.  

Duplice interpretazione   
- Modello parametrico con distribuzione Gamma-Gompertz: la distribuzione dei tassi di mortalità per età non ha una forma Gompertz ma Gamma-Gompertz, cioè non cresce esponenzialmente ma ad un certo tempo comincia a decellerare
- Modello Gompertz con frailty Gamma: per i singoli individui la distribuzione del tasso di mortalità ha una forma Gompertz (forma esponenziale), ma a livello di popolazione con fragilità diverse all'interno, si crea una selezione e a livello di popolazione si osserva la decelerazione del rischio.  



### Modelli Frailty Univariati

#### Modello parametrico
Per fare inferenza con i modelli di frailty  
- Verosimiglianza condizionata alle frailty non si può massimizzare perché non si conosce la frailty  
$$L(\beta,\theta \vert U_1,...,U_n)=\prod_{i=1}^n h(t_i \vert \beta, \theta, U_i)^{\delta _i} S(t_i \vert \beta, \theta, U_i)$$ con $$\delta _i=0$$ se la durata $$t_i$$ è censurata, $$\theta$$ parametri relativi alla forma del rischio (es. nel caso dell'esponenziale $$\theta$$ è costante il valore di base del rischio), $$\theta$$ parametro delle covariate  
- Verosimiglianza marginale come valore atteso della condizionata (è una pseudo verosimiglianza, utile per ottenere le stime MV, 'liberandosi' dell'influenza della frailty)  
$$L(\beta,\theta,s^2)=\int L(\beta,\theta \vert U_1,...,U_n) d\Phi(U_i)$$ con $$\Phi(U_i)$$ distribuzione scelta delle frailty  
- Integrazione della verosimiglianza marginale
    - Trasformazione di Laplace non-esplicita: integrazione numerica (approssimazione di Laplace, quadratura Gaussiana)
    - Trasformazione di Laplace esplicita: non richiede integrazione perché si ha forma esplicita

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

<!---
--->



#### Modello semi parametrico
I parametri disturbo non so solo le frailty ma anche il rischio di base.  

Fattorizzazione della verosimiglianza:  
$$L(\beta,\sigma^2,U)=\prod_{i=1}^n f(t_i , \delta_i, U_i \vert h_0(\cdot), \beta,\sigma^2)=L_1 (h_0(\cdot ),\beta)\cdot L_2(\sigma^2)$$  

##### Failty note
Se le $$U_i$$ fossero note, in $$L_1$$ si sostituisce $$U_i=e^{\log{(U_i)}}$$ e si stima usando il metodo della verosimiglianza parziale di Cox (le frailty diventano un offset, valore noto come l'ampiezza di osservazione degli eventi di una distribuzione di Poisson).  
$$L_2$$ con frailty note, sarebbe la verosimiglianza della distribuzione della frailty.  

##### Frailty non-note
Due alternative per ottenere le stime  
1. Algoritmo EM (Expectation-Maximization) con la verosimiglianza parziale, considerando come se le frailty fossero i dati mancanti (cfr EM, si ipotizzano valori casuali delle frailty si stimano le verosimiglianze parziali, si calcolano i valori attesi e si ripete fino a convergenza).  
    - Frailty Gamma
    - Il rischio cumulato di base si steima con Nelson-Aalen (equivalente alla stima KM)
    - Valore atteso di $$\log{U}$$ con distribuzione log-Gamma è noto
2. Verosimiglianza penalizzata (utile per restringere una verosimiglianza piatta, pesando maggiormente alcuni valori del dominio del parametro da stimare)  
$$h(t\vert X,U)=h_0(t)e^{\beta ' X + W}$$ con $$W=\log{U}$$ se $$U\sim\log{\mathcal{N}}\rightarrow W\sim\mathcal{N}$$  
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



### Modelli Frailty a tempi Discreti
Problame dei ties. Nel modello di Cox ad esempio si creano problemi.  
Si può stimare un modello a tempi discreti da un modello logistico a intercetta casuale.  
Si hanno $$J$$ intervalli e la probabilità di subire l'evento all'intervallo $$j-$$esimo è  
$$P(t_{i-1}<T\le t_i)=F(t_i)-F(t_{i-1})=S(t_{i-1})-S(t_i)=f(t_i)=S(t_{i-1})\cdot h(t_i)$$  
$$h(t_i)=P(t_{i-1}<T\le t_i\vert T\ge t_{i-1})=1-\frac{S(t_1)}{S(t_{i-1})}$$  
la funzione di rischio nel discreto è una probabilità (condizionata) e varia tra 0 e 1.  
$$S(t_{j})=\Bigg[1-\bigg(S(t_{0})-\frac{S(t_{1})}{S(t_{0})}\bigg)\Bigg]\cdot \Bigg[1-\bigg(\frac{S(t_{1})-S(t_{2})}{S(t_{1})}\bigg)\Bigg]\cdots \Bigg[1-\bigg(\frac{S(t_{j-1})-S(t_{j})}{S(t_{j-1})}\bigg)\Bigg]=\prod_{i=1}^j\big(1-h(t_i)\big)$$  
La funzione di densità è la probabilità di subire l'evento all'intervallo $$j-$$esimo.  
Si riesce a formulare tutto in funzione del rischio.

<!---
--->

#### Modello a odds proporzionali

$$\log{\bigg(\frac{h(t_i;X)}{1-h(t_i;X)}\bigg)}=\log{\bigg(\frac{h(t_i)}{1-h(t_i)}\bigg)}+\beta' X$$

La funzione di rischio ora è una probabilità, quindi l'odds è una quantità sensata, non lo era in ambito continuo (poteva essere anche negativo).  
Ricavata la funzione di verosimiglianza (costruita come contributi individuali divisi per censurati e non), si dimostra che è analoga alla verosimiglianza di un modello logistico (di una variabile $$y_{ik}$$ relativa non solo all'individuo ma anche all'intervallo).

$$\log{\bigg(\frac{P(y_i=1)}{1-P(y_i=1)}\bigg)}=\beta_0+ \beta' X$$

Quindi per stimare il modello a odds proporzionali:  
1. Si riorganizzano i dati nel formato 'person-period' (se era in formato 'person data'), con un record per ogni intervallo di tempo
2. Si creano le variabili tempo-dipendenti
3. Si stima il modello con una regressione logistica, i cui coefficienti sono i medesimi del modello a odds proporzionali

#### Frailty univariato
Si inserisce un'intercetta casuale al corrispondente modello logistico. Per stimare un modello frailty univariato si fa ricorso ad un modello logistico gerarchico (ad intercetta casuale): l'effetto casuale è condiviso dagli intervalli di tempo dello stesso individuo. Log della frailty fissa nel tempo ma è diversa per ogni individuo.

Se ci fosse un raggruppamento, si utilizza un modello logistico gerarchico con unità di terzo livello, sarebbe un modello Frailty Shared, perché la frailty fa riferimento al gruppo a cui appartiene l'individuo.





## Modelli Multilivello o Gerarchici

#### Modelli Multilivello
Per i dati che sono raggruppati in modo tale da ipotizzare più intercette e/o pendenze differenti  
- Modelli ad intercetta variabile ($$n$$ rette parallele)
- Modelli a pendenza variabile (effetti random)
- Modelli a intercetta e pendenza variabili

#### Modelli Gerarchici
La gerarchia si può intendere in due modi
1. Gerarchia Bayesiana, dove i dati si distribuiscono secondo una famiglia di parametro $$\theta_1$$ e a sua volta il $$\theta_1$$ si assume sia la realizzazione di una variabile casuale la cui distribuzione (a-priori) appartiene ad una famiglia di parametro $$\theta_2$$ (si può continuare con $$\theta_3$$, con distribuzione iper-a-priori, etc.)
2. Struttura gerarchica dei dati, quando unità statistiche di secondo stadio (I livello) appartengono a delle unità di primo stadio (II livello). Es.: pazienti (I livello) e ospedali (II livello), oppure nei dati longitudinali, individuo (II livello) e tempo (I livello).


#### Pooling
Quando si sintetizza l'informazione (es. media) schiacciando il livello superiore, ignorando la variabilità tra i gruppi, interna al livello. Al contrario, considerare tutti i gruppi appartenenti al livello superiore (no-pooling) porta sovrastimare la variabilità tra i gruppi del livello. Concetto analogo al trade-off distorsione-varianza.

### Analisi multilevel senza covariate

#### Coefficiente di correlazione intraclasse
La costruzione che segue è specifica per i modelli lineari classici (e non GLM).  

##### ANOVA ad una via con effetti casuali
Dato il modello con intercetta casuale e senza variabili indipendenti  
Sia $$i$$ unità di I livello e $$j$$ di II livello  
$$y_{ij}=\beta_{0j}+\epsilon_{ij}$$ con $$\epsilon_{ij}\sim\mathcal{N}\big(0,\sigma^2_\epsilon\big)$$  
Ipotizzando che $$\beta_{0j}=\gamma_{00}+U_{0j}$$ con $$U_{0j}\sim\mathcal{N}\big(0,\sigma^2_{U_0}\big)$$  
La varianza dell'effetto casuale $$U_{0j}$$ è la covarianza tra individui  
appartenenti allo stesso gruppo  
$$cov(y_{ij},y_{i'j})=E(y_{ij}y_{i'j})-E(y_{ij})E(y_{i'j})=var(U_{0j})=\sigma^2_{U_0}$$  
Se la $$cov$$ è molto diversa da 0 allora le osservazioni in uno stesso  
gruppo (o classe) sono correlate.  
Si decide di fare il pooling se la correlazione intraclasse  
non è significativamente diversa da 0  
$$\rho^{IC} (y_{ij},y_{i'j})=\frac{\sigma^2_{U_0}}{\sigma^2_{U_0}+\sigma^2_{\epsilon}}$$ con $$\rho\in [0,1]$$  
Se si può fare il pooling non serve un modello multilevel.  

##### Varianza between-group
Esprime la variabilità tra le unità di secondo livello, se la dimensione dei gruppi non è omogenea occorre modificare opportunamente la varianza.  
Il valore atteso è dato dal suo vero valore più la varianza introdotta dall'errore di campionamento:  
$$E\big(\sigma^2_b\big)=\sigma^2_{U_0}+\frac{\sigma^2_\epsilon}{\hat{n}}$$ con $$\hat{n}=$$ dimensione media delle unità di secondo livello. 

##### Varianza within-group
È una media pesata delle varianze all'interno delle unità di secondo livello.

##### Coefficiente di correlazione con varianza between e within
In un modello senza predittori, si ha  
$$\hat{\sigma}^2_\epsilon=\sigma^2_w$$  
$$\hat{\sigma}^2_{U_0}=\sigma^2_b-\frac{\sigma^2_w}{\hat{n}}$$  
Potrebbe accadere che stimando un modello senza predittori, si ottenga un coeff. elevato che suggerisca un modello con effetto casuale specifico per i gruppi, ma potrebbe accadere che con qualche predittore il coeff. diminuisca e che l'intercetta casuale non sia più necessaria.  


### Analisi multilevel con covariate
$$y_{ij}=\alpha+\beta x_{it}+\epsilon_{it}$$  
con eterogeneità non osservata, il vero modello è  
$$y_it=\gamma_i+\beta x_{it}+\epsilon_{it}$$ con $$\gamma_i$$ eterogeneità non osservata.  

#### Rimozione eterogeneità non osservata
Con alcune trasformazioni, si può costruire un modello ad effetti fissi, che non ha il problema dell'assunzione $$U_{0j}\bot \epsilon_{ij}$$ e garantisce una stima di $$\beta$$ non distorta, ma non posso stimare $$\alpha$$ né $$\gamma_i$$.

##### Trasformata within-group
$$y_{it}-\bar{y_i}$$  
Elimino la variabilità between (generalmente più elevata nei panel), stimando $$\beta$$ solo con la variabilità within.

##### Trasformata first difference
$$y_{it}-y_{it-1}$$

#### Modellazione eterogeneità non osservata

##### Modello pooling (underfitting)
Modello con intercetta fissa: stima un'intercetta uguale per tutti  
$$y_{ij}=\beta_0+\beta_1 X_{ij}+\epsilon_{ij}$$  

##### Modello no-pooling (overfitting)
Modello con intercetta specifica per ogni gruppo: per stimare l'intercetta di un gruppo usa i dati solo di quel gruppo  
$$y_{ij}=\beta_{0j}+\beta_1 X_{ij}+\epsilon_{ij}$$ con $$\beta_{0j}$$ fissa  

##### Modello gerarchico o di pooling parziale  
Modello con intercetta casuale, specifica per ogni gruppo.  
$$y_{ij}=\beta_{0j}+\beta_1 X_{ij}+\epsilon_{ij}$$ con $$\beta_{0j}\sim\mathcal{N}(\gamma_{00},\sigma^2_{\beta})$$ e  
$$\gamma_{00}$$ intercetta globale, la media delle intercette  

Il modello tenderà ad un modello pooling se
- $$\sigma^2_{\beta}\rightarrow 0$$, l'intercetta casuale ha varianza $$0$$, quindi si ha una sola intercetta e di conseguenza $$\gamma_{00}=\beta_0$$  
- La numerosità campionaria è ridotta (seguo più il modello)

Il modello tenderà ad un modello no-pooling se
- $$\sigma^2_{\beta}\rightarrow \infty$$ modello no-pooling, in quanto una normale con varianza infinita è piatta e  
in ottica bayesiana è come se fosse una priori non informativa quindi si utilizzano tutti i gruppi
- La numerosità campionaria è elevata (seguo più i dati)

#### Modelli ad effetti casuali o ad effetti misti
Modellazione con pendenza casuale  
$$y_{ij}=\beta_{0j}+\beta_{1j}X_{ij}+\epsilon_{ij}$$ con $$\begin{pmatrix} \beta_{0j} \\ \beta_{1j} \end{pmatrix}\sim\mathcal{N}\Bigg(\begin{pmatrix} \gamma_{00} \\ \gamma_{10} \end{pmatrix}, \begin{pmatrix} \sigma^2_{\beta_0} & \rho\sigma_{\beta_0}\sigma_{\beta_1} \\ \rho\sigma^2_{\beta_1} & \sigma_{\beta_0}\sigma_{\beta_1} \end{pmatrix}\Bigg)$$

#### Modelli non nidificati
I gruppi presi non sono conteninuti l'uno nell'altro.  

##### Modello nidificato
Dato l'individuo $$i$$ (unità di I livello), appartenente alla famiglia $$j$$ (unità di II livello) e al gruppo $$k$$ (unità di III livello)  
$$y_{ijk}=\alpha_k+\gamma_{jk}+\beta x_{ijk}+\epsilon_{ijk}$$ con $$\alpha_k\sim\mathcal{N}(\alpha_0,\sigma^2_\alpha)$$  

##### Modello non-nidificato
Dato l'individuo $$i$$ (unità di I livello), appartenente alla classe d'età $$j$$  (unità di II livello) e alla nazione $$k$$ (unità di II livello)  
$$y_{i(j,k)}=\alpha_k+\gamma_{j}+\beta x_{ijk}+\epsilon_{ijk}$$ con $$\gamma_j\sim\mathcal{N}(\gamma_0,\sigma^2_\gamma)$$  


### Stima Bayesiana empirica
Stima dell'intercetta casuale. Non è una stima perché non è un parametro ma una variabile casuale, il termine giusto sarebbe previsione del valore.  
Prevede il valore di $$\beta_{0j}$$ per un gruppo $$j$$, si prova che la previsione è un valore atteso.  
Stima bayesiana empirica del modello ad intercetta casuale senza predittori 
Stima bayesiana empirica di $$\hat{\beta_{0j}}$$ (modello ad intercetta casuale senza predittori) di Snijder & Boskers (analoga a Gelman & Hill): media pesata della media specifica del gruppo $$j$$ (no-pooling) e della media totale (pooling)

#### Teoria Bayesiana
Elicitazione: rappresentazione della conoscenza a priori in una distribuzione (a priori).

Dati  
$$y_i\sim\mathcal{N}(\mu,\sigma^2_0)$$ con $$\sigma^2_0$$ noto e $$\mu$$ ignoto  
$$\mu\sim\mathcal{N}(\mu_0,\tau^2_0)$$ con $$\mu_0$$ e $$\tau^2_0$$ iperparametri della distribuzione a priori

Si dimostra che la “stima'' Bayesiana empirica è analoga alla media a posteriori $$E(\mu\vert y)$$

Tramite il teorema di Bayes (e algoritmi iterativi quali Metropolis-Hastings, Gibbs sampling o
Hamiltonian Monte Carlo per risolvere l'integrale, o si usano le distribuzioni coniugate come questo caso)

$$f(\mu\vert y)=\frac{f(y\vert \mu)\cdot f(\mu)}{\int_\mu f(y\vert \mu)\cdot f(\mu)d\mu}$$

si dimostra che la distribuzione a posteriori è la seguente

$$\mu\vert y\sim\mathcal{N}\left (\frac{\tau^2_0\bar{y}+\frac{\sigma^2_0}{n}\mu_0}{\tau^2_0+\frac{\sigma^2_0}{n}},\frac{\sigma^2_0\tau^2_0}{\frac{\sigma^2_0}{n}+\tau^2_0}\right )$$

Il modello gerarchico è un compromesso tra il modello pooling e no-pooling, la stima Bayesiana empirica è un compromesso tra la media totale e la media specifica del gruppo $$j$$.  
Il modello multilevel effettua un 'borrowing' dell'informazione prendendo anche da altri gruppi.  
La stima bayesiana è una media pesata della media campionaria (che in un modello normale di media ignota e varianza ignota è la stima MV, quindi usando solo i dati) e la media a priori.  
- $$n\rightarrow\infty$$ la media a posteriori tende alla stima MV  
- $$\tau^2_0\rightarrow\infty$$ meno è informativa la priori, più peso ha alla stima MV e meno la priori
- $$\sigma^2_0\rightarrow\infty$$ la varianza dei dati, che è nota, se è alta più importanza avrà la media a priori

Il valore atteso della distribuzione a posteriori, differisce dalla Bayesiana empirica, in quanto in quest'ultima non si assume una distribuzione a priori e al posto della media e varianza a priori si hanno le stime (MV) del modello pooling.

La verosimiglianza penalizzata, può essere vista come una variante frequentista della distribuzione a priori.


### Modelli lineari generalizzati gerarchici
Generalized Linear Mixed Models (GLMM), analogia LM$$\rightarrow$$GLM.  
Per la previsione del tasso di successo, si effettua una media pesata di ogni gruppo

$$\theta_j=\frac{\sum_{l\in j} N_l \theta_l}{\sum_{l\in j} N_j}$$

Questo però nel caso di più variabili discrete a diversi livelli, il campione necessario deve essere enorme per soddisfare tutte le combinazioni. Per evitare di riempire tutte le informazioni, si possono usare i modelli gerarchici per fare 'borrowing' dell'informazione laddove è presente (rischio: shrinkage to mean).

Modello a gerarchie imperfette: alcune sono gerarchiche altre sono dello stesso livello.

#### GLMM Logit
$$\mbox{Logit}\big\{Pr(y_{ij(k,l)}=1)\big\}$$  

#### GLMM Poisson
Posso farlo sul tasso invece che sul semplice numero, ad esempio il tasso di migratorietà, con intercetta casuale sulle nazioni.

Un altro caso: tasso di mortalità prematura. Si possono ipotizzare distribuzioni differenti modellando la mistura. Oppure con un modello gerarchico, si tiene fissa la mortalità adulti e variabile la mortalità prematura (come variabile effetto casuale).

#### GLMM Multinomiale
- Modello a destinazioni multiple
- Rischi competitivi (non sono indipendenti tra loro gli eventi)
- Estensione del Logit
- Problema dell'[indipendenza da alternative irrilevanti](https://en.wikipedia.org/wiki/Independence_of_irrelevant_alternatives#In_econometrics)


### Stima dei parametri
I parametri con OLS sono Best Linear Unbiased Estimator (BLUE) se vale l'omoschedasticità.

Con un modello gerarchico, se si vuole fare una stima basata sulla MV, l'inferenza sarebbe legata a meno due volte la log-verosimiglianza. Il problema è che bisogna conoscere la matrice delle varianze degli effetti casuali, che è sconosciuta e si otterrebbero stime distorte. 

Il modello logistico lo sistima con la verosimiglianza marginale.

#### Restricted (o Residual) Maximum Likelihood
La REML, si basa su una combinazione lineare dei dati affinché la distribuzione non dipenda da $$\beta$$, si stimano i parametri che definiscono la matrice di varianze e covarianze con il metodo MV, e dopo si procede ad una stima anche dei parametri $$\beta$$.

La stima non distorta della varianza di una v.a. $$Y\sim\mathcal{N}(\mu,\sigma^2)$$ è una stima REML. Si ha una funzione di verosimiglianza, con $$\mu$$ e $$\sigma^2$$ e stima di $$\sigma^2$$ dipende dalla stima di $$\mu$$, quindi nella stima MV non tengo conto che perdo un grado di libertà per stimare $$\mu$$ e poi costruire all'interno la stima di $$\sigma^2$$. 

##### Proprietà
- Le stime REML restituiscono stime della varianza non distorta, diversamente dalla MV
- La stime REML sono analoghe al metodo dei Minimi Quadrati Pesati.
- La verosimiglianza 'ristretta', ottenuta dalla REML non gode delle stesse proprietà della stima MV ordinaria, e il test rapporto di verosimiglianze (TRV) non è possibile

##### Come scegliere tra REML e MV
Dipende da $$n$$ e $$p$$ se  
- $$n$$ grande e $$p$$ piccolo, la distorsione tra le varianze è piccola
- $$n$$ è piccolo e $$p$$ grande, ci può essere differenza tra le due stime



 


















<!---


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
    proc print data=a (obs=10); * obs mostro prime n righe;
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

&nbsp;
&nbsp;

<button class="collapsible" id="es014">Esempio 14: Modelli parametrici (3)</button>
<div class="content" id="es014data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo: 
    (Esercizio 1) Interpretazione Weibull
    (Esercizio 2) Esponenziale a tratti (preparazione df)
    (Esercizio 3) 
    *******************************************************/

    ****************************** (Esercizio 1) ******************************;
    /* Stimato il modello Weibull
    exp (4,46) = 86,480  durata media episodi 

    RISCHI DI LASCIARE LAVORO AL VARIARE PERMANENZA:
    poichè: h(t) = 0,02155 * 0,8627 t (elevato a -0,1373)
    si ricava:

    a) rischio lasciare lavoro al primo mese occupazione:
    h(t=1)= exp(-3,8356)* 0,8627=0,02155* 0,8627 = =0,01854 

    b) rischio lasciare lavoro dopo 10 anni:  
    h(t=120) = 0,02155* 0,8627* 120(elevato a 0,8627-1) = 0,0095

    c) variazione rischio PASSANDO DAL 1mo AL 120mo GIORNO: 0,0095/0,01854

    CALCOLO TEMPO MEDIANO:
    poichè:  S(tMe)=exp(-0,02155 *tMe (elevato a 0,8627)=0,5 
    TMe=56,9  mesi */

    ****************************** (Esercizio 2) ******************************;
    libname dir "/home/dati";
    data MIO;
    set dir.PIPPO;
    run;

    /* Modello esponenziale a tratti.
    Preparo i dati per avere 3 periodi di 24, 36, residuo su 60: fino a 24, 25-60, 61+.
    1. costruisco la variabile n che mi dice IL NUMERO MASSIMO DI tratti di ciascun episodio
    2. costruisco tre nuove variabili che servono per model:
    tempo=durata del tratto - evento=tratto con censura o evento - j=num tratto */

    data m;
    set mio;
    * creo n= numero max di tratti temporali per ciascun episodio;
	    if durata le 24 then n=1;
	    if durata gt 24 and durata le 60 then n=2;
	    if durata gt 60 then n=3;
    * creo j e le specifiche di durata per ciascun tratto;
    do j=1 to n;
	    if j le (n-1) then do;   /* tratti precedenti ultimo */
		    evento=0;
		    if j=1 then tempo=24;
		    if j=2 then tempo=36;
		    end; 
	    if j=n then do;     /* ultimo tratto */
		    evento=des;
		    if j=1 then tempo=durata;
		    if j=2 then tempo=durata-24;
		    if j=3 then tempo=durata-(24+36);
		    end;
    output;
    end; 
    run;

    * Stimo esponenziale a pezzi con covariate;
    proc lifereg  data=m;
    class j;
    model tempo * evento(0) = edu coho2 coho3 lfx pnoj pres j / dist=exponential;
    title “stima esponenziale a tre pezzi con covariate”;
    run;

    ****************************** (Esercizio 2) ******************************;
    * Stimo esponenziale a pezzi con covariate e interazione con pres;
    proc lifereg  data=m;
    class j;
    model tempo * evento(0) = edu coho2 coho3 lfx pnoj pres j j*pres/ dist=exponential;
    title “stima esponenziale a tre pezzi con interazione tratti e pres;
    run;
	```
</div>
<embed src="/assets/images/Statistics/EHA_014.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">


## SAS Labs - Parte 2
<button class="collapsible" id="es015">Esempio 15: Frailty (1)</button>
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

&nbsp;
&nbsp;

<button class="collapsible" id="es016">Esempio 16: Frailty (2)</button>
<div class="content" id="es016data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo:
    I dati sono relativi alla mortalita infantile. 
    Due identificativi: bambino (kidid) e madre (momid), 
    la variabile time indica la durata e la variabile death definisce se 
    l'evento (il decesso) e stato osservato oppure se il dato e censurato. 
    Variabili esplicative: eta della madre, ordine di nascita, e intervallo 
    di tempo con la nascita precedente. 
    Variabili tempo dipendenti: l'intervallo di tempo con la nascita successiva. 
    Le dummy f0011 e f1223 definiscono se in tempi brevissimi (0-11 mesi) o 
    brevi (12-23 mesi) e avvenuta una nascita ulteriore.
    Nota: i dati già sono splittati.
    (Esercizio 1) Modello Esponenziale a tratti
    (Esercizio 2) Modello Cox con frailty Gamma
    (Esercizio 3) Modello Esponenziale con frailty log-normale
    (Esercizio 4) Modello Gompertz con frailty log-normale
    (Esercizio 5) Modello Gompertz senza frailty
    *******************************************************/

    * ods pdf file='/home/EHA_016.pdf';
    * import STATA file;
    proc import datafile="/home/dati/guatemala.dta" 
	    out=guatemala dbms = dta replace;
    run;

    ****************************** (Esercizio 1) ******************************;
    /* Stimo modello esponenziale (parametrico) a tratti (il df è già splittato)
    Le variabili che identificano il periodo sono a0 a1to5 a6to11 e a12to23*/
    title "LIFEREG: mod. Esponenziale a tratti senza frailty";
    proc lifereg  data=guatemala;
    model time * death(0) = a0 a1to5 a6to11 a12to23 a24up mage mage2 borde 
    pdead p0014 p1523 p2435 p36up i011a1223 i011a24p i1223a24p / noint dist=exponential;
    run;

    ****************************** (Esercizio 2) ******************************;
    * Stimo modello Cox (semi parametrico) con frailty Gamma;
    title "PHREG: mod. Cox con frailty Gamma";
    proc phreg data=guatemala;
    class momid;
    model time * death(0) =  mage mage2 borde pdead p0014 p1523 p2435 p36up i011a1223 i011a24p i1223a24p;
    random momid / noclprint dist=GAMMA initialvariance=0.5;
    run;

    * Stimo modello Cox (semi parametrico) con frailty Gamma con Newton–Raphson;
    title "PHREG: mod. Cox con frailty Gamma (Newton–Raphson)";
    proc phreg data=guatemala;
    nloptions tech=newrap;
    class momid;
    model time * death(0) =  mage mage2 borde pdead p0014 p1523 p2435 p36up i011a1223 i011a24p i1223a24p;
    random momid / noclprint dist=GAMMA initialvariance=0.5;
    run;

    ****************************** (Esercizio 3) ******************************;
    /* I modelli non sono equivalenti, phreg semi parametrico con frailty,
    ma non c'è modo di aggiungere la frailty con lifereg.
    Per stimare mod. parametrico con frailty, uso NLMIXED (non linear mixed models). 
    Con NLMIXED bisogna scrivere direttamente la log-verosimiglianza 
    della esponenziale a tratti */
    title "NLMIXED: mod. Esponenziale a tratti con frailty log-normale";
    PROC NLMIXED DATA=guatemala;
    lambda=exp(b0*a0+b15*a1to5+b611*a6to11+b1223*a12to23+b24up*a24up+
	    bmage*mage+bmage2*mage2+bborde*borde+bpdead*pdead+bp0014*p0014+
	    bp1523*p1523+bp2435*p2435+bp36up*p36up+bi0111223*i011a1223+
	    bi01124p*i011a24p+bi122324p*i1223a24p+e);
    * dove 'e' è il logaritmo della frailty;
    ll=-lambda*time + death*(LOG(lambda));
    MODEL time~GENERAL(ll);
    RANDOM e~NORMAL(0,s2) SUBJECT=momid;
    * la procedura non prevede effetti casuali gamma, solo log-normali;
    PARMS b0=-1.12 b15=-3.93 b611=-4.24 b1223=-4.76 b24up=-6.35 bmage=-0.14 
	    bmage2=0.0025 bborde=0.062 bpdead=0.10 bp0014=0.54 bp1523=-0.13 
	    bp2435=-0.26 bp36up=-0.39 bi0111223=0.82 bi01124p=1.63 bi122324p=0.07 s2=0.21;
    * parametri stimati con il modello senza frailty;
    run;
    /* La stima della varianza è s2, non è significativa ma
    non ha senso il test t perché:
    1. la distribuzione della varianza non è normale, tipicamente è asimmetrica
    2. è un test sulla frontiera dello spazio parametrico, perché la varianza 
    è per definizione >0 e se è uguale a 0 è il valore limite del parametro e le
    proprietà dei test non sono garantite */

    ****************************** (Esercizio 4) ******************************;
    /* Con NLMIXED stimo Gompertz, non ha la frailty Gamma, stimo log-normale.
    La stima richiede circa 20 minuti */
    title "NLMIXED: mod. Gompertz con frailty log-normale";
    proc nlmixed data=guatemala;
    gamma=exp(log_gamma);
    linp=b0*a0+b15*a1to5+b611*a6to11+b1223*a12to23+
	    b24up*a24up+
	    bmage*mage+bmage2*mage2+bborde*borde+bpdead*pdead+bp0014*p0014+
	    bp1523*p1523+bp2435*p2435+bp36up*p36up+ bi0111223*i011a1223+
	    bi01124p*i011a24p+bi122324p*i1223a24p+e;
    alpha=exp(-linp);
    G_t=exp((alpha/gamma)*(1-exp(gamma*time)));
    g=alpha*exp(gamma*time)*G_t;
    ll=(death=1)*log(g) +    	/* ll for observed failures */
	    (death=0)*log(G_t);		/* ll for censored failures */
    model ll ~ general(ll);
    RANDOM e~NORMAL(0,s2) SUBJECT=momid;
    PARMS b0=-0.76 b15=2.25 b611=3.48 b1223=3.74 b24up=7.98 bmage=0 bmage2=0 bborde=0 bpdead=0 bp0014=0 
	    bp1523=0.3362 bp2435=0.34 bp36up=0.39 bi0111223=-0.96 bi01124p=-1.587 bi122324p=-0.0657 
	    log_gamma=-10 s2=0.21;
    run;
    /*  WARNING: The final Hessian matrix is full rank but has at least 
    one negative eigenvalue. Second-order optimality condition violated.*/

    ****************************** (Esercizio 5) ******************************;
    title "NLMIXED: mod. Gompertz senza frailty";
    proc nlmixed data=guatemala ;
    gamma=exp(log_gamma);
    linp=b0*a0+b15*a1to5+b611*a6to11+b1223*a12to23+
	    b24up*a24up+ /* nel codice originale non era presente */
	    bmage*mage+bmage2*mage2+bborde*borde+bpdead*pdead+bp0014*p0014+
	    bp1523*p1523+bp2435*p2435+bp36up*p36up+bi0111223*i011a1223+
	    bi01124p*i011a24p+bi122324p*i1223a24p;
    alpha=exp(-linp);
    G_t=exp((alpha/gamma)*(1-exp(gamma*time)));
    g=alpha*exp(gamma*time)*G_t ;
    ll=(death =1)*log(g) +  	/* ll for observed failures */
	    (death=0)*log(G_t);     /* ll for censored failures */
    model ll~general(ll);
    PARMS b0=-0.76 b15 = 2.25 b611=3.48 b1223=3.74 b24up=7.98 bmage=0 bmage2=0 bborde=0 bpdead=0 bp0014=0 
	    bp1523=0.3362 bp2435=0.34 bp36up=0.39 bi0111223=-0.96 bi01124p=-1.587 bi122324p=-0.0657 
	    log_gamma=-10;
    estimate "gamma" exp(log_gamma);
    run;
    /*  WARNING: The final Hessian matrix is full rank but has at least 
    one negative eigenvalue. Second-order optimality condition violated.*/
    * ods pdf close;
	```
</div>
<embed src="/assets/images/Statistics/EHA_016.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es017">Esempio 17: Modelli gerarchici (1)</button>
<div class="content" id="es017data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo
    Dataset risultato test matematica studenti americani.
    mathach: punteggio di matematica
    ses: social-economic-status
    sector: scuola pubblica (0) o privata (1)
    school: identificativo scuola
    meanses: media dello stato socio economico degli studenti della scuola
    (Esercizio 1) Esplorazione df e struttura secondo livello
    (Esercizio 2) Modello gerarchico a intercetta casuale senza covariate
    (Esercizio 3) Modello gerarchico a intercetta casuale con covariata (a effetto fisso)
    (Esercizio 4) Modello pooling e no pooling
    (Esercizio 5) Grafico dei tre modelli
    (Esercizio 6) Modello gerarchico a intercetta e pendenza casuale
    *******************************************************/
    libname in '/home/dati';
    options nocenter nodate nonumber nolabel;

    ****************************** (Esercizio 1) ******************************;
    * media e SD di ses e mathach;
    proc means data = in.hsb12 mean std;
    var ses mathach;
    run;

    * tabella di frequenza di school;
    proc freq data=in.hsb12;
    tables school;
    run;

    /* Si potrebbe introdurre nel modello gerarchico, 
    delle covariate relative all'unità di secondo livello (scuola) */
    * ordino df by school;
    proc sort data = in.hsb12;
    by school;
    run;
    /* Le variabili che interessano sono relative alle scuole
    quindi ripetute per ogni soggetto appartenente alla scuola,
    pertanto prendo solo una osservazione (last) per ogni scuola */
    data level2;
    set in.hsb12;
    by school;
    if last.school;
    keep school meanses sector;
    run;
    * media e SD di meanses sector;
    proc means data = level2 mean std;
    var meanses sector;
    run;

    ****************************** (Esercizio 2) ******************************;
    * modello GERARCHICO senza covariate;
    title "Modello 1: Modello a intercetta casuale";
    * nella proc mixed posso aggiungere method=ml per fare MV invece di REML;
    *ods graphics on;
    proc mixed data = in.hsb12 covtest noclprint plots(maxpoints=10000);
    class school; * la variabile che definisce i gruppi deve essere class;
    model mathach = / solution;
    random intercept / subject = school solution;
    /* solution in random restituisce le stime bayesiane 
    empiriche della intercetta casuale. Senza restituisce solo
    la stima della varianza residua e dell'effetto casuale */
    run;
    *ods graphics off;
    /* con REML stima la varianza dell'effetto casuale.
    Newton-Raphson per MV
    \sigma^2_{\beta_0}=8.6
    \sigma^2_{\epsilon}=39.2
    Per la frailty sas non fa l'errore, qui da il test t sulla varianza
    che è sbagliato.
    Il valore -2.6638 dell'intercetta dell'effetto casuale (che è la 'stima'
    bayesiana empirica) è la deviazione che si ha nella scuola 1224 rispetto 
    all'intercetta fissa. Quindi se voglio prevedere
    l'intercetta della scuola 1224, questa sarà 12.6-2.6638 */

    ****************************** (Esercizio 3) ******************************;
    * modello GERARCHICO con covariata;
    /* Esporto le stime sia degli effetti fissi che casuali 
    nel caso in cui serva fare previsione sulle specifiche scuole */
    ods output SolutionF=Fixed SolutionR=Random;
    title "Modello 2: Modello a intercetta casuale con effetto fisso per la variabile ses";
    title2 "ses e' lo status socio-economico";
    proc mixed data = in.hsb12 noclprint covtest noitprint plots(maxpoints=10000);
    class school;
    model mathach = ses / solution ;
    random intercept / subject = school solution;
    run;
    ods output close;
    * Ora si ha la stima della pendenza;

    ****************************** (Esercizio 4) ******************************;
    * modello POOLING; 
    /* ods html file="mod_pooling.html"; * utile per export in html;*/
    title "Modello 3: Modello Pooling";
    proc reg data = in.hsb12 plots(maxpoints=10000); * regressione lineare;
    model mathach = ses;
    run;
    /* ods html close; */

    * modello NO-POOLING;
    /* Per stimare un'intercetta specifica per ogni scuola,
    creo la covariata scuola, trasformo in dummy e l'intercetta specifica
    di ogni scuola sarà il coefficiente di ciascuna dummy. 
    160 scuole, 160 dummy (non stimando l'intercetta), 
    per crearle uso il comando class disponibile
    su proc glm e non proc reg, ma è comunque un modello lineare */
    title "Modello 4: Modello ad effetti fissi: un'intercetta per ogni scuola";
    proc glm data = in.hsb12;
    class school;
    model mathach = ses school/ solution noint;
    * noint: non stimo intercetta fissa così da avere 1 dummy per ogni scuola;
    run;
    quit; * richiesto da proc glm;

    ****************************** (Esercizio 5) ******************************;
    /* Per ottenere un grafico leggibile, si crea un df specifico 
    in cui si scelgono 4 scuole e  si prendono i 
    valori predetti dei tre modelli delle stime
    delle intercette per le 4 scuole */
    data toplot;
    set in.hsb12;
    if school=2208 or school=3610 or school=7697 or school=9550;
    /* predpool = 12.74740+3.18387*ses; * previsione con pooling; */
    predpool = 12.74740+2.19117197*ses;
    /* per rendere più chiara la rappresentazione assegno una
    pendenza al modello pooling pari a quella no-pooling */
    prednopool = 14.47743573*(school=2208)+15.09173859*(school=3610)+
	    15.15591109*(school=7697)+10.97293026*(school=9550)+
	    2.19117197*ses; * previsione no pooling;
    /* predmlevel=12.6575+1.5367*(school=2208)+2.1494*(school=3610)+
	    1.9689*(school=7697)-1.3369*(school=9550)+
	    2.3903*ses; * previsione gerarchico; */
    predmlevel = 12.6575+1.5367*(school=2208)+2.1494*(school=3610)+
	    1.9689*(school=7697)-1.3369*(school=9550)+
	    2.19117197*ses;
    /* per rendere più chiara la rappresentazione assegno una
    pendenza al modello multilevel pari a quella no-pooling */
    run;

    * ordino per scuola (il grafico non verrebbe pulito);
    proc sort data = toplot;
    by school;
    run;

    * grafico;
    goptions reset = all;
    symbol1 v = none i = join c = red ; * modello pooling;
    symbol2 v = none i = join c = blue  ; * modello no pooling;
    symbol3 v = none i = join c = black  ; * modello multilevel;
    SYMBOL4 v=circle c=black i=none;
    axis1 order = (-4 to 3 by 1) minor = none label=("SES");
    axis2 order = (0 to 22 by 2) minor = none label=(a = 90 "Math Achievement Score");
    proc gplot data = toplot;
    by school;
    plot predpool*ses prednopool*ses predmlevel*ses mathach*ses/ vaxis = axis2 haxis = axis1 
    overlay; * 4 grafici sovrapposti;
    run;
    quit;
    /* Il modello multilevel è sempre più vicino al no-pooling.
    La numerosità interna ai gruppi è elevata, non c'è una grande
    differenza al no-pooling, quindi vanno bene entrambi */

    * tabella di frequenza delle scuole;
    proc freq data=in.hsb12;
    tables school;
    run;

    ****************************** (Esercizio 6) ******************************;
    * modello intercetta e pendenza casuale;
    title "Modello 5: Si include un effetto casuale (pendenza) per la variabile ses";
    title2 "ses e' lo status socio-economico";

    proc mixed data = in.hsb12 noclprint covtest noitprint plots(maxpoints=10000);
    class school;
    model mathach = ses / solution ddfm = bw notest;
    * notest: non riportare i test per gli effetti fissi;
    random intercept ses / subject = school type = vc gcorr solution;
    /* un gcorr: qualsiasi tipo di matrice di varianze e covarianze;
    vc gcorr: solo le varianze, imponendo covarianza uguale a 0, qui si
    ottengono stime simili, perché la correlazione è bassa */
    run;
    /* UN(1,1) varianza intercetta casuale
    UN(2,2) varianza pendenza casuale
    UN(2,1) covarianza 

    Con parametro VC (ma vale lo stesso con UN), si nota che
    Covariance Parameter Estimates, per  SEX, la deviazione casuale è molto debole (0.4),
    la varianza è piccola, rispetto l'intercetta (4.8) è 1/10. 
    Sembra che l'aggiunta della pendenza casuale non migliora tanto il modello

    Con SOLUTION ottengo le stime bayesiane empiriche della intercetta e pendenza
    casuali. Per ogni scuola ho la deviazione per intercetta e pendenza:
    anche qui le stime bayesiane le deviazioni è molto leggera nella 
    maggior parte dei casi 
    
    Scegliere metodo MV o REML se porta differenza può impattare le stime bayesiane
    empiriche in quanto è una media pesata delle varianze stimate o con MV o REML */
	```
</div>
<embed src="/assets/images/Statistics/EHA_017.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">

&nbsp;
&nbsp;

<button class="collapsible" id="es018">Esempio 18: Modelli gerarchici (2)</button>
<div class="content" id="es018data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo:
    Analisi dati sondaggi politici (USA '88) e previsioni per uno stato
    Y: 1 'rep', 0 'dem'
    black: colore pelle
    female: genere
    age: 4 classi di età
    edu: 4 categorie istruzione
    state: stato
    region_full: 5 regioni (gruppi di stati)
    y_prev_full: proporzione di voto per 'rep' della precedente 
	    elezione (variabile relativa all'unità di secondo livello)
    (Esercizio 1) Modello logistico con intercetta fissa
    (Esercizio 2) Modello logistico con intercetta casuale
    (Esercizio 3) Modello logistico con intercette casuale
    (Esercizio 4) Previsione su df census
    *******************************************************/

    * import STATA file;
    proc import datafile="/home/USpoll.dta" 
	    out=USpoll dbms = dta replace;
    run;

    * Aggiungo variabile interazione colore e genere;
    data USPollcomplete;
    set USpoll;
    blackfem=black*female;
    run;

    /* Visualizzo output data
    2193 osservazioni */
    proc freq data=USPollcomplete;
    tables state;
    run;

    ****************************** (Esercizio 1) ******************************;
    * logistico a intercetta fissa per ogni stato;
    proc logistic  data=USPollcomplete;
    class state;
    model y(event='1')=black female state; * conviene specificare l'evento target;
    title "modello logistico semplice";
    run;
    /* Gli standard error di molti stati hanno valori enormi rispetto la stima
    questo accade perché molti stati hanno poche osservazioni. 
    è un modello no-pooling, e non è stimabile, l'unica strade è fare
    'borrowing' information con il gerarchico */

    ****************************** (Esercizio 2) ******************************;
    * logistico a intercetta casuale per ogni stato;
    proc glimmix  data=USPollcomplete;
    class state;
    model y(event='1')=black female /dist=binary solution;
    random int /subject=state solution;
    title "modello logistico con intercetta casuale per stato";
    run;
    /* Covariance Parameter Estimates: intercetta 0.17 che con una varianza residua
    dell'ordine dell'1 è elevato.
    Le stime bayesiane empiriche (le soluzioni degli effetti casuali), gli SD 
    sono più accettabili, ma ci interessa poco la significatività in quanto sono
    previsioni. Se ci sono poche osservazioni tende alla stima no-pooling (intercetta fissa). */

    ****************************** (Esercizio 3) ******************************;
    /* aggiunta dell'effetto della votazione precedente (riferito allo stato) e le
    intercette casuali di età, istruzione, regione (unità di III livello). 
    Non si tratta di effetti casuali (pendenze) ma di intercette casuali, che ad esempio
    avrebbe significato che l'effetto dell'età cambiava di stato in stato, che è diverso
    da avere un'intercetta specifica per età */
    proc glimmix  data=USPollcomplete;
    class state region_full age edu;
    model y(event='1')=black female blackfem v_prev_full/dist=binary solution;
    random int /subject=state solution;
    random int /subject=region_full solution;
    random int /subject=age solution; 
    /* 4 categorie di age = 4 intercette casuali, se avessimo 
    avuto un effetto casuale sulla age avremmo avuto 50 effetti casuale,
    cioè una pendenza diversa per ogni stato */
    random int /subject=edu solution;
    title "modello (non nidificato) a più intercette casuali";
    run;

    ****************************** (Esercizio 3) ******************************;
    /* Importo il dataset del census, contenente la numerosità degli
    individui con le caratteristiche usate nel modello (3136 celle delle combinazioni).
    Utilizzo questo df per la previsione. */
    proc import datafile="/home/dati/censusnew.dta" 
	    out=census dbms = dta replace;
    run;

    /* Per ogni stato, in questo caso state 1, ho le varie combinazioni d'età e di istruzione
    e prendo tutti gli effetti casuali delle due variabili. Dopo di che costruisco il predittore
    lineare definito da una parte fissa e una casuale, la parte fissa sono gli effetti fissi,
    prendo l'intercetta, colore per coeff. colore, genere per coeff. genere, voto precedente
    per l'effetto del voto precedente, poi ho la parte casuale, dove l'effetto dello stato 
    e della regione, più l'effetto dell'età e istruzione.
    Calcolo il valore predetto della probabilità di voto per i 'rep'
    theta_l=P(y_l=1)=exp(preditore lineare)/(1+exp(predittore lineare)).
    Quindi, il nostro predittore lineare ha una parte fissa (fixed) e una casuale (random). 
    Il valore predetto della percentuale di voti per i repubblicani 
    si ottiene facendo l'inverso della funzione logit. */
    data census88;
    set census;
    if state = 1;
    blackfem = black*female;
    ranage = 0.08933; 				/* Sol. Random Eff.: Intercept: age 1 */
    if age=2 then ranage=-0.08420;	/* Sol. Random Eff.: Intercept: age 2 */
    if age=3 then ranage=0.04275;	/* Sol. Random Eff.: Intercept: age 3 */
    if age=4 then ranage=-0.04787;	/* Sol. Random Eff.: Intercept: age 4 */
    ranedu=-0.1547;					/* Sol. Random Eff.: Intercept: edu 1 */
    if edu=2 then ranedu=-0.02730;	/* Sol. Random Eff.: Intercept: edu 2 */
    if edu=3 then ranedu=0.1691;	/* Sol. Random Eff.: Intercept: edu 3 */
    if edu=4 then ranedu=0.01290;	/* Sol. Random Eff.: Intercept: edu 4 */
    * fixed: parte fissa del predittore lineare;
    fixed = -2.1733-		/* Sol. for Fixed Eff.: Intercept */
	    black*1.6407-		/* Sol. for Fixed Eff.: black */
	    female*0.08726-		/* Sol. for Fixed Eff.: female */
	    blackfem*0.1696+	/* Sol. for Fixed Eff.: blackfem */
	    prev_v*4.6759;		/* Sol. for Fixed Eff.: v_prev_full */
    * random: parte casuale del predittore lineare;
    random = 0.1626+ 		/* Sol. Random Eff.: Intercept: state 1 */
	    0.5006+				/* Sol. Random Eff.: Intercept: region_full 3 */
	    ranage + ranedu;
    * pred: previsione di voti per 'rep' per ognuna delle categorie;
    pred = exp(fixed+random)/(1+exp(fixed+random));
    npred = pred*N;
    run;

    /* La somma di npred è il numeratore della somma pesata (N_l*pred_l), 
    N il denominatore (N_l). Il loro rapporto è la % di voti per 'rep' prevista
    per lo stato 1 */
    proc print data=census88;
    sum npred N;
    run;
    /* Effettuo la divisione (a mano) i totali
    1877363/3077948=0.6099, quindi 61% prevista 'rep' per stato 1 */
	```
</div>
<embed src="/assets/images/Statistics/EHA_018.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">


&nbsp;
&nbsp;

<button class="collapsible" id="es019">Esempio 19: Modelli a tempi discreti</button>
<div class="content" id="es019data" markdown="1">

	```sas
    /*******************************************************
    Obiettivo:
    Dati su indagine su 180 studenti (sia in formato 
    person-data che person-period)
    tsex: 'classe' in cui è avvenuto l'evento (da 7 a 12 grade)
    pt: numero di transizioni genitoriali prima del 7 grade
    ?: livello di comportamento antisociale dei genitori
    period: periodo temporale di riferimento
    Modelli a tempi discreti
    (Esercizio 1) Modello ad odds proporzionali
    (Esercizio 2) Modello ad odds proporzionali con tempo
    (Esercizio 3) Modello ad odds proporzionali con tempo a tratti
    (Esercizio 4) Modello per confrontare la Frailty
    (Esercizio 5) Frailty a tempi discreti
    *******************************************************/

    * set path;
    libname firts '/home/dati';

    * sort by pt (per il grafico della sopravvivenza);
    proc sort data = firts.firstsex;
    by pt;
    run;

    * costruisco la sopravvivenza;
    * PL Product Limit (KM);
    proc lifetest data = firts.firstsex;
    time time*censor(1);
    by pt;
    ods output ProductLimitEstimates = tsex;
    run;

    * Esplorativa: grafico S e h, rispetto pt;
    data fig11_1b;
    set tsex (where = (survival~=.)); 
    if time = 0 then time = 6;
    lags = lag(survival); * valore precedente;
    by pt;
    if ~ first.pt then do;	* se non è la prima;
    hazard = 1 - survival/lags; * funzione di rischio;
    end;
    keep survival hazard time pt;
    run;

    * Grafico;
    goptions reset=all; /* device=gif570 */
    symbol1 c=red i=stepJ width=2; * pt=0;
    symbol2 c=blue i=stepJ width=2; * pt=1;
    axis1 order = (0 to .5 by 0.1) label=(a=90 'Estimated hazard probability');
    axis2 order = (0 to 1 by .5) label=(a=90 'Estimated survival probability');
    axis3 order = (6 to 12 by 1) minor = none label=('Grade');
    proc gplot data=fig11_1b;
    format time 2.0 survival hazard 3.1;
    plot hazard*time  = pt / vaxis=axis1 haxis=axis3;
    plot survival*time = pt / vaxis=axis2 haxis=axis3 vref=0.5 lvref=21;
    run;
    quit;
    /* Per la variabile pt ha senso un modello a rischi proporzionali?
    Per la prima parte non sembra valere la proporzionalità (se non sono
    proporzionali i rischi non saranno proporzionali gli odds) */

    ****************************** (Esercizio 1) ******************************;
    * Dati nel formato person-period per la stima dei modello;
    * Modello 1: modello ad odds proporzionali;
    proc logistic data = firts.firstsex_pp descending;
    model event (event='1') = pt;
    run;
    /* Intercetta: -2.1493 = log(h_j/1-h_j) = beta_0
    PT: 0.7131 = beta_1.
    Il rischio è costante, è l'equivalenti a tempi discreti
    di un modello esponenziale, ma il precedente grafico 
    del rischio mostra che non è costante, non va bene.
    Si può usare la variabile period, che definisce
    il periodo temporale, all'interno del modello. Così il coeff.
    della variabile period, si può interpretare come la variazione
    temporale del rischio di base, il logit del rischio di base
    varierà linearmente rispetto al period (crescente o decrescente) */

    ****************************** (Esercizio 2) ******************************;
    * Modello 2: modello ad odds proporzionali con tempo;
    proc logistic data = firts.firstsex_pp descending;
    model event = pt period;
    run;
    /* Usando un effetto lineare si immagina un effetto monotono,
    a seconda del valore di beta1 però il rischio decresce 
    all'inizio e crescere dopo, quindi non monotono. 
    Invece di usare la variabile period, si usa la dummy per ogni 
    periodo temporale. In questo modo la forma del rischio di base
    sarà definita dai dati, in modo analogo all'esponenziale a tratti,
    è a rischio costante per ogni tratto. Come cambia lo definiscono
    i parametri d7 e d12 */

    ****************************** (Esercizio 3) ******************************;
    * Modello 3: modello ad odds proporzionali con dummy tempo;
    proc logistic data = firts.firstsex_pp descending;
    model event = pt d7-d12;
    output out = pred xbeta=g; 
    /* xbeta valore predetto dei beta, g è il pred. lineare, 
    pred è il df di output, così da usarli per il grafico */
    run;
    /* I parametri prima decrescono e poi crescono, 
    quindi il rischio dell'evento decresce nei primi
    due periodi e poi cresce */

    * Preparo i dati ordinandoli per il grafico;
    proc sort data = pred;
    by pt period;
    run;

    * Preparo il df per il grafico;
    data figura;
    set pred;
    if pt = 0 then do;
    lhz0 = g;					* logit del rischio;
    odds0 = exp(g); 			* odds del rischio;
    hazard0 = odds0/(1+odds0); 	* valore del rischio;
    end;
    if pt = 1 then do;
    lhz1 = g;
    odds1 = exp(g);
    hazard1 = odds1/(1+odds1);
    end;
    rename period = time;
    run;

    * Parametri grafico;
    axis1 order = (6 to 12 by 1) minor = none label=('Grade');
    axis2 order = (-4 to 1 by 1) minor = none label=(a=90 'Logit(hazard)');
    axis3 order = (0.0 to 0.8 by .2) minor = none label=('Odds');
    axis4 order = (0.0 to 0.5 by .1) minor = none label=('Hazard');
    symbol1 c=blue i=j value=none;
    symbol2 c=red i=j l=4 value=none;
    legend label=none value=(height=1 font=swiss 'Pt=0' 'Pt=1' ) 
	    position=(top left inside) mode=share cborder=black;

    * Grafico forma rischio, log rischio e odds;
    proc gplot data=figura;
    plot (lhz0 lhz1)*time
	    / legend = legend1 overlay vaxis=axis2 haxis=axis1;
    plot (odds0 odds1)*time
	    / legend = legend1 overlay vaxis=axis3 haxis=axis1;
    plot (hazard0 hazard1)*time
	    / legend = legend1 overlay vaxis=axis4 haxis=axis1;
    run;
    quit;
    /* Valori predetti del rischio rispetto il modello, 
    si prevede una proporzionalità perfetta rispetto
    al logit del rischio (per costruzione) e ora il rischio,
    non si discosta molto dal grafico del rischio osservato */

    ****************************** (Esercizio 4) ******************************;
    /* Modello 4; con variabile relativa al comportamento antisociale dei genitori. 
    Si rimuove l'intercetta per avere la stima diretta dei parametri di tutti i periodi */
    proc logistic data=firts.firstsex_pp descending ;
    model event = d7 d8 d9 d10 d11 d12 pt pas / noint ;
    pt:  test pt;
    pas: test pas;
    run;

    ****************************** (Esercizio 5) ******************************;
    * Modello 5: Frailty a tempi discreti;
    /* Intercetta casuale specifica per ogni studente (frailty univariata). 
    Ci può essere sospetto di una forma di selezione? Forse sì perché l'andamento
    del rischio ad U, può essere causato dalla selezione, dove la popolazione 
    iniziale (a tempo 7) sperimenta più facilmente il rischio e rimane la popolazione meno 
    a rischio (a tempo 8). Quindi motivo l'utilizzo della frailty */
    proc glimmix  data=firts.firstsex_pp;
    class ID;
    model event(event='1')=d7 d8 d9 d10 d11 d12 pas pt / noint dist=binary solution;
    random int /subject=ID solution;
    output out = predm predicted=p;
    /* Le stime non sembrano cambiare e il rischio mantiene quella forma. 
    Solo alcuni individui hanno valori di intercetta casuali elevati, ma
    globalmente non sembra avere aiutato la frailty, in quanto le stime delle 
    intercette casuali hanno quasi tutti valori nulli, quindi scostamento nullo. */

    /* Ultimo sperimento: divido in due il periodo e ristimo il modello */
    * divido in due il period;
    run;
    data prova;
    set firts.firstsex_pp;
    if period>8 then per9=1;
    else per9=0;
    run;
    * ristimo un modello con la nuova configurazione;
    proc logistic data=prova descending ;
    model event = d7 d8 d9 d10 d11 d12 pt pas pt*d7 pt*d8 /noint ;
    output out = pred2 xbeta=g;
    run;
	```
</div>
<embed src="/assets/images/Statistics/EHA_019.pdf#toolbar=0&navpanes=0&scrollbar=0&statusbar=0" type="application/pdf">







































## Utili
### Century Months
Data in C.M. : numero di mesi da inizio secolo 01/01/1900  

$$\mbox{C.M.}=\mbox{YY}\times 12+\mbox{MM}$$  
es. Marzo 1946: $$\mbox{C.M.}=46\cdot 12+3=555$$  

$$\mbox{YY}=(\mbox{C.M.}-1)/12+1900$$  
$$\mbox{MM}=\mbox{C.M.}-(\mbox{intero(YY)}\times 12)$$  
es. $$555 \rightarrow \mbox{Anno}=(555-1)/12=46.16,\quad \mbox{Mese}=555-(46\cdot 12)=555-552=3$$



### Risorse
- [Andrew Gelman](http://www.stat.columbia.edu/~gelman/)
- [Codice R su RADON per modelli multilevel](http://www.stat.columbia.edu/~gelman/arm/examples/radon/)
- [Mixed effects modeling](https://towardsdatascience.com/when-mixed-effects-hierarchical-models-fail-pooling-and-uncertainty-77e667823ae8)



...
