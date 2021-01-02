---
title: "Appunti di Statistica Bayesiana"
excerpt: "with R"
date: 2021-01-02
tags: [statistics, math, theory, bayesian, R]
mathjax: "true"
---


```R
# funzioni
# https://mran.microsoft.com/snapshot/2017-12-11/web/packages/TeachBayes/TeachBayes.pdf
source("https://raw.githubusercontent.com/AlbGri/AlbGri.github.io/master/assets/files/R/LearningBayes.R")

# lib
suppressMessages(library(ggplot2))
suppressMessages(library(gridExtra))
suppressMessages(library(dplyr))
```

## Introduction

### Probabilità


```R
areas <- c(2, 1, 2, 1, 2)
spinner_plot(areas)
```


    
<img src="/assets/images/R/BayesianStatistics_output_4_0.png" width="200">  
    


```R
# distribuzione di probabilità
df <- data.frame(Region = 1:5, areas,
                Probability = areas / sum(areas))
df
```


<table>
<caption>A data.frame: 5 × 3</caption>
<thead>
	<tr><th scope=col>Region</th><th scope=col>areas</th><th scope=col>Probability</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>0.250</td></tr>
	<tr><td>2</td><td>1</td><td>0.125</td></tr>
	<tr><td>3</td><td>2</td><td>0.250</td></tr>
	<tr><td>4</td><td>1</td><td>0.125</td></tr>
	<tr><td>5</td><td>2</td><td>0.250</td></tr>
</tbody>
</table>



### Stima classica

$$P(\mbox{dispari})=0.25+0.25+0.25=0.75$$


```R
df %>% filter(Region %in% c(1,3,5))
```


<table>
<caption>A data.frame: 3 × 3</caption>
<thead>
	<tr><th scope=col>Region</th><th scope=col>areas</th><th scope=col>Probability</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2</td><td>0.25</td></tr>
	<tr><td>3</td><td>2</td><td>0.25</td></tr>
	<tr><td>5</td><td>2</td><td>0.25</td></tr>
</tbody>
</table>



$$P(\mbox{Maggiore di 3})=0.125+0.25=0.375$$


```R
df %>% filter(Region > 3)
```


<table>
<caption>A data.frame: 2 × 3</caption>
<thead>
	<tr><th scope=col>Region</th><th scope=col>areas</th><th scope=col>Probability</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>4</td><td>1</td><td>0.125</td></tr>
	<tr><td>5</td><td>2</td><td>0.250</td></tr>
</tbody>
</table>



### Stima con simulazione


```R
# genero un campione casuale di 10 osservazioni delle 5 regioni con le rispettive probabilità di estrazione
ten_spins <- spinner_data(areas, 10)
ten_spins
```


1 5 5 5 2 1 1 3 3 4



```R
# genero un campione casuale di 10000 osservazioni delle 5 regioni con le rispettive probabilità di estrazione
many_spins <- spinner_data(areas, 10000)
bar_plot(many_spins)
```


    
<img src="/assets/images/R/BayesianStatistics_output_13_0.png" width="400">  
    



```R
# distribuzione di frequenza
S <- data.frame(Region = many_spins) %>%
    group_by(Region) %>%
    summarise(N=n(), .groups = 'drop_last')
S
```


<table>
<caption>A tibble: 5 × 2</caption>
<thead>
	<tr><th scope=col>Region</th><th scope=col>N</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th></tr>
</thead>
<tbody>
	<tr><td>1</td><td>2499</td></tr>
	<tr><td>2</td><td>1238</td></tr>
	<tr><td>3</td><td>2512</td></tr>
	<tr><td>4</td><td>1224</td></tr>
	<tr><td>5</td><td>2527</td></tr>
</tbody>
</table>



$$P(\mbox{Region}=1)$$


```R
S %>% filter(Region==1) %>% sum() / 1000
```


2.5


## Bayes' rule
Si hanno 4 spinner, ciascuno diviso in 3 colori (_Rosso_, _Verde_ e _Blu_).  
Obiettivo: se so che è uscito _Rosso_, quale spinner mi aspetto sia stato utilizzato?


```R
bayes_df <- data.frame(Model = paste("Spinner", c("A", "B", "C", "D")))
bayes_df
```


<table>
<caption>A data.frame: 4 × 1</caption>
<thead>
	<tr><th scope=col>Model</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Spinner A</td></tr>
	<tr><td>Spinner B</td></tr>
	<tr><td>Spinner C</td></tr>
	<tr><td>Spinner D</td></tr>
</tbody>
</table>



### Distribuzione a priori
Non sapendo se alcuni di questi spinner vengono scelti più o meno facilmente, assegno equiprobabilità per la scelta dello spinner.


```R
# distribuzione a priori
bayes_df$Prior <- rep(0.25, 4)
bayes_df
```


<table>
<caption>A data.frame: 4 × 2</caption>
<thead>
	<tr><th scope=col>Model</th><th scope=col>Prior</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Spinner A</td><td>0.25</td></tr>
	<tr><td>Spinner B</td><td>0.25</td></tr>
	<tr><td>Spinner C</td><td>0.25</td></tr>
	<tr><td>Spinner D</td><td>0.25</td></tr>
</tbody>
</table>


<img src="/assets/images/R/BayesianStatistics_Prior.png" width="400">  
### Verosimiglianza
Conosciamo la probabilità di estrazione del colore _Rosso_ per ciascun spinner


```R
# probabilità di ottenere rosso
bayes_df$Likelihood <- round(c(1/3, 1/2, 1/4, 1/6), 2)
bayes_df
```


<table>
<caption>A data.frame: 4 × 3</caption>
<thead>
	<tr><th scope=col>Model</th><th scope=col>Prior</th><th scope=col>Likelihood</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Spinner A</td><td>0.25</td><td>0.33</td></tr>
	<tr><td>Spinner B</td><td>0.25</td><td>0.50</td></tr>
	<tr><td>Spinner C</td><td>0.25</td><td>0.25</td></tr>
	<tr><td>Spinner D</td><td>0.25</td><td>0.17</td></tr>
</tbody>
</table>



### Distribuzione a posteriori
"Turn the Bayesian Crank" significa calcolare le probabilità a posteriori usando la regola di Bayes


```R
# ne fa il prodotto e normalizza rispetto la somma
bayes_df <- bayesian_crank(bayes_df)
bayes_df
```


<table>
<caption>A data.frame: 4 × 5</caption>
<thead>
	<tr><th scope=col>Model</th><th scope=col>Prior</th><th scope=col>Likelihood</th><th scope=col>Product</th><th scope=col>Posterior</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Spinner A</td><td>0.25</td><td>0.33</td><td>0.0825</td><td>0.264</td></tr>
	<tr><td>Spinner B</td><td>0.25</td><td>0.50</td><td>0.1250</td><td>0.400</td></tr>
	<tr><td>Spinner C</td><td>0.25</td><td>0.25</td><td>0.0625</td><td>0.200</td></tr>
	<tr><td>Spinner D</td><td>0.25</td><td>0.17</td><td>0.0425</td><td>0.136</td></tr>
</tbody>
</table>


