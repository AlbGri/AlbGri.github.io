---
title: "Python: Amazon Web Services and Spark"
excerpt: "Cloud Computing with Amazon"
date: 2020-08-03
tags: [python, utils, aws, spark]
mathjax: "true"
---

*Scritto ed eseguito sul portatile con Windows 10 -- Effetto South Workng*

# Hadoop and Spark
...

# Amazon Web Services

## Account
[Amazon AWS free account](https://aws.amazon.com/free/)  
1. è gratuito per 12 mesi
2. è gratuito se non si superano le 750 ore al mese
3. mi registro con [Revolut](https://revolut.com/referral/albert9u1r) (nota: Amazon si prenderà 1$ qualsiasi carta ci metti per validare la sicurezza)

Qualche dettaglio in più sull'[account](https://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/AboutAWSAccounts.html)

Next Steps
1. Accedo alla sezione Console del sito di AWS
1. Servizi → Calcolo → EC2 → Avvia istanza 
    * Ubuntu (Free tier eligible) 64-bit (x86) → Select
    * t2.micro (Free tier eligible) *Currently selected: t2.micro (Variable ECUs, 1 vCPUs, 2.5 GHz, Intel Xeon Family, 1 GiB memory, EBS only)*  
    * Next: Configure Instance Details → Number of instances 1
    * Next: Add Storage 
    * Next: Add Tags → Key: **myspark** → Value: **mymachine**
    * Next: Configure Security Group → Type: All traffic
    * Review and Launch → Launch
    * Create a new key pair → Key pair name: **newspark** → Download Key Pair → Launch Instances
    * *The following instance launches have been initiated:* clicca sul link
1. Per interrompere l'istanza: Actions → Instance State → Terminate

## Windows Setup
1. Tramite Windows necessito di PuTTY per connettermi via SSH, seguo la [guida](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html) di AWS per la configurazione. Preferisco scaricare il file di PuTTY unico che contiene tutte le utilities necessarie.
1. Della instance avviata servirà
    * Public DNS
    * Private key (scaricata con il file .pem)
1. Utility PuTTY Gen per convertire il .pem in formato leggibile per PuTTY
    * Parameters → Type of key to generate → RSA
    * Actions → Load an existing private key file → Load → tutti i file, cerca il newspark.pem
    * Save private key → Yes → nome: **puttyspark**
1. Start PuTTY
    * Session
        * Host Name: **ubuntu@*incollo_il_Public_DNS***
        * Port: 22
    * Connection → SSH → Auth → Browse... → puttyspark.ppk
    * Open
    * Yes

## Linux Setup
```console
~$ cd Downloads
~$ chmod 400 newspark.pem
~$ ssh -i newspark.pem ubuntu@incollo_il_Public_DNS
~$ yes
~$ clear
```

## PySpark Set-up
### Anaconda install
Verifico ultima versione su https://repo.anaconda.com/archive/ (es. Anaconda3-2020.07-Linux-x86_64.sh)
```console
~$ mkdir Downloads
~$ cd Downloads
~$ wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
~$ bash Anaconda3-2020.07-Linux-x86_64.sh
```

### Anaconda path
Imposto la variabile d'ambiente anaconda folder permanentemente
```console
~$ cd /home/ubuntu
~$ sudo nano ~/.bashrc
~$ echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc
~$ source ~/.bashrc
~$ echo $PATH
~$ python --version
```

### Jupyter Notebook
```console
~$ jupyter notebook --generate-config
~$ mkdir certs
~$ cd certs
~$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
~$ cd ~/.jupyter/
~$ sudo nano jupyter_notebook_config.py
    c = get_config()
    # Notebook config this is where you saved your pem cert
    c.NotebookApp.certfile = u'/home/ubuntu/certs/mycert.pem' # Run on all IP addresses of your instance
    c.NotebookApp.ip = '*'# Don't open browser by default
    c.NotebookApp.open_browser = False  # Fix port to 8888
    c.NotebookApp.port = 8888
~$ sudo chown $USER:$USER /home/ubuntu/certs/mycert.pem
~$ jupyter notebook
```
A questo punto si visita la pagina web **https://*incollo_il_Public_DNS*:8888**  
Se chiede la password o il token, quest'ultimo si può copiare dal terminale.   
Per terminarlo ctrl+c

### Java
```console
~$ cd
~$ sudo apt-get update
~$ sudo apt-get install default-jre
~$ java -version
```

### Scala
```console
~$ sudo apt-get install scala
~$ scala -version
```
In alternativa, per scaricare una versione più recente di scala, cerco la versione più recente https://www.scala-lang.org/files/archive/ (es. scala-2.12.12.deb)
```console
~$ wget https://www.scala-lang.org/files/archive/scala-2.12.12.deb
~$ sudo dpkg -i scala-2.12.12.deb
```

### py4j
```console
~$ pip install py4j
```

### Spark e Hadoop
Scarico la versione più recente (un po' rischioso perché forse Spark 3.0 è troppo recente), cerco la versione più recente http://archive.apache.org/dist/spark/ (es. spark-3.0.0 con hadoop3.2)
```console
~$ cd /home/ubuntu
~$ wget http://archive.apache.org/dist/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz
~$ sudo tar -zxvf spark-3.0.0-bin-hadoop3.2.tgz
```
Configuro i path per Spark e Hadoop
```console
~$ cd /home/ubuntu
~$ sudo nano ~/.bashrc
~$ echo 'export SPARK_HOME=/home/ubuntu/spark-3.0.0-bin-hadoop3.2' >> ~/.bashrc
~$ echo 'export PATH=$SPARK_HOME:$PATH' >> ~/.bashrc
~$ echo 'export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH' >> ~/.bashrc
~$ source ~/.bashrc
~$ echo $PATH
```

## AWS Spark Test
Con la macchina attiva attivo Jupyter via SSH
```console
~$ jupyter notebook
```
e vado nella pagina web **https://*incollo_il_Public_DNS*:8888**  

### Spark Coding (1/2)
Il codice che segue è stato eseguito sulla macchina EC2 Amazon
```python
# lib
from pyspark import SparkContext
# spark context
sc = SparkContext()
sc
```
    SparkContext
    Spark UI
    Version
    v3.0.0
    Master
    local[*]
    AppName
    pyspark-shell


```python
# costruisco un file txt (nota: questa stringa non deve stare prima del comando con %%)
%%writefile example.txt
first line
second line
third line
fourth line
```

    Writing example.txt



```python
!ls
```

    AWS-EC2-t2.micro-Spark.ipynb  
    anaconda3  
    example.txt
    Downloads		      
    certs	 
    spark-3.0.0-bin-hadoop3.2



```python
# costruisco RDD basato sul textfile
textFile = sc.textFile('example.txt')
```


```python
# actions
print(textFile.count()) # lunghezza
print(textFile.first()) # stampo prima linea
```

    4
    first line



```python
# trasformations
secfind = textFile.filter(lambda x: 'second' in x) # filter come apply
secfind
# siccome Spark è lazy le trasformations non verranno eseguite fino a quando non si richiama una actions
```




    PythonRDD[6] at RDD at PythonRDD.scala:53




```python
# effettuo actions sulle transformation
print(secfind.collect())
print(secfind.count())
```

    ['second line']
    1




### Utils
**Terminologia frequente**  

Term                   |Definition
----                   |-------
RDD                    |Resilient Distributed Dataset
Transformation         |Operazione Spark che produce un RDD
Action                 |Operazione Spark che produce un oggetto locale
Spark Job              |Sequenza di transformation sui dati con un'azione finale


**Creare un RDD**  
Ci sono due approcci comuni per creare un RDD:

Method                      |Result
----------                               |-------
`sc.parallelize(array)`                  |Crea RDD di elementi di array (o liste)
`sc.textFile(path/to/file)`                      |Crea RDD di linee da file

**RDD Transformations**  
Possiamo usare le trasformation per creare un set di istruzioni che vogliamo effettuare su l'RDD (prima che chiamiamo l'action e la loro esecuzione).

Transformation Example                          |Result
----------                               |-------
`filter(lambda x: x % 2 == 0)`           |Filtra i numeri pari
`map(lambda x: x * 2)`                   |Moltiplica ciascun elemento dell'RDD per `2`
`map(lambda x: x.split())`               |Dividi ciascuna stringa in parole
`flatMap(lambda x: x.split())`           |Dividi ciascuna stringa in parole e appiattisci la sequenza
`sample(withReplacement=True,0.25)`      |Crea un campione del 25% degli elementi con sostituzione
`union(rdd)`                             |Append `rdd` ad un altro RDD
`distinct()`                             |Rimuovi duplicati nell'RDD
`sortBy(lambda x: x, ascending=False)`   |Ordina gli elementi in modo decrescente


**RDD Actions**  
Una volta che si ha la l'elenco di trasformazioni pronte, verranno eseguite richiamando un'action. Seguono alcune action comuni:

Action                             |Result
----------                             |-------
`collect()`                            |Converte RDD in una lista in memoria 
`take(3)`                              |Primi 3 elementi dell'RDD 
`top(3)`                               |Top 3 elementi dell'RDD
`takeSample(withReplacement=True,3)`   |Crea un campione di 3 elementi con sostituzione
`sum()`                                |Fai la somma (assume elementi siano numerici)
`mean()`                               |Fai la media (assume elementi siano numerici)
`stdev()`                              |Fai la SD (assume elementi siano numerici)

### Spark Coding (2/2)
Il codice che segue è stato eseguito sulla macchina EC2 Amazon
```python
# lib
from pyspark import SparkContext
```
```python
# spark context
sc = SparkContext()
```
```python
# costruisco un file txt (nota: questa stringa non deve stare prima del comando con %%)
%%writefile example2.txt
first 
second line
the third line
then a fourth line
```

    Writing example2.txt



```python
# Save a reference to this RDD
text_rdd = sc.textFile('example2.txt')
text_rdd
```




    example2.txt MapPartitionsRDD[11] at textFile at NativeMethodAccessorImpl.java:0




```python
# stampo il contenuto del file
text_rdd.collect()
```




    ['first ', 'second line', 'the third line', 'then a fourth line']




```python
# Map a function (or lambda expression) to each line
# Then collect the results.
text_rdd.map(lambda x: x.split()).collect()
```




    [['first'],
     ['second', 'line'],
     ['the', 'third', 'line'],
     ['then', 'a', 'fourth', 'line']]



### Map vs flatMap


```python
# Collect everything as a single flat map
text_rdd.flatMap(lambda x: x.split()).collect()
```




    ['first',
     'second',
     'line',
     'the',
     'third',
     'line',
     'then',
     'a',
     'fourth',
     'line']



### RDDs and Key Value Pairs


```python
%%writefile services.txt
#EventId    Timestamp    Customer   State    ServiceID    Amount
201       10/13/2017      100       NY       131          100.00
204       10/18/2017      700       TX       129          450.00
202       10/15/2017      203       CA       121          200.00
206       10/19/2017      202       CA       131          500.00
203       10/17/2017      101       NY       173          750.00
205       10/19/2017      202       TX       121          200.00
```

    Writing services.txt



```python
# Save a reference to this RDD
services = sc.textFile('services.txt')
```


```python
# top 2 lines
services.take(2)
```




    ['#EventId    Timestamp    Customer   State    ServiceID    Amount',
     '201       10/13/2017      100       NY       131          100.00']




```python
# splitto ogni linea
services.map(lambda x: x.split()).take(3)
```




    [['#EventId', 'Timestamp', 'Customer', 'State', 'ServiceID', 'Amount'],
     ['201', '10/13/2017', '100', 'NY', '131', '100.00'],
     ['204', '10/18/2017', '700', 'TX', '129', '450.00']]




```python
# rimuovo hash tag
services.map(lambda x: x[1:] if x[0]=='#' else x).collect()
```




    ['EventId    Timestamp    Customer   State    ServiceID    Amount',
     '201       10/13/2017      100       NY       131          100.00',
     '204       10/18/2017      700       TX       129          450.00',
     '202       10/15/2017      203       CA       121          200.00',
     '206       10/19/2017      202       CA       131          500.00',
     '203       10/17/2017      101       NY       173          750.00',
     '205       10/19/2017      202       TX       121          200.00']




```python
# combino le due modifiche
services.map(lambda x: x[1:] if x[0]=='#' else x).map(lambda x: x.split()).collect()
```




    [['EventId', 'Timestamp', 'Customer', 'State', 'ServiceID', 'Amount'],
     ['201', '10/13/2017', '100', 'NY', '131', '100.00'],
     ['204', '10/18/2017', '700', 'TX', '129', '450.00'],
     ['202', '10/15/2017', '203', 'CA', '121', '200.00'],
     ['206', '10/19/2017', '202', 'CA', '131', '500.00'],
     ['203', '10/17/2017', '101', 'NY', '173', '750.00'],
     ['205', '10/19/2017', '202', 'TX', '121', '200.00']]



### Using Key Value Pairs for Operations


```python
# assegno il precedente
cleanServ = services.map(lambda x: x[1:] if x[0]=='#' else x).map(lambda x: x.split())
cleanServ.collect()
```




    [['EventId', 'Timestamp', 'Customer', 'State', 'ServiceID', 'Amount'],
     ['201', '10/13/2017', '100', 'NY', '131', '100.00'],
     ['204', '10/18/2017', '700', 'TX', '129', '450.00'],
     ['202', '10/15/2017', '203', 'CA', '121', '200.00'],
     ['206', '10/19/2017', '202', 'CA', '131', '500.00'],
     ['203', '10/17/2017', '101', 'NY', '173', '750.00'],
     ['205', '10/19/2017', '202', 'TX', '121', '200.00']]




```python
# estraggo due colonne specifiche (come tuple)
pairsServ = cleanServ.map(lambda x: (x[3],x[-1]))
pairsServ.collect()
```




    [('State', 'Amount'),
     ('NY', '100.00'),
     ('TX', '450.00'),
     ('CA', '200.00'),
     ('CA', '500.00'),
     ('NY', '750.00'),
     ('TX', '200.00')]




```python
# ByKey è come il groupby
# ByKey method assume che il dato è nella forma Key (come prima colonna) e Value (come seconda)
rekeyServ = pairsServ.reduceByKey(lambda x1,x2 : float(x1)+float(x2))
rekeyServ.collect()
```




    [('State', 'Amount'), ('NY', 850.0), ('TX', 650.0), ('CA', 700.0)]




```python
# 1. seleziona state and amounts
# 2. fanne la somma -- Reduce by Key
# 3. escludi ('State','Amount')
# 4. ordina per amount
# 5. Action! esegui il collect
cleanServ\
    .map(lambda x: (x[3],x[-1]))\
    .reduceByKey(lambda x1,x2 : float(x1)+float(x2))\
    .filter(lambda x: not x[0]=='State')\
    .sortBy(lambda x: x[1], ascending=False)\
    .collect()
```




    [('NY', 850.0), ('CA', 700.0), ('TX', 650.0)]




```python
# per la selezione abbiamo usato l'indexing delle colonne 
# è preferibile usare il tuple unpacking per rendere il codice più leggibile
lista = ['ID','State','Amount']

# con indexing
def func1(lst):
    return lst[-1]

# con tuple unpacking
def func2(id_st_amt):
    # Unpack Values
    (Id,st,amt) = id_st_amt
    return amt
```


```python
# fun1 con indexing
func1(lista)
```




    'Amount'




```python
# fun2 con tuple unpacking
func2(lista)
```




    'Amount'


