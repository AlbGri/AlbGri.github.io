---
title: "Python: the beginning"
excerpt: "Jupyter Notebook, Conda Environments and Basic Python"
date: 2020-07-05
tags: [python, utils]
---

*Versione di python*  
```console
~$ python --version
Python 3.7.7
```


## Jupyter Notebook


### Scorciatoie
ctrl + ù (no tastierino alfanumerico) → commenta linea codice  
ctrl + / (tastierino alfanumerico)    → commenta linea codice  

D D → elimina una cella  
A   → aggiungi una cella sopra quella attuale  
B   → aggiungi una cella sotto quella attuale  
F   → Find/Replace  
Y   → cambia cella in codice  
M   → cambia cella in Markdown  

SHIFT + Enter → Esegui e passa alla cella successiva  
CTRL + Enter → Esegui e passa alla cella successiva  


### Wrap Code
Celle a capo testo lungo in jupyter  
[Fonte](https://stackoverflow.com/q/36419342)  
```console
~$ conda activate py3
~$ jupyter --config-dir
/home/user/.jupyter
```

Creare la cartella 'nbconfig' nella config dir di jupyter
```console
mkdir /home/user/.jupyter/nbconfig
cd /home/user/.jupyter/nbconfig
cat > notebook.json
{
  "MarkdownCell": {
    "cm_config": {
      "lineWrapping": true
    }
  },
  "CodeCell": {
    "cm_config": {
      "lineWrapping": true
    }
  }
}
# Ctrl+D per chiudere il file
```

### Altro

Pulire il workspace
```python
%reset -f
```

### R in Jupyter Notebook (Windows)
Ho provato con _r-irkernel_ da conda, ma non mi piace perché scarica una propria versione di R, che può essere diversa rispetto la versione in locale. Quindi installo _IRkernel_ da R che legge direttamente la versione di R in locale e usa le librerie preinstallate. Vado un po' contro la filosofia degli environment di conda.
```console
~$ conda activate py3
~$ "C:\Program Files\R\R-4.0.0\bin\x64\R.exe"
```
```R
install.packages('IRkernel')
IRkernel::installspec()
```
Kernel list
```console
~$ jupyter kernelspec list
```
Da _'C:\Users\nomeUtente\AppData\Roaming\jupyter\kernels\ir\kernel.json'_ posso modificare "display_name" aggiungendo la versione (nel comando _installspec_ si può specificare il display_name) .


## Conda Enviroments

Per creare un ambiente su cui lavorare, da terminale:  

```console
~$ conda info --envs
~$ conda create --name py3 python=3.7
Proceed ([y]/n)? y
```

Attivo l'environment e installo quello che serve  
```console
~$ conda activate py3
~$ conda install jupyter
~$ conda install pandas
~$ conda install numpy
```

Mi sposto dove voglio lavorare  
```console
~$ conda activate py3
~$ cd "/media/user/Public/Python/Course 001"
~$ juputer notebook
```

Per disattivare e/o rimuovere un environment  
```console
~$ conda deactivate
~$ conda remove --name py3 --all
```

Per esportare un environment  
```console
~$ conda activate py3
~$ conda env export > py3_env.yml
```




## Basic Python


Utilizzo del r'nomeStringa': [qui il perché](https://stackoverflow.com/a/42655010)  


```python
# parametri, oggetti, variabili
num = 12
name = 'Sam'
```

```python
# rimuovi oggetti
x = 1
del x
```


```python
# stringa parametrica
'Numero {} e Nome {}'.format(num, name)
```




    'Numero 12 e Nome Sam'




```python
# stringa parametrica
print('Numero {} e Nome {}'.format(num, name))
print('Numero {one} e Nome {two}, e {one}'.format(one=num, two=name))
```

    Numero 12 e Nome Sam
    Numero 12 e Nome Sam, e 12



```python
# posizioni stringa
s = 'abcde'
print(s[0]+s[4])
print(s[:2])
print(s[2:])
print(s[1:3])
print(s[::-1])	# inverti testo della stringa
```

    ae
    ab
    cde
    bc
    edcba



```python
# lista
my_list = ['a', 'b', 'c']
print(my_list)

# lista estesa
my_list.append('d')
print(my_list)
print(my_list[1:3])

# modifica lista
my_list[0] = 'NEW'
print(my_list)

# rimuovo ultimo elemento dalla lista, se lo assegno quello rimosso viene assegnato al nuovo oggetto
# se definisci la posizione dentro il pop rimuove quello specifico elemento, altrimente prende l'ultimo di default
my_list_poppata = my_list.pop()
print(my_list)
print(my_list_poppata)

# lista nested
nest = [1, 2, [3, 4]]
print(nest[2])
print(nest[2][1])

# lista nested
nest = [1,2,3,[4,5,['target']]]
print(nest[3][2][0])
```

    ['a', 'b', 'c']
    ['a', 'b', 'c', 'd']
    ['b', 'c']
    ['NEW', 'b', 'c', 'd']
    ['NEW', 'b', 'c']
    d
    [3, 4]
    4
    target



```python
# dizionario
d = {'key1':'item1','key2':'item2'}
# print(d[0]) # da errore
print(d)
print(d['key1'])
```

    {'key1': 'item1', 'key2': 'item2'}
    item1



```python
# dizionario
d = {'k1':[1,2,3]}
my_list = d['k1'][1]
print(my_list)
```

    2



```python
# nested dizionari
d = {'k1':{'innerkey':[1,2,3]}}
print(d)
print(d['k1']['innerkey'][1])
```

    {'k1': {'innerkey': [1, 2, 3]}}
    2



```python
# tupla
t = (1,2,3)
print(t[0])
# t[0] = 'NEW' # da errore perché una tupla è immutabile, diversamente dalle liste
```

    1



```python
# set (univoci)
print({1, 2, 3, 3})
print(set([1,1,1,1,2,3,3]))

s = {1,2,3}
s.add(5)
print(s)
s.add(5)
print(s)
```

    {1, 2, 3}
    {1, 2, 3}
    {1, 2, 3, 5}
    {1, 2, 3, 5}



```python
# booleans, and, or
print((True) and (False))
print((True) or (False))
```

    False
    True



```python
# if, ifelse
if 1==2:
    print('uno')
elif 1==3:
    print('due')
elif 1==5:
    print('tre')
else:
    print('quattro')
```

    quattro



```python
# for loops
seq = [1,2,3,4,5]
for item in seq:
    print(item)
```

    1
    2
    3
    4
    5



```python
# while loops
i = 1
while i < 5:
    print('i is: {}'.format(i))
    i = i+1
```

    i is: 1
    i is: 2
    i is: 3
    i is: 4



```python
# range
print(range(5))
for i in range(5):
    print(i)
```

    range(0, 5)
    0
    1
    2
    3
    4



```python
# list comprehension
x = [1,2,3,4]
out = []
for item in x:
    out.append(item**2)
print(out)

print([item**2 for item in x])
```

    [1, 4, 9, 16]
    [1, 4, 9, 16]



```python
# functions
def my_func(parametro='default'):
    """
    documentazione che posso mostrare con shift+tab quando richiamo la funzione
    """
    print(parametro)

my_func()
my_func('o non default')
my_func('this is the question')
```

    default
    o non default
    this is the question



```python
my_func
```




    <function __main__.my_func(parametro='default')>




```python
def square(x):
    return x**2
out = square(2)
print(out)
```

    4



```python
# lambda functions
def times2(var):
    return var*2
print(times2(5))

def times2(var):return var*2
print(times2(5))

# lambda expression
t = lambda var: var*2
print(t(5))
```

    10
    10
    10



```python
# map
seq = [1,2,3,4,5]
print(map(times2, seq))
print(list(map(times2, seq)))

# lambda expression
print(list(map(t, seq)))
print(list(map(lambda num: num*2, seq)))
```

    <map object at 0x0000020AAA401EC8>
    [2, 4, 6, 8, 10]
    [2, 4, 6, 8, 10]
    [2, 4, 6, 8, 10]



```python
# filter
print(filter(lambda num: num%2 == 0, seq))
print(list(filter(lambda num: num%2 == 0, seq)))
```

    <filter object at 0x0000020AAA4A1188>
    [2, 4]



```python
# methods
st = 'Ciao! Sono Nessuno'
```


```python
# dopo il punto se usi tab suggerisce i metodi
print(st.lower())
print(st.upper())
print(st.split())
print(st.split('!'))
print(st.split('!')[1])
```

    ciao! sono nessuno
    CIAO! SONO NESSUNO
    ['Ciao!', 'Sono', 'Nessuno']
    ['Ciao', ' Sono Nessuno']
     Sono Nessuno



```python
d = {'k1':1, 'k2':2}
print(d)
# con tab escono i methods
print(d.values())
```

    {'k1': 1, 'k2': 2}
    dict_values([1, 2])



```python
# cerco elemento in lista, in method
print('x' in [1,2,3])
print('x' in ['x','y','z'])

# con la tupla
x = [(1,2), (3,4), (5,6)]
print(x[0][0])

# for con tuple
for item in x:
    print(item)

for (a,b) in x:
    print(a)
    
for a,b in x:
    print(a)
    print(b)
```

    False
    True
    1
    (1, 2)
    (3, 4)
    (5, 6)
    1
    3
    5
    1
    2
    3
    4
    5
    6


### Esercizi!


```python
# trova cani
def findDog(st):
    return 'dog' in st.lower().split()

# conta cani
def countDog(st):
    count = 0
    for word in st.lower().split():
        if word == 'dog':
            count += 1
    return count
```


```python
# trova gli elementi di un vettore che iniziano con la 'a'
print(list(filter(lambda parola: parola[0] == "a", vettore)))
```


## Utili
### L'imprecisione del float
Il problema dei linguaggi dinamici: non hai controllo sui type casting e si perdono dati senza sapere da dove. Evita il float se ti interessa la precisione (cit. Luca).  
Segue un esempio problema:  
```python
int(((10**9-1)/9)**2)
```

    12345678987654320


```python
int(((10**9-1)/9))**2
```

    12345678987654321


Il float di default in Python (3.7) perde dati oltre la 16esima cifra, quindi assegnando l'int a posteriori la perdita d'informazione già c'è stata. Invece, l'int prima del quadrato consente di lavorare sempre su int prima del raggiungimento della 16esima cifra.