<img src="/assets/images/R/BayesianStatistics_Posterior.png" width="400">  
Quindi, mi aspetto che lo spinner $$B$$ sia stato quello utilizzato (in quanto l'a priori, aggiornata con la verosimiglianza, cioè l'a posteriori, fa emergere che lo spinner $$B$$ sia il più probabile).


```R
# confronto distribuzioni
prior_post_plot(bayes_df)
```


    
<img src="/assets/images/R/BayesianStatistics_output_28_0.png" width="400">  
    


### Sequential Bayes

Se si continua, l'a posteriori sarà la nuova distribuzione a priori.  
Cosa accade se ora se si estrae il blu?


```R
# nuova priori
bayes_df2 <- bayes_df %>% select(Model, Posterior) %>% rename(Prior=Posterior)
bayes_df2
```


<table>
<caption>A data.frame: 4 × 2</caption>
<thead>
	<tr><th scope=col>Model</th><th scope=col>Prior</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Spinner A</td><td>0.264</td></tr>
	<tr><td>Spinner B</td><td>0.400</td></tr>
	<tr><td>Spinner C</td><td>0.200</td></tr>
	<tr><td>Spinner D</td><td>0.136</td></tr>
</tbody>
</table>




```R
# verosimiglianza del blu
bayes_df2$Likelihood <- round(c(1/3, 1/4, 1/2, 2/3), 2)
bayes_df2
```


<table>
<caption>A data.frame: 4 × 3</caption>
<thead>
	<tr><th scope=col>Model</th><th scope=col>Prior</th><th scope=col>Likelihood</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Spinner A</td><td>0.264</td><td>0.33</td></tr>
	<tr><td>Spinner B</td><td>0.400</td><td>0.25</td></tr>
	<tr><td>Spinner C</td><td>0.200</td><td>0.50</td></tr>
	<tr><td>Spinner D</td><td>0.136</td><td>0.67</td></tr>
</tbody>
</table>




```R
# posteriori: bayesian crank
bayes_df2 <- bayesian_crank(bayes_df2)
bayes_df2
```


<table>
<caption>A data.frame: 4 × 5</caption>
<thead>
	<tr><th scope=col>Model</th><th scope=col>Prior</th><th scope=col>Likelihood</th><th scope=col>Product</th><th scope=col>Posterior</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Spinner A</td><td>0.264</td><td>0.33</td><td>0.08712</td><td>0.2303299</td></tr>
	<tr><td>Spinner B</td><td>0.400</td><td>0.25</td><td>0.10000</td><td>0.2643824</td></tr>
	<tr><td>Spinner C</td><td>0.200</td><td>0.50</td><td>0.10000</td><td>0.2643824</td></tr>
	<tr><td>Spinner D</td><td>0.136</td><td>0.67</td><td>0.09112</td><td>0.2409052</td></tr>
</tbody>
</table>



Ora lo spinner che più probabilmente è stato usato non è solo il $$B$$ ma anche il $$C$$


```R
# confronto distribuzioni
prior_post_plot(bayes_df2)
```


    
<img src="/assets/images/R/BayesianStatistics_output_35_0.png" width="400">  
    



```R
# clear environment
rm(list=ls())
```

## Distribuzione a priori discreta

### Distribuzione a priori (proporzione)
Sia $$p$$ la proporzione di individui positivi  
$$p \in \left\{0.3,0.4,...,0.8\right\}$$  
La nostra sensibilità e/o conoscenza di dominio ci porta ad affermare che $$0.5$$ (stessa numerosità di positivi e negativi) e $$0.6$$ sono le proporzioni più plausibili per questo studio, due volte più probabili rispetto gli altri.


```R
bayes_df <- data.frame(P = seq(0.3,0.8,by=0.1),
                      Weight = c(1,1,2,2,1,1),
                      Prior = c(1,1,2,2,1,1)/8)
bayes_df
```


<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th scope=col>P</th><th scope=col>Weight</th><th scope=col>Prior</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>0.3</td><td>1</td><td>0.125</td></tr>
	<tr><td>0.4</td><td>1</td><td>0.125</td></tr>
	<tr><td>0.5</td><td>2</td><td>0.250</td></tr>
	<tr><td>0.6</td><td>2</td><td>0.250</td></tr>
	<tr><td>0.7</td><td>1</td><td>0.125</td></tr>
	<tr><td>0.8</td><td>1</td><td>0.125</td></tr>
</tbody>
</table>



### Verosimiglianza (Binomiale)
A seguito della raccolta empirica dei dati da un campione, si ottengono 12 positivi su 20.  
L'esperimento è binomiale: la probabilità di 12 successi su 20, con probabilità di successo $$p$$  
$$L={20\choose 12}p^{12}(1-p)^{8}$$


```R
# verosimiglianza
bayes_df <- bayes_df %>% 
    mutate(Likelihood = round(dbinom(12, size=20, prob=bayes_df$P),3)) %>%
    select(P, Prior, Likelihood)
bayes_df
```


<table>
<caption>A data.frame: 6 × 3</caption>
<thead>
	<tr><th scope=col>P</th><th scope=col>Prior</th><th scope=col>Likelihood</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>0.3</td><td>0.125</td><td>0.004</td></tr>
	<tr><td>0.4</td><td>0.125</td><td>0.035</td></tr>
	<tr><td>0.5</td><td>0.250</td><td>0.120</td></tr>
	<tr><td>0.6</td><td>0.250</td><td>0.180</td></tr>
	<tr><td>0.7</td><td>0.125</td><td>0.114</td></tr>
	<tr><td>0.8</td><td>0.125</td><td>0.022</td></tr>
</tbody>
</table>



### Distribuzione a posteriori


```R
# crank!
bayes_df <- bayesian_crank(bayes_df)
bayes_df
```


<table>
<caption>A data.frame: 6 × 5</caption>
<thead>
	<tr><th scope=col>P</th><th scope=col>Prior</th><th scope=col>Likelihood</th><th scope=col>Product</th><th scope=col>Posterior</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>0.3</td><td>0.125</td><td>0.004</td><td>0.000500</td><td>0.00516129</td></tr>
	<tr><td>0.4</td><td>0.125</td><td>0.035</td><td>0.004375</td><td>0.04516129</td></tr>
	<tr><td>0.5</td><td>0.250</td><td>0.120</td><td>0.030000</td><td>0.30967742</td></tr>
	<tr><td>0.6</td><td>0.250</td><td>0.180</td><td>0.045000</td><td>0.46451613</td></tr>
	<tr><td>0.7</td><td>0.125</td><td>0.114</td><td>0.014250</td><td>0.14709677</td></tr>
	<tr><td>0.8</td><td>0.125</td><td>0.022</td><td>0.002750</td><td>0.02838710</td></tr>
</tbody>
</table>




```R
# confronto
prior_post_plot(bayes_df)
```


    
<img src="/assets/images/R/BayesianStatistics_output_44_0.png" width="400">  
    


### Inferenza Bayesiana
$$P(p>0.5)=?$$


```R
bayes_df %>% select(P, Posterior)
```


<table>
<caption>A data.frame: 6 × 2</caption>
<thead>
	<tr><th scope=col>P</th><th scope=col>Posterior</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>0.3</td><td>0.00516129</td></tr>
	<tr><td>0.4</td><td>0.04516129</td></tr>
	<tr><td>0.5</td><td>0.30967742</td></tr>
	<tr><td>0.6</td><td>0.46451613</td></tr>
	<tr><td>0.7</td><td>0.14709677</td></tr>
	<tr><td>0.8</td><td>0.02838710</td></tr>
</tbody>
</table>




```R
bayes_df %>% filter(P>0.5) %>% select(Posterior) %>% sum()
```


0.64


## Distribuzione a priori continua

### Distribuzione a priori (Beta)
$$p^{a-1}(1-p)^{b-1}$$ con $$p \in \Re | 0< p< 1$$  
Rappresenta la conoscenza a priori su $$p$$  
Non è semplice identificare i parametri $$a$$ e $$b$$.  
Per un semplice esempio, ipotizzo $$a=7$$ e $$b=10$$


```R
# probabilità che il parametro p sia tra 0.8 e 0.4
pbeta(0.8, 7, 10) - pbeta(0.4, 7, 10)
```


0.526926535983103



```R
beta_area(0.4, 0.8, c(7, 10))
```


    
<img src="/assets/images/R/BayesianStatistics_output_51_0.png" width="400">  
    



```R
# il valore mediano risulta
qbeta(0.5, 7, 10)
```


0.408226501324901



```R
beta_quantile(0.5, c(7, 10))
```


    
<img src="/assets/images/R/BayesianStatistics_output_53_0.png" width="400">  
    


Posso determinare una stima dei parametri a priori $$a$$ e $$b$$, ipotizzando due valori plausibili per il 50-esimo e 90-esimo percentile.  
**[TO DO] AGGIUNGERE FORMULA PER OTTENERE I PARAMETRI DAI QUANTILI IPOTIZZATI**  
In base alla propria sensibilità e/o conoscenza di dominio, ipotizzo i due suddetti valori, tenendo presente che, ad esempio, un valore del 90-esimo percentile pari a 0.80, indica che sono sicuro all'90% che $$p$$ sia più piccolo di 0.8.


```R
# specifico i quantili 0.5 e 0.9
p50 <- list(x=0.55, p=0.5)
p90 <- list(x=0.80, p=0.9)

# trovo la corrispondente curva beta
parametri_priori <- beta.select(p50, p90)
parametri_priori # rispettivamente a e b
```


3.06; 2.56



```R
# plot beta a priori
beta_draw(parametri_priori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_56_0.png" width="400">  
    



```R
# calcolo l'intervallo di probabilità 50%
beta_interval(0.5, parametri_priori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_57_0.png" width="400">  
    



```R
# calcolo la probabilità che p sia minore di 0.4
beta_area(0, 0.4, parametri_priori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_58_0.png" width="400">  
    


### Verosimiglianza (Binomiale)
A seguito della raccolta empirica dei dati da un campione, si ottengono 12 positivi su 20.  
L'esperimento è binomiale: la probabilità di 12 successi su 20, con probabilità di successo $$p$$  
$$L={20\choose 12}p^{12}(1-p)^{8}$$

### Distribuzione a posteriori (Beta)
$$\mbox{Posteriori}\propto \mbox{Prori} \times \mbox{Verosimiglianza}$$  
$$\mbox{Posteriori}\propto [p^{3.06}(1-p)^{2.56-1}]\times [p^{12}(1-p)^8]=p^{15.06-1}(1-p)^{10.56-1}\equiv \mbox{Densità }\mathrm{B}(15.06,10.56)$$  
Quindi si ha
$$\bigg\{\mbox{Priori}=\mathrm{B}\big(a,b\big)\bigg\}\times \bigg\{\mbox{Verosimiglianza}=\mathrm{Bin}\Big(p=\frac{s}{s+f}\Big)\bigg\}=\bigg\{\mbox{Posteriori}=\mathrm{B}\big(a+s,b+f\big)\bigg\}$$


```R
data <- c(12,8)
parametri_posteriori <- parametri_priori + data
parametri_posteriori
```


15.06; 10.56



```R
# confronto priori e posteriori
beta_prior_post(parametri_priori, parametri_posteriori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_62_0.png" width="400">  
    


### Inferenza Bayesiana
#### Test d'ipotesi
Valutiamo l'ipotesi che l'80% è positivo
$$H:P>0.80$$


```R
1 - pbeta(0.8, parametri_posteriori[1], parametri_posteriori[2])
```


0.00818530232747894



```R
beta_area(0.8, 1, parametri_posteriori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_65_0.png" width="400">  
    


#### Intervalli di credibilità
Un intervallo di credibilità al 90%, è un intervallo che contiene al 90% la probabilità di contenere il parametro.


```R
# intervallo equi-tails
beta_interval(0.90, parametri_posteriori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_67_0.png" width="400">  
    


La probabilità che $$p$$ sia nell'intervallo $$(0.427,0.741)$$ è esattamente 0.9.  
#### Intervalli di confidenza
Nell'approccio classico (frequentista), l'intervallo di confidenza è basato sulla condizione degli esperimenti ripetuti.  
Secondo il metodo "aggiungi 2 successi e 2 insuccessi" di Agresti e Coull, dati $$y$$ successi e un campione di dimensione $$n$$, l'intervallo 90% è:  
$$(\hat{p}-1.645se,\hat{p}+1.645se)$$  
con  
$$\hat{p}=\frac{y+2}{n+4}$$ e $$se=\sqrt{\frac{\hat{p}(1-\hat{p})}{n+4}}$$


```R
classical_binom_ci(12, 20, 0.90)
```


0.417804211107709; 0.748862455558958


L'intervallo bayesiano è più stretto dell'intervallo di confidenza, è prevedibile in quanto è più preciso perché combina i dati con l'informazione a priori.

#### Simulazioni dalla a-posteriori


```R
# genero 1000 osservazioni dalla densità beta con i parametri precedenti
sim_p <- rbeta(1000, parametri_posteriori[1], parametri_posteriori[2])
```


```R
# valuto la loro distribuzione
hist(sim_p, freq=FALSE)
curve(dbeta(x, parametri_posteriori[1], parametri_posteriori[2]), add=TRUE, col="red", lwd=3)
```


    
<img src="/assets/images/R/BayesianStatistics_output_73_0.png" width="400">  
    



```R
# probabilità che p < 0.5 usando la simulazione
prob <- sum(sim_p < 0.5)/1000
prob
```


0.192



```R
# probabilità esatta
pbeta(0.5, parametri_posteriori[1], parametri_posteriori[2])
```


0.182415035367533



```R
# quantili campionari
quantile(sim_p, c(0.05, 0.95))
```


5%: 0.425741818823082; 95%: 0.737247520104539


#### Posterior of log odds ratio
Vogliamo ottenere l'intervallo al 90% di probabilità per $$\log{\frac{p}{1-p}}$$


```R
sim_logit <- log(sim_p / (1-sim_p))
```


```R
# distribuzione
hist(sim_logit, freq=FALSE)
```


    
<img src="/assets/images/R/BayesianStatistics_output_79_0.png" width="400">  
    



```R
# quantili campionari
quantile(sim_logit, c(0.10, 0.90))
```


10%:-0.15169200371894; 90%:0.86935740076806



```R
# clear environment
rm(list=ls())
```

## Normal sampling model ($$\sigma$$ noto)
### Distribuzione a priori (Uniforme Discreta)
Sia $$M$$ una v.a. che modella i secondi necessari per calciare un rigore.  
Ipotizzo un range tra 15 e 22 secondi, distribuito uniformemente (discreto).  
$$M\sim\mathrm{U}[15,22]$$


```R
bayes_df <- data.frame(M=15:22,Prior=rep(1/8,8))
prob_plot(bayes_df) + ylim(0,0.25)
```


    
<img src="/assets/images/R/BayesianStatistics_output_83_0.png" width="400">  
    


### Verosimiglianza (Normale)


```R
# verosimiglianze "plausibili"
Models <- list(c(15,4), c(16,4), c(17,4), c(18,4), 
              c(19,4), c(20,4), c(21,4), c(22,4))
many_normal_plots(Models)
```


    
<img src="/assets/images/R/BayesianStatistics_output_85_0.png" width="400">  
    


Si registrano 20 tiri in porta e si osserva che  
il valore medio $$\hat{y}=17.2$$  
lo standard error associato $$se=\frac{S}{\sqrt{n}}=\frac{4}{\sqrt{20}}=0.89$$


```R
# collect data
ymean <- 17.2
se <- 4/sqrt(20)
bayes_df$Likelihood <- dnorm(ymean, mean=bayes_df$M, sd=se)
round(bayes_df, 3)
```


<table>
<caption>A data.frame: 8 × 3</caption>
<thead>
	<tr><th scope=col>M</th><th scope=col>Prior</th><th scope=col>Likelihood</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>15</td><td>0.125</td><td>0.022</td></tr>
	<tr><td>16</td><td>0.125</td><td>0.181</td></tr>
	<tr><td>17</td><td>0.125</td><td>0.435</td></tr>
	<tr><td>18</td><td>0.125</td><td>0.299</td></tr>
	<tr><td>19</td><td>0.125</td><td>0.059</td></tr>
	<tr><td>20</td><td>0.125</td><td>0.003</td></tr>
	<tr><td>21</td><td>0.125</td><td>0.000</td></tr>
	<tr><td>22</td><td>0.125</td><td>0.000</td></tr>
</tbody>
</table>



### Distribuzione a posteriori (Normale)


```R
# calcolo posteriori
bayes_df <- bayesian_crank(bayes_df)
round(bayes_df,3)
```


<table>
<caption>A data.frame: 8 × 5</caption>
<thead>
	<tr><th scope=col>M</th><th scope=col>Prior</th><th scope=col>Likelihood</th><th scope=col>Product</th><th scope=col>Posterior</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>15</td><td>0.125</td><td>0.022</td><td>0.003</td><td>0.022</td></tr>
	<tr><td>16</td><td>0.125</td><td>0.181</td><td>0.023</td><td>0.181</td></tr>
	<tr><td>17</td><td>0.125</td><td>0.435</td><td>0.054</td><td>0.435</td></tr>
	<tr><td>18</td><td>0.125</td><td>0.299</td><td>0.037</td><td>0.299</td></tr>
	<tr><td>19</td><td>0.125</td><td>0.059</td><td>0.007</td><td>0.059</td></tr>
	<tr><td>20</td><td>0.125</td><td>0.003</td><td>0.000</td><td>0.003</td></tr>
	<tr><td>21</td><td>0.125</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
	<tr><td>22</td><td>0.125</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
</tbody>
</table>




```R
# priori vs posteriori
prior_post_plot(bayes_df)
```


    
<img src="/assets/images/R/BayesianStatistics_output_90_0.png" width="400">  
    



```R
# quali range di valori ha almeno il 90% di probabilità
bayes_df %>% 
  arrange(desc(Posterior)) %>% 
  select(M, Posterior) %>% 
  head(3) %>%
  mutate(
    Posterior = round(Posterior,3),
    M = as.character(M)
  ) %>%
  as.data.frame() %>%
  # bind_rows(data.frame(M="Totale",Posterior=sum(.[,"Posterior"])))
  bind_rows(summarise_all(., ~ if (is.numeric(.)) sum(.) else "Totale"))
```


<table>
<caption>A data.frame: 4 × 2</caption>
<thead>
	<tr><th scope=col>M</th><th scope=col>Posterior</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>17    </td><td>0.435</td></tr>
	<tr><td>18    </td><td>0.299</td></tr>
	<tr><td>16    </td><td>0.181</td></tr>
	<tr><td>Totale</td><td>0.915</td></tr>
</tbody>
</table>



### Distribuzione a priori (Normale)
Assumiamo ora che la distribuzione a priori sia continua e segua una normale.  
$$\mathscr{N}(M_0,S_0)$$  
Con $$M_0$$ rappresenta la migliore ipotesi di $$M$$ e $$S_0$$ indica quanto sono sicuro della ipotesi.  

Un esperto suggerisce che $$M$$ sia vicino a 18 secondi, e si avrà un valore piccolo per $$S_0$$ (es $$0.1$$).  
Un inesperto pensa che $$M$$ sia vicino a 18 secondi, ma si avrà un valore elevato per $$S_0$$ (es $$7$$).

Posso determinare una stima dei parametri a priori $$M_0$$ e $$S_0$$, ipotizzando due valori plausibili per il 50-esimo e 90-esimo percentile.  
**[TO DO] AGGIUNGERE FORMULA PER OTTENERE I PARAMETRI DAI QUANTILI IPOTIZZATI**  
Il quantile è un valore di $$M$$ che indica la possibilità di essere inferiore di quel valore con una data probabilità.  

In base alla propria sensibilità e/o conoscenza di dominio, ipotizzo i due suddetti valori
- $$0.50$$ quantile per M è $$18$$ secondi (significa che è ugualmente probabile che un valore sia più alto o più basso di $$18$$ secondi)  
- $$0.90$$ quantile per M è $$20$$ secondi (significa che la probabilità di ottenere un valore inferiore a $$20$$ è del 90%)  


```R
# stima parametri dall'assegnazione di due quantili
parametri_priori <- lapply(normal.select(list(x=18, p=0.5),
              list(x=20, p=0.9)), function(x) round(x, 2))
parametri_priori
```


<dl>
	<dt>$mu</dt>
		<dd>18</dd>
	<dt>$sigma</dt>
		<dd>1.56</dd>
</dl>




```R
# distribuzione a priori
normal_draw(parametri_priori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_94_0.png" width="400">  
    



```R
# trovo il quantile 0.25 della priori
qnorm(0.25, parametri_priori$mu, parametri_priori$sigma)
```


16.9477959896941



```R
normal_quantile(0.25, parametri_priori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_96_0.png" width="400">  
    


è ragionevole che $$P(M<16.95)=0.25$$? Se no, si perfezionano $$M_0$$ e $$S_0$$


```R
# assegno distribuzione a priori
bayes_df <- data.frame(M=15:22)
bayes_df <- bayes_df %>%
    mutate(Prior=round(dnorm(M, mean=parametri_priori$mu, sd=parametri_priori$sigma),3))
bayes_df
```


<table>
<caption>A data.frame: 8 × 2</caption>
<thead>
	<tr><th scope=col>M</th><th scope=col>Prior</th></tr>
	<tr><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>15</td><td>0.040</td></tr>
	<tr><td>16</td><td>0.112</td></tr>
	<tr><td>17</td><td>0.208</td></tr>
	<tr><td>18</td><td>0.256</td></tr>
	<tr><td>19</td><td>0.208</td></tr>
	<tr><td>20</td><td>0.112</td></tr>
	<tr><td>21</td><td>0.040</td></tr>
	<tr><td>22</td><td>0.010</td></tr>
</tbody>
</table>



### Verosimiglianza (Normale)
Si registrano 20 tiri in porta e si osserva che  
il valore medio $$\hat{y}=17.2$$  
lo standard error associato $$se=\frac{S}{\sqrt{n}}=\frac{4}{\sqrt{20}}=0.89$$


```R
# verosimiglianza
parametri_verosimiglianza <- list(mu=17.2, sigma=0.89)
bayes_df <- bayes_df %>%
    mutate(Likelihood=dnorm(parametri_verosimiglianza$mu, mean=M, sd=parametri_verosimiglianza$sigma))
round(bayes_df,3)
```


<table>
<caption>A data.frame: 8 × 3</caption>
<thead>
	<tr><th scope=col>M</th><th scope=col>Prior</th><th scope=col>Likelihood</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>15</td><td>0.040</td><td>0.021</td></tr>
	<tr><td>16</td><td>0.112</td><td>0.181</td></tr>
	<tr><td>17</td><td>0.208</td><td>0.437</td></tr>
	<tr><td>18</td><td>0.256</td><td>0.299</td></tr>
	<tr><td>19</td><td>0.208</td><td>0.058</td></tr>
	<tr><td>20</td><td>0.112</td><td>0.003</td></tr>
	<tr><td>21</td><td>0.040</td><td>0.000</td></tr>
	<tr><td>22</td><td>0.010</td><td>0.000</td></tr>
</tbody>
</table>



### Distribuzione a posteriori (Normale)
$$\mbox{Posteriori}\propto \mbox{Prori} \times \mbox{Verosimiglianza}$$  
Quindi si ha
$$\bigg\{\mbox{Priori}=\mathscr{N}\big(M_0,S_0\big)\bigg\}\times \bigg\{\mbox{Verosimiglianza}=\mathscr{N}\big(M_1,S_1\big)\bigg\}=\bigg\{\mbox{Posteriori}=\mathscr{N}\big(M_{Post},S_{Post}\big)\bigg\}$$  
con  
$$P_k=\frac{1}{S_k^2}$$  
$$M_{Post}=\mbox{W.AVG}(M;P)$$  
$$S_{Post}=\frac{1}{\sqrt{\sum S}}$$


```R
# aggiungo la precision ai parametri a priori
parametri_priori <- append(parametri_priori, list(precision=round(1/parametri_priori$sigma^2,2)))
parametri_priori
```


<dl>
	<dt>$mu</dt>
		<dd>18</dd>
	<dt>$sigma</dt>
		<dd>1.56</dd>
	<dt>$precision</dt>
		<dd>0.41</dd>
</dl>




```R
# parametri verosimiglianza, con la sua precision
parametri_verosimiglianza <- append(parametri_verosimiglianza, list(precision=round(1/parametri_verosimiglianza$sigma^2,2)))
parametri_verosimiglianza
```


<dl>
	<dt>$mu</dt>
		<dd>17.2</dd>
	<dt>$sigma</dt>
		<dd>0.89</dd>
	<dt>$precision</dt>
		<dd>1.26</dd>
</dl>




```R
# parametri posteriori, con la sua precision
parametri_posteriori <- list(
  mu = round(weighted.mean(x=c(parametri_priori$mu, 
                       parametri_verosimiglianza$mu), 
                   w=c(parametri_priori$precision, 
                       parametri_verosimiglianza$precision)),2),
  sigma = round(1/sqrt(sum(c(parametri_priori$precision, 
                       parametri_verosimiglianza$precision))),2),
  precision = sum(c(parametri_priori$precision, 
                    parametri_verosimiglianza$precision)))
parametri_posteriori
```


<dl>
	<dt>$mu</dt>
		<dd>17.4</dd>
	<dt>$sigma</dt>
		<dd>0.77</dd>
	<dt>$precision</dt>
		<dd>1.67</dd>
</dl>




```R
# dati insieme
rbind(
  data.frame(fonte="parametri_priori",parametri_priori),
  data.frame(fonte="parametri_verosimiglianza",parametri_verosimiglianza), 
  data.frame(fonte="parametri_posteriori",parametri_posteriori)
  )
```


<table>
<caption>A data.frame: 3 × 4</caption>
<thead>
	<tr><th scope=col>fonte</th><th scope=col>mu</th><th scope=col>sigma</th><th scope=col>precision</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>parametri_priori         </td><td>18.0</td><td>1.56</td><td>0.41</td></tr>
	<tr><td>parametri_verosimiglianza</td><td>17.2</td><td>0.89</td><td>1.26</td></tr>
	<tr><td>parametri_posteriori     </td><td>17.4</td><td>0.77</td><td>1.67</td></tr>
</tbody>
</table>




```R
# funzione automatica calcolo posteriori normale
normal_update(as.numeric(parametri_priori[1:2]), 
              as.numeric(parametri_verosimiglianza[1:2]))
```


17.3964472827603; 0.773041159419683



```R
# funzione automatica (estesa) calcolo posteriori normale
normal_update(as.numeric(parametri_priori[1:2]), 
              as.numeric(parametri_verosimiglianza[1:2]), 
             teach=TRUE)
```


<table>
<caption>A data.frame: 3 × 4</caption>
<thead>
	<tr><th scope=col>Type</th><th scope=col>Mean</th><th scope=col>Precision</th><th scope=col>Stand_Dev</th></tr>
	<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>Prior    </td><td>18.00000</td><td>0.4109139</td><td>1.5600000</td></tr>
	<tr><td>Data     </td><td>17.20000</td><td>1.2624669</td><td>0.8900000</td></tr>
	<tr><td>Posterior</td><td>17.39645</td><td>1.6733807</td><td>0.7730412</td></tr>
</tbody>
</table>




```R
# confronto grafico tra priori e posteriori
many_normal_plots(list(as.numeric(parametri_priori[1:2]),
                      as.numeric(parametri_posteriori[1:2])))
```


    
<img src="/assets/images/R/BayesianStatistics_output_108_0.png" width="400">  
    


### Inferenza Bayesiana
#### Test d'ipotesi
Valutiamo l'ipotesi che servano in media almeno 19 secondi per calciare  
$$H:M\ge 19$$

#### Approccio classico
Test statistics $$Z=\frac{\bar{y}-19}{se}$$


```R
# Z score
z <- (parametri_verosimiglianza$mu - 19)/parametri_verosimiglianza$sigma
z
```


-2.02247191011236



```R
# p-value del z-score
pnorm(z)
```


0.0215638113390887


Con l'approccio classico si ha un p-value del 2% e si riufiuta l'ipotesi nulla.

#### Approccio Bayesiano
L'attuale opinione è rappresentata dalla posteriori  
$$\mathscr{N}(17.4,0.77)$$


```R
# probabilità che M>=19
1 - pnorm(19, parametri_posteriori$mu, parametri_posteriori$sigma)
```


0.0188582683438657


Ottengo un risultato simile al p-value, e anche in questo caso si rifiuta l'ipotesi nulla, o meglio dire che l'affermazione ipotizzata è improbabile che sia vera.

#### Simulazioni dalla a-posteriori
Siamo interessati a conoscere il tempo medio (e un suo intervallo di credibilità)


```R
# distribuzione a posteriori
normal_draw(parametri_posteriori)
```


    
<img src="/assets/images/R/BayesianStatistics_output_116_0.png" width="400">  
    



```R
# simulation
M_sim <- rnorm(1000, mean=parametri_posteriori$mu, sd=parametri_posteriori$sigma)
```


```R
# intervallo di credibilità a 80%
# round(quantile(M_sim, c(0.10, 0.90)),1)
normal_interval(0.80, parametri_posteriori)
# la probabilità che M sia in questo intervallo è dell'80%
```


    
<img src="/assets/images/R/BayesianStatistics_output_118_0.png" width="400">  
    


#### Bayesian Predictions
Per prevedere il prossimo tempo $$y$$ serve determinare la _predictive density_ di $$y$$.  
Non conosciamo il vero valore di $$M$$ ma conosciamo la distribuzione a posteriori $$\mathscr{N}(17.4,0.77)$$  
Step  
1. si simula un valore $$M$$ da $$\mathscr{N}(17.4,0.77)$$
2. si simula un valore $$y$$ dalla densità $$\mathscr{N}(M,4)$$, in questo caso il valore $$4$$ è stato ipotizzato


```R
# simulazione dalla posteriori
M_sim <- rnorm(1000, mean=parametri_posteriori$mu, sd=parametri_posteriori$sigma)
```


```R
# simulazione dalla densità predittiva
y_sim <- rnorm(1000, mean=M_sim, sd=4)
```


```R
# intervallo di credibilità previsto all'80%
round(quantile(y_sim, c(0.10, 0.90)), 1)
```


10%:11.8; 90%:22.6


L'intervallo di credibilità all'80% è più stretto dell'intervallo di credibilità previsto, in quanto non si conosce il valore di $$M$$ (inference) né il valore di $$y\vert M$$ (sampling).

## Bivariate Bayesian Testing
### Inferenza Bayesiana
Siano $$p_W$$ e $$p_M$$ le proporzioni di donne e uomini positivi.  

#### Test d'ipotesi
- Ipotesi 1 $$p_W>p_M$$
- Ipotesi 2 $$p_W=p_M$$

#### Distribuzione a priori (proporzioni)
In un approccio discreto, un modello è una coppia $$(p_W,p_M)$$  
Ipotizzo una distribuzione discreta, con range tra $$0.1$$ e $$0.9$$ (quindi $$9\times 9$$ possibili modelli).  
La distribuzione è descrive la relazione tra le due proporzioni  
- $$P(p_W=p_M)=0.5$$ (diagonale)
- $$P(p_W\neq p_M)=0.5$$ (fuori la diagonale)


```R
# distribuzione test-priori
prior <- testing_prior(lo=0.1, hi=0.9, n_values=9, pequal=0.5)
round(prior, 3)
```


<table>
<caption>A matrix: 9 × 9 of type dbl</caption>
<thead>
	<tr><th></th><th scope=col>0.1</th><th scope=col>0.2</th><th scope=col>0.3</th><th scope=col>0.4</th><th scope=col>0.5</th><th scope=col>0.6</th><th scope=col>0.7</th><th scope=col>0.8</th><th scope=col>0.9</th></tr>
</thead>
<tbody>
	<tr><th scope=row>0.1</th><td>0.056</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td></tr>
	<tr><th scope=row>0.2</th><td>0.007</td><td>0.056</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td></tr>
	<tr><th scope=row>0.3</th><td>0.007</td><td>0.007</td><td>0.056</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td></tr>
	<tr><th scope=row>0.4</th><td>0.007</td><td>0.007</td><td>0.007</td><td>0.056</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td></tr>
	<tr><th scope=row>0.5</th><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.056</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td></tr>
	<tr><th scope=row>0.6</th><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.056</td><td>0.007</td><td>0.007</td><td>0.007</td></tr>
	<tr><th scope=row>0.7</th><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.056</td><td>0.007</td><td>0.007</td></tr>
	<tr><th scope=row>0.8</th><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.056</td><td>0.007</td></tr>
	<tr><th scope=row>0.9</th><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.007</td><td>0.056</td></tr>
</tbody>
</table>




```R
# plot della test-priori
draw_two_p(prior)
```


    
<img src="/assets/images/R/BayesianStatistics_output_126_0.png" width="400">  
    


#### Verosimiglianza (Binomiale)
Si osservano 10 donne e 14 uomini positivi.  
Si possono assumere campioni indipendenti e con distribuzione binomiale, quindi la verosimiglianza è il prodotto (vettoriale) delle densità binomiali


```R
pW <- seq(0.1,0.9,by=0.1)
pM <- seq(0.1,0.9,by=0.1)
# outer è il prodotto tra vettore riga e colonna (nx1 * 1xn = nxn)
# a %*% t(b)
Likelihood <- outer(dbinom(10, size=20, prob=pW), 
  dbinom(14, size=20, prob=pM))
round(Likelihood,3)
```


<table>
<caption>A matrix: 9 × 9 of type dbl</caption>
<tbody>
	<tr><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.001</td><td>0.004</td><td>0.006</td><td>0.003</td><td>0.000</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.001</td><td>0.004</td><td>0.015</td><td>0.022</td><td>0.013</td><td>0.001</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.001</td><td>0.007</td><td>0.022</td><td>0.034</td><td>0.019</td><td>0.002</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.001</td><td>0.004</td><td>0.015</td><td>0.022</td><td>0.013</td><td>0.001</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.001</td><td>0.004</td><td>0.006</td><td>0.003</td><td>0.000</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
	<tr><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
</tbody>
</table>



#### Distribuzione a posteriori (proporzioni)
$$\mbox{Posteriori}=\frac{\mbox{Prori} \times \mbox{Verosimiglianza}}{\sum\big(\mbox{Prori} \times \mbox{Verosimiglianza}\big)}$$


```R
# posterior <- prior*Likelihood/sum(prior*Likelihood)
posterior <- two_p_update(prior, c(10,10), c(14,6))
round(posterior,3)
```


<table>
<caption>A matrix: 9 × 9 of type dbl</caption>
<thead>
	<tr><th></th><th scope=col>0.1</th><th scope=col>0.2</th><th scope=col>0.3</th><th scope=col>0.4</th><th scope=col>0.5</th><th scope=col>0.6</th><th scope=col>0.7</th><th scope=col>0.8</th><th scope=col>0.9</th></tr>
</thead>
<tbody>
	<tr><th scope=row>0.1</th><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
	<tr><th scope=row>0.2</th><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.001</td><td>0.001</td><td>0.001</td><td>0.000</td></tr>
	<tr><th scope=row>0.3</th><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.003</td><td>0.009</td><td>0.014</td><td>0.008</td><td>0.001</td></tr>
	<tr><th scope=row>0.4</th><td>0</td><td>0</td><td>0</td><td>0.011</td><td>0.010</td><td>0.035</td><td>0.053</td><td>0.030</td><td>0.002</td></tr>
	<tr><th scope=row>0.5</th><td>0</td><td>0</td><td>0</td><td>0.002</td><td>0.124</td><td>0.052</td><td>0.080</td><td>0.046</td><td>0.004</td></tr>
	<tr><th scope=row>0.6</th><td>0</td><td>0</td><td>0</td><td>0.001</td><td>0.010</td><td>0.277</td><td>0.053</td><td>0.030</td><td>0.002</td></tr>
	<tr><th scope=row>0.7</th><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.003</td><td>0.009</td><td>0.112</td><td>0.008</td><td>0.001</td></tr>
	<tr><th scope=row>0.8</th><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.001</td><td>0.001</td><td>0.004</td><td>0.000</td></tr>
	<tr><th scope=row>0.9</th><td>0</td><td>0</td><td>0</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td><td>0.000</td></tr>
</tbody>
</table>




```R
# plot
draw_two_p(posterior)
```


    
<img src="/assets/images/R/BayesianStatistics_output_131_0.png" width="400">  
    


#### Analisi delle differenze
Trasformo la matrice $$9\times 9$$ in una matrice $$81\times 2$$, ottengo le differenze tra $$p_W$$ e $$p_M$$, raggruppo per tale differenza sommando le probabilità (le due colonne hanno 9 valori, quindi 17 combinazioni).  
Analizzo la distribuzione delle differenze tra le due proporzioni
$$d=p_M-p_W$$


```R
# differenze e probabilità

# tabella <- as.matrix(posterior)
# tabella <- data.frame(
#   diff21 = as.vector(outer(colnames(tabella), rownames(tabella), FUN=function(x,y) round(as.numeric(y)-as.numeric(x),1))),
#   Prob = as.vector(tabella)
# )

# d <- tabella %>%
#   group_by(diff21) %>%
#   summarise(Prob = sum(Prob), .groups = 'drop_last')

d <- two_p_summarize(posterior)
d %>% head() %>% round(3)
```


<table>
<caption>A tibble: 6 × 2</caption>
<thead>
	<tr><th scope=col>diff21</th><th scope=col>Prob</th></tr>
	<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>
</thead>
<tbody>
	<tr><td>-0.8</td><td>0.000</td></tr>
	<tr><td>-0.7</td><td>0.000</td></tr>
	<tr><td>-0.6</td><td>0.000</td></tr>
	<tr><td>-0.5</td><td>0.000</td></tr>
	<tr><td>-0.4</td><td>0.000</td></tr>
	<tr><td>-0.3</td><td>0.001</td></tr>
</tbody>
</table>




```R
# plot differenze
prob_plot(d)
```


    
<img src="/assets/images/R/BayesianStatistics_output_134_0.png" width="400">  
    


Con la distribuzione a priori ho assunto che si ha il 50% di probabilità di ottenere proporzioni uguali (differenza nulla).  
L'a posteriori mostra che la $$P(\mbox{d}=0)$$ è elevata, ma è discreta la probabilità che la proporzione degli uomini sia maggiore rispetto quella delle donne.


```R
# Posteriori: P(diff<0==p_W>p_M)
d %>% filter(diff21<0) %>% select(Prob) %>% sum() %>% round(3)
```


0.028



```R
# Priori: P(diff<0==p_W>p_M)
sum(prior[upper.tri(prior)])
```


0.25



```R
# Posteriori: P(diff=0==p_W=p_M)
d %>% filter(diff21==0) %>% select(Prob) %>% sum() %>% round(3)
```


0.528



```R
# Priori: P(diff=0==p_W=p_M)
sum(diag(prior))
```


0.5


#### Distribuzione a priori (Beta)
Assumiamo che una curva beta rappresenti la conoscenza riguardo $$p_W$$ e un'altra riguardo $$p_M$$ e che siano indipendenti.  
$$p_W \sim \mathrm{B}(1,1)$$  
$$p_M \sim \mathrm{B}(1,1)$$


```R
# genero dalla priori
df <- data.frame(pW=rbeta(1000,1,1), pM=rbeta(1000,1,1))
ggplot(df, aes(pW,pM)) + geom_point() + xlim(0,1) + ylim(0,1)
```


    
<img src="/assets/images/R/BayesianStatistics_output_141_0.png" width="400">  
    


#### Verosimiglianza (Binomiale)
Si osservano 10 donne e 14 uomini positivi.  
Si possono assumere campioni indipendenti e con distribuzione binomiale, quindi la verosimiglianza è il prodotto (vettoriale) delle densità binomiali

#### Distribuzione a posteriori (Beta)
Sarà una $$\mathrm{B}(p_W,p_M)$$

$$p_W \sim \mathrm{B}(10+1,10+1)$$  
$$p_M \sim \mathrm{B}(14+1,6+1)$$ 

...da fare verifiche


```R
# simulo pW e pM
pW <- rbeta(1000, 11, 11)
pM <- rbeta(1000, 15, 7)
```


```R
# plot posteriori
df <- data.frame(pW, pM)
ggplot(df, aes(pW,pM)) + geom_point() + xlim(0,1) + ylim(0,1)
```


    
<img src="/assets/images/R/BayesianStatistics_output_145_0.png" width="400">  
    



```R
# prob pW<pM
with(df, sum(pW<pM)/1000)
```


0.898



```R
# differenza posteriori
df$d_21 <- with(df, pM-pW)
```


```R
# plot differenze
ggplot(df, aes(d_21)) +
  geom_histogram(color="black", fill="red", bins=30)
```


    
<img src="/assets/images/R/BayesianStatistics_output_148_0.png" width="400">  
    



```R
# intervallo di credibilità per d
quantile(df$d_21, c(0.05, 0.95))
```


5%:-0.0468267513603719; 95%:0.410351553897697


$$P(-0.05<p_M-p_W<0.41)=0.9$$  
Dal momento che gli interavalli contengono lo zero, non c'è evidenza significativa per dire che le proporzioni sono differenti.


```R
# clear environment
rm(list=ls())
```

## Normal model inference ($$\sigma$$ sconosciuto)
Sia $$y$$ una v.a. che modella i secondi necessari per calciare un rigore.  
Prima abbiamo fatto inferenza su $$M$$ campionando un modello normale, assumendo una deviazione standard $$S$$, adesso entrambi parametri sono sconosciuti.

### Distribuzione a priori (non-informativa)
Sia $$M$$ che $$S$$ sono continue, usiamo una priori "non-informativa".  
$$g(M,S)=\frac{1}{S}$$

### Verosimiglianza


```R
# observed data
df <- data.frame(Player="One",
                Time_to_Serve = c(20.9, 17.8, 14.9, 12.0, 14.1,
                                 22.8, 14.6, 15.3, 21.2, 20.7,
                                 12.2, 16.2, 15.6, 19.4, 22.3,
                                 14.1, 18.1, 23.6, 11.0, 17.3))
```


```R
# verosimiglianza
# Likelihood <- prod(dnorm(Time_to_Serve, mean=M, sd=S))
```

**[TO DO] NON COMPRENDO L'UTILITÀ DELLA FORMULA PRECEDENTE**


```R
# prod(dnorm(df$Time_to_Serve, mean=mean(df$Time_to_Serve), sd=sd(df$Time_to_Serve))) # ha senso?
```


1.92001903740555e-24


### Distribuzione a posteriori (modello lineare)
$$Posteriori \propto Verosimiglianza \times \frac{1}{S}$$  
Simulo $$(M, S)$$ dalla posteriori a 2 parametri.

Questo modello normale si può vedere come un modello lineare con solo l'intercetta.  
**[TO DO] DA CAPIRE LA RELAZIONE**


```R
# lm intercetta
fit <- lm(Time_to_Serve~1, data=df)
summary(fit)
```


    
    Call:
    lm(formula = Time_to_Serve ~ 1, data = df)
    
    Residuals:
       Min     1Q Median     3Q    Max 
    -6.205 -2.730 -0.455  3.545  6.395 
    
    Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
    (Intercept)   17.205      0.851   20.22 2.62e-14 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    
    Residual standard error: 3.806 on 19 degrees of freedom
    


Similiamo da una a posteriori di $$(M,S)$$ usando una priori non informativa


```R
# simuliamo da questo modello bayesiano
sim_fit <- arm::sim(fit, n.sims=1000)
```


```R
# estraggo i vettori simulati di M e S
sim_M <- coef(sim_fit)
sim_S <- arm::sigma.hat(sim_fit)
```


```R
# distribuzione a posteriori congiunta di M e S
ggplot(data.frame(sim_M, sim_S), aes(sim_M, sim_S)) + geom_point()
```


    
<img src="/assets/images/R/BayesianStatistics_output_162_0.png" width="400">  
    



```R
# andamento deviazione standard
ggplot(data.frame(sim_S), aes(sim_S)) + geom_density()

# intervallo di crdeibilità al 90%
round(quantile(sim_S, c(0.05, 0.95)),3)
```


5%:3.093; 95%:5.313



    
<img src="/assets/images/R/BayesianStatistics_output_163_1.png" width="400">  
    


## Regressione Bayesiana
Sia $$y$$ la variabile dipendente che rappresenta i secondi necessari per calciare un rigore.  
Sia $$X$$ la variabile indipendente che definisce il giocatore che calcia (_Player One_ e _Player Two_).  
Obiettivo: quanto è più lento il player 2 rispetto l'1?

Regression framework
$$y\sim\mathscr{N}\big(\beta_0+\beta_1\cdot I(\mbox{Player}=\mbox{Two}),S\big)$$

### Distribuzione a priori (non-informativa)
$$(\beta_0,\beta_1,S)\sim\frac{1}{S}$$

### Verosimiglianza


```R
# observed data
One <- data.frame(Player="One",
                Time_to_Serve = c(20.9, 17.8, 14.9, 12.0, 14.1,
                                 22.8, 14.6, 15.3, 21.2, 20.7,
                                 12.2, 16.2, 15.6, 19.4, 22.3,
                                 14.1, 18.1, 23.6, 11.0, 17.3))
Two <- data.frame(Player="Two",
                Time_to_Serve = c(20.5, 25.1, 21.4, 25.6, 41.2,
                                 23.9, 22.6, 19.0, 29.7, 36.4,
                                 18.4, 20.3, 26.9, 28.9, 22.9,
                                 31.5, 39.6, 29.4, 26.9, 24.5))
df <- rbind(One, Two)
```


```R
# verosimiglianza
# Likelihood <- prod(dnorm(Time_to_Serve, mean=beta0+beta1*I(Player2), sd=S))
```

**[TO DO] NON COMPRENDO L'UTILITÀ DELLA FORMULA PRECEDENTE**

### Distribuzione a posteriori (modello lineare)
$$Posteriori\propto \mbox{Verosimiglianza}\times \frac{1}{S}$$

Questo modello normale si può vedere come un modello lineare.  
**[TO DO] DA CAPIRE LA RELAZIONE**


```R
# stima del modello
fit <- lm(Time_to_Serve ~ Player, data=df)
fit
```


    
    Call:
    lm(formula = Time_to_Serve ~ Player, data = df)
    
    Coefficients:
    (Intercept)    PlayerTwo  
          17.20         9.53  
    


In media il giocatore 1 impiega $$17.20$$ secondi, mentre il giocatore 2 impiega $$17.20+9.53$$ secondi.


```R
# generare dalla distribuzione a posteriori dei beta e sigma
sim_fit <- arm::sim(fit, n.sims=1000)
sim_beta <- coef(sim_fit)
sim_S <- arm::sigma.hat(sim_fit)
```


```R
# plot posteriori congiunta dei beta
sim_beta <- data.frame(sim_beta)
names(sim_beta)[1] <- "Intercetta"
ggplot(sim_beta, aes(Intercetta, PlayerTwo)) + geom_point() + 
  xlab(expression(beta[0])) + ylab(expression(beta[1])) + 
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5), axis.title=element_text(size=24))
```


    
<img src="/assets/images/R/BayesianStatistics_output_172_0.png" width="400">  
    



```R
# plot posteriori marginale di beta1
ggplot(sim_beta, aes(PlayerTwo)) + geom_density()
```


    
<img src="/assets/images/R/BayesianStatistics_output_173_0.png" width="400">  
    


Il confronto diretto delle due distribuzioni marginali non è sensato, perché viene influenzato dalla differente variabilità delle due stime, quindi, è necessario standardizzarlo.

#### Standardized effect
$$h(\beta_1,S)=\frac{\beta_1}{S}$$  
con $$\beta_1$$ parametro di regressione e $$S$$ deviazione standard.  
Effetto standardizzato: il tempo medio che il giocatore due è più lento del giocatore uno, misurato in unità di deviazioni standard.


```R
# plot posteriori marginale di beta1 standardizzato
posterior <- data.frame(sim_beta, sim_S)
standardized_effect <- with(posterior, PlayerTwo / sim_S)
ggplot(posterior, aes(standardized_effect)) + geom_density() + 
  xlab(expression(frac(beta[1],S)))
```


    
<img src="/assets/images/R/BayesianStatistics_output_175_0.png" width="400">  
    



```R
# intervallo di credibilità al 90% per l'effetto standardizzato
round(quantile(data.frame(sim_beta)$PlayerTwo / sim_S, c(0.05, 0.95)),3)

```


5%:1.151; 95%:2.423


La probabilità che l'effetto standardizzato di $$\beta_1$$ sia tra 1.2 e 2.4 è il 90%
