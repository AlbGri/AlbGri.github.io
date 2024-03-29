---
title: "Python: Natural Language Processing"
excerpt: "Machine Learning -- Yelp Review dataset"
date: 2020-07-25
tags: [python, ml, theory]
mathjax: "true"
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

*Versione modulo installato*  
```console
~$ pip show nltk
Name: nltk
Version: 3.5
Summary: Natural Language Toolkit
Home-page: http://nltk.org/
Author: Steven Bird
Author-email: stevenbird1@gmail.com
License: Apache License, Version 2.0
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: click, regex, joblib, tqdm
Required-by:
```

# NLP

Il vettore contenente il conteggio delle parole è il "Bag of Words"  
Per analizzarne la similarità tra i vettori è frequente utilizzare il [Coseno di similitudine](https://en.wikipedia.org/wiki/Cosine_similarity)  
$$sim\left (A,B\right )=\cos\left (\theta\right )=\frac{A\cdot B}{\left \|A  \right \|\left \|B  \right \|}$$  
Si può migliorare il "Bag of Words" migliorando il conteggio delle parole basandosi sulla frequenza nel corpus con il TF-IDF (Term Frequency - Inverse Document Frequency).  
1. Term Frequency - Importanza del termine all'interno del documento
    * *TF(d,t) =* Numero di occorrenze del termine *t* nel documento *d*  
1. Inverse Document Frequency - Importanza del termine all'interno del corpus
    * *IDF(t) =* log(D/t) dove
        * *D =* numero totale di documenti
        * *t =* numero di documenti con il termine

$$\mathit{TF-IDF}$$ del termine *x* all'interno del documento *y*  
$$W_{x,y}=\mathit{tf}_{x,y}\cdot \log\left (\frac{N}{df_x}\right )$$  
$$\mathit{tf}_{x,y}=$$ frequenza di *x* in *y*  
$$\mathit{df}_{x}=$$ numero di documenti contenenti *x*  
$$N=$$ numero totale di documenti  

## SMS Spam Collection

[UCI repository datasets](https://archive.ics.uci.edu/ml/index.php)  
View ALL Data Sets  
[SMS Spam Collection Data Set](https://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection)  


```python
# lib
import pandas as pd

import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

import string
import nltk
from nltk.corpus import stopwords # bisogna scaricarlo prima, vedi sotto

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
```


```python
# scarichiamo il package delle stopwords
# nltk.download_shell() 
# con l) List cerchiamo 'stopwords'
# con d) Download scarichiamo 'stopwords'
# con q) Quit si sblocca
```

    NLTK Downloader
    ---------------------------------------------------------------------------
        d) Download   l) List    u) Update   c) Config   h) Help   q) Quit
    ---------------------------------------------------------------------------
    Downloader> d
    
    Download which package (l=list; x=cancel)?
      Identifier> stopwords


        Downloading package stopwords to /home/user/nltk_data...
          Package stopwords is already up-to-date!


    
    ---------------------------------------------------------------------------
        d) Download   l) List    u) Update   c) Config   h) Help   q) Quit
    ---------------------------------------------------------------------------
    Downloader> q



```python
# read data (con list comrehension per ciclare i messaggi)
messages = [line.rstrip() for line in open('SMSSpamCollection')]
print(len(messages))
```

    5574



```python
# primi 5 messaggi del corpus (collezione di testi)
messages[:5]
# \t tab separation (TSV file è come un CSV)
```




    ['ham\tGo until jurong point, crazy.. Available only in bugis n great world la e buffet... Cine there got amore wat...',
     'ham\tOk lar... Joking wif u oni...',
     "spam\tFree entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt rate)T&C's apply 08452810075over18's"]




```python
# primi 5 messaggi strutturati meglio
for message_no, message in enumerate(messages[:5]):
    print(message_no, "---", message)
```

    0 --- ham	Go until jurong point, crazy.. Available only in bugis n great world la e buffet... Cine there got amore wat...
    1 --- ham	Ok lar... Joking wif u oni...
    2 --- spam	Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt rate)T&C's apply 08452810075over18's
    3 --- ham	U dun say so early hor... U c already then say...
    4 --- ham	Nah I don't think he goes to usf, he lives around here though



```python
# df
messages = pd.read_csv('SMSSpamCollection', sep='\t',names=["label", "message"])
messages.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>label</th>
      <th>message</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>ham</td>
      <td>Go until jurong point, crazy.. Available only ...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>ham</td>
      <td>Ok lar... Joking wif u oni...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>spam</td>
      <td>Free entry in 2 a wkly comp to win FA Cup fina...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>ham</td>
      <td>U dun say so early hor... U c already then say...</td>
    </tr>
    <tr>
      <th>4</th>
      <td>ham</td>
      <td>Nah I don't think he goes to usf, he lives aro...</td>
    </tr>
  </tbody>
</table>
</div>



### EDA


```python
messages.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 5572 entries, 0 to 5571
    Data columns (total 2 columns):
     #   Column   Non-Null Count  Dtype 
    ---  ------   --------------  ----- 
     0   label    5572 non-null   object
     1   message  5572 non-null   object
    dtypes: object(2)
    memory usage: 87.2+ KB



```python
messages.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>label</th>
      <th>message</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>5572</td>
      <td>5572</td>
    </tr>
    <tr>
      <th>unique</th>
      <td>2</td>
      <td>5169</td>
    </tr>
    <tr>
      <th>top</th>
      <td>ham</td>
      <td>Sorry, I'll call later</td>
    </tr>
    <tr>
      <th>freq</th>
      <td>4825</td>
      <td>30</td>
    </tr>
  </tbody>
</table>
</div>




```python
# describe stratificato per target
messages.groupby('label').describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th colspan="4" halign="left">message</th>
    </tr>
    <tr>
      <th></th>
      <th>count</th>
      <th>unique</th>
      <th>top</th>
      <th>freq</th>
    </tr>
    <tr>
      <th>label</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>ham</th>
      <td>4825</td>
      <td>4516</td>
      <td>Sorry, I'll call later</td>
      <td>30</td>
    </tr>
    <tr>
      <th>spam</th>
      <td>747</td>
      <td>653</td>
      <td>Please call our customer service representativ...</td>
      <td>4</td>
    </tr>
  </tbody>
</table>
</div>




```python
# new column length messages
messages['length'] = messages['message'].apply(len)
messages.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>label</th>
      <th>message</th>
      <th>length</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>ham</td>
      <td>Go until jurong point, crazy.. Available only ...</td>
      <td>111</td>
    </tr>
    <tr>
      <th>1</th>
      <td>ham</td>
      <td>Ok lar... Joking wif u oni...</td>
      <td>29</td>
    </tr>
    <tr>
      <th>2</th>
      <td>spam</td>
      <td>Free entry in 2 a wkly comp to win FA Cup fina...</td>
      <td>155</td>
    </tr>
    <tr>
      <th>3</th>
      <td>ham</td>
      <td>U dun say so early hor... U c already then say...</td>
      <td>49</td>
    </tr>
    <tr>
      <th>4</th>
      <td>ham</td>
      <td>Nah I don't think he goes to usf, he lives aro...</td>
      <td>61</td>
    </tr>
  </tbody>
</table>
</div>



### Data Visualization


```python
# distribuzione lunghezza
sns.set_style('whitegrid')
messages['length'].plot(bins=50, kind='hist')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fc7bb961950>




![png](/assets/images/Python/Course 001/section-024/output_20_1.png)



```python
# sintesi distribuzione lunghezza
messages['length'].describe()
```




    count    5572.000000
    mean       80.489950
    std        59.942907
    min         2.000000
    25%        36.000000
    50%        62.000000
    75%       122.000000
    max       910.000000
    Name: length, dtype: float64




```python
# estraggo l'outlier
messages[messages['length']==910]['message'].iloc[0] # printo stringa completa
```




    "For me the love should start with attraction.i should feel that I need her every time around me.she should be the first thing which comes in my thoughts.I would start the day and end it with her.she should be there every time I dream.love will be then when my every breath has her name.my life should happen around her.my life will be named to her.I would cry for her.will give all my happiness and take all her sorrows.I will be ready to fight with anyone for her.I will be in love when I will be doing the craziest things for her.love will be when I don't have to proove anyone that my girl is the most beautiful lady on the whole planet.I will always be singing praises for her.love will be when I start up making chicken curry and end up makiing sambar.life will be the most beautiful then.will get every morning and thank god for the day because she is with me.I would like to say a lot..will tell later.."




```python
# distribuzione lunghezza stratificato per target
messages.hist(column='length', by='label', bins=50,figsize=(12,4))
```




    array([<matplotlib.axes._subplots.AxesSubplot object at 0x7fc7bb2ef7d0>,
           <matplotlib.axes._subplots.AxesSubplot object at 0x7fc7bb6a1790>],
          dtype=object)




![png](/assets/images/Python/Course 001/section-024/output_23_1.png)



```python
# sintesi distribuzione lunghezza stratificato per target
messages.groupby('label').describe()
# i messaggi di spam sono mediamente più lunghi
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th></th>
      <th colspan="8" halign="left">length</th>
    </tr>
    <tr>
      <th></th>
      <th>count</th>
      <th>mean</th>
      <th>std</th>
      <th>min</th>
      <th>25%</th>
      <th>50%</th>
      <th>75%</th>
      <th>max</th>
    </tr>
    <tr>
      <th>label</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>ham</th>
      <td>4825.0</td>
      <td>71.482487</td>
      <td>58.440652</td>
      <td>2.0</td>
      <td>33.0</td>
      <td>52.0</td>
      <td>93.0</td>
      <td>910.0</td>
    </tr>
    <tr>
      <th>spam</th>
      <td>747.0</td>
      <td>138.670683</td>
      <td>28.873603</td>
      <td>13.0</td>
      <td>133.0</td>
      <td>149.0</td>
      <td>157.0</td>
      <td>223.0</td>
    </tr>
  </tbody>
</table>
</div>



### Text Pre-processing


```python
# string.punctuation
string.punctuation
```




    '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'




```python
# raw messages to vectors
mess = 'Sample message! Notice: it has punctuation.'
# itera ed escludi se ha punteggiatura
nopunc = [char for char in mess if char not in string.punctuation]
nopunc = ''.join(nopunc)
print(nopunc)
```

    Sample message Notice it has punctuation



```python
# stopwords
stopwords.words('english')[0:10] # ha anche l'italiano
```




    ['i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', "you're"]




```python
# rimuovo le stop words
clean_mess = [word for word in nopunc.split() if word.lower() not in stopwords.words('english')]
print(clean_mess)
```

    ['Sample', 'message', 'Notice', 'punctuation']



```python
# funzione per pulire
def text_process(mess):
    """
    Takes in a string of text, then performs the following:
    1. Remove all punctuation
    2. Remove all stopwords
    3. Returns a list of the cleaned text
    """
    # Check characters to see if they are in punctuation
    nopunc = [char for char in mess if char not in string.punctuation]
    # Join the characters again to form the string.
    nopunc = ''.join(nopunc)
    # Now just remove any stopwords
    return [word for word in nopunc.split() if word.lower() not in stopwords.words('english')]
```


```python
messages.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>label</th>
      <th>message</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>ham</td>
      <td>Go until jurong point, crazy.. Available only ...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>ham</td>
      <td>Ok lar... Joking wif u oni...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>spam</td>
      <td>Free entry in 2 a wkly comp to win FA Cup fina...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>ham</td>
      <td>U dun say so early hor... U c already then say...</td>
    </tr>
    <tr>
      <th>4</th>
      <td>ham</td>
      <td>Nah I don't think he goes to usf, he lives aro...</td>
    </tr>
  </tbody>
</table>
</div>




```python
messages['message'].head(5).apply(text_process)
```




    0    [Go, jurong, point, crazy, Available, bugis, n...
    1                       [Ok, lar, Joking, wif, u, oni]
    2    [Free, entry, 2, wkly, comp, win, FA, Cup, fin...
    3        [U, dun, say, early, hor, U, c, already, say]
    4    [Nah, dont, think, goes, usf, lives, around, t...
    Name: message, dtype: object



**Continuing Normalization**  
Si può continuare con la normalizzazione con lo stemming o con i tool di [nltk](http://www.nltk.org/book/ch05.html).

### Vectorization

Si hanno i messaggi come liste di tokens (lemmas) e bisogna convertire i messaggi in vettore tramite SciKitLearn.

Il processo avverrà in tre step usando il modello bag-of-words:  
1. Conta quante volte una parola si presenta in ciascun messaggio (term frequency)

2. Pesa i conteggi, così che i token frequenti prendono peso minore (inverse document frequency)

3. Normalizza i vettori a norma unitaria, per astrarsi dalla lunghezza del testo originale (norma L2)

CountVectorizer per convertire una collezione di documenti testuali in una matrice di token counts.  
Costruiamo la seguente matrice sparsa  
<img src="/assets/images/Python/Course 001/section-024/001-MatriceSparsa.png" width="400">






```python
# matrix token counts
bow_transformer = CountVectorizer(analyzer=text_process).fit(messages['message'])

# total number of vocab words
print(len(bow_transformer.vocabulary_))
```

    11425



```python
# esempio: bag-of-words counts as a vector
message4 = messages['message'][3]
print(message4)
```

    U dun say so early hor... U c already then say...



```python
# esempio: la sua rappresentazione a vettore
bow4 = bow_transformer.transform([message4])
print(bow4)
print(bow4.shape)
```

      (0, 4068)	2
      (0, 4629)	1
      (0, 5261)	1
      (0, 6204)	1
      (0, 6222)	1
      (0, 7186)	1
      (0, 9554)	2
    (1, 11425)



```python
# doppioni
print(bow_transformer.get_feature_names()[4068])
print(bow_transformer.get_feature_names()[9554])
```

    U
    say



```python
# trasformiamo tutto il corpus
messages_bow = bow_transformer.transform(messages['message'])
print('Shape of Sparse Matrix: ', messages_bow.shape)
print('Amount of Non-Zero occurences: ', messages_bow.nnz)
```

    Shape of Sparse Matrix:  (5572, 11425)
    Amount of Non-Zero occurences:  50548



```python
# sparsity (non zero vs tutti)
sparsity = (100.0 * messages_bow.nnz / (messages_bow.shape[0] * messages_bow.shape[1]))
print('sparsity: {}'.format(sparsity))
```

    sparsity: 0.07940295412668218



```python
# "alleno" il tf-idf su tutto il corpus in forma matriciale
tfidf_transformer = TfidfTransformer().fit(messages_bow)
```


```python
# adatto all'esempio
tfidf4 = tfidf_transformer.transform(bow4)
print(tfidf4)
```

      (0, 9554)	0.5385626262927564
      (0, 7186)	0.4389365653379857
      (0, 6222)	0.3187216892949149
      (0, 6204)	0.29953799723697416
      (0, 5261)	0.29729957405868723
      (0, 4629)	0.26619801906087187
      (0, 4068)	0.40832589933384067



```python
# il tf idf per due parole
print(tfidf_transformer.idf_[bow_transformer.vocabulary_['u']])
print(tfidf_transformer.idf_[bow_transformer.vocabulary_['university']])
```

    3.2800524267409408
    8.527076498901426



```python
# trasformiamo tutto il corpus
messages_tfidf = tfidf_transformer.transform(messages_bow)
print(messages_tfidf.shape)
```

    (5572, 11425)


### Model: Naive Bayes


```python
# fit model
spam_detect_model = MultinomialNB().fit(messages_tfidf, messages['label'])
```


```python
print("Messaggio:")
print(message4)
print("\nForma Vettorizzata")
print(bow4)
print("\nPesi TF-IDF")
print(tfidf4)
```

    Messaggio:
    U dun say so early hor... U c already then say...
    
    Forma Vettorizzata
      (0, 4068)	2
      (0, 4629)	1
      (0, 5261)	1
      (0, 6204)	1
      (0, 6222)	1
      (0, 7186)	1
      (0, 9554)	2
    
    Pesi TF-IDF
      (0, 9554)	0.5385626262927564
      (0, 7186)	0.4389365653379857
      (0, 6222)	0.3187216892949149
      (0, 6204)	0.29953799723697416
      (0, 5261)	0.29729957405868723
      (0, 4629)	0.26619801906087187
      (0, 4068)	0.40832589933384067



```python
# prediction example
print('predicted:', spam_detect_model.predict(tfidf4)[0])
print('expected:', messages.label[3])
```

    predicted: ham
    expected: ham



```python
# predictions
all_predictions = spam_detect_model.predict(messages_tfidf)
print(all_predictions)
```

    ['ham' 'ham' 'spam' ... 'ham' 'ham' 'ham']


### Pipeline

Ripetiamo l'intero processo dividendo correttamente in training e test set.  
La funzione Pipeline rende tutto come una API


```python
# train test
msg_train, msg_test, label_train, label_test = \
train_test_split(messages['message'], messages['label'], test_size=0.2)

print(len(msg_train), len(msg_test), len(msg_train) + len(msg_test))
```

    4457 1115 5572



```python
# pipeline
pipeline = Pipeline([
    ('bow', CountVectorizer(analyzer=text_process)),  # strings to token integer counts
    ('tfidf', TfidfTransformer()),  # integer counts to weighted TF-IDF scores
    ('classifier', MultinomialNB()),  # train on TF-IDF vectors w/ Naive Bayes classifier
])
```


```python
# pipeline call
pipeline.fit(msg_train,label_train)
```




    Pipeline(steps=[('bow',
                     CountVectorizer(analyzer=<function text_process at 0x7f6fd9716ef0>)),
                    ('tfidf', TfidfTransformer()),
                    ('classifier', MultinomialNB())])




```python
# predictions
predictions = pipeline.predict(msg_test)
```


```python
# metrics
print(classification_report(predictions,label_test))
```

                  precision    recall  f1-score   support
    
             ham       1.00      0.96      0.98      1000
            spam       0.76      1.00      0.86       115
    
        accuracy                           0.97      1115
       macro avg       0.88      0.98      0.92      1115
    weighted avg       0.98      0.97      0.97      1115
    


Precision: how many selected items are relevant?  
Recall: how many relevant items are selected?


```python
# reset
%reset -f
```

## Yelp Review Data Set

[Yelp Review Data Set from Kaggle](https://www.kaggle.com/c/yelp-recsys-2013). Each observation in this dataset is a review of a particular business by a particular user.


```python
# lib
import pandas as pd

import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

import string
import nltk
from nltk.corpus import stopwords

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.naive_bayes import MultinomialNB
from sklearn.metrics import classification_report,confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
```

```python
# df
yelp = pd.read_csv(r'yelp.csv')
yelp.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>business_id</th>
      <th>date</th>
      <th>review_id</th>
      <th>stars</th>
      <th>text</th>
      <th>type</th>
      <th>user_id</th>
      <th>cool</th>
      <th>useful</th>
      <th>funny</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>9yKzy9PApeiPPOUJEtnvkg</td>
      <td>2011-01-26</td>
      <td>fWKvX83p0-ka4JS3dc6E5A</td>
      <td>5</td>
      <td>My wife took me here on my birthday for breakf...</td>
      <td>review</td>
      <td>rLtl8ZkDX5vH5nAx9C3q5Q</td>
      <td>2</td>
      <td>5</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>ZRJwVLyzEJq1VAihDhYiow</td>
      <td>2011-07-27</td>
      <td>IjZ33sJrzXqU-0X6U8NwyA</td>
      <td>5</td>
      <td>I have no idea why some people give bad review...</td>
      <td>review</td>
      <td>0a2KyEL0d3Yb1V6aivbIuQ</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>6oRAC4uyJCsJl1X0WZpVSA</td>
      <td>2012-06-14</td>
      <td>IESLBzqUCLdSzSqm0eCSxQ</td>
      <td>4</td>
      <td>love the gyro plate. Rice is so good and I als...</td>
      <td>review</td>
      <td>0hT2KtfLiobPvh6cDC8JQg</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>_1QQZuf4zZOyFCvXc0o6Vg</td>
      <td>2010-05-27</td>
      <td>G-WvGaISbqqaMHlNnByodA</td>
      <td>5</td>
      <td>Rosie, Dakota, and I LOVE Chaparral Dog Park!!...</td>
      <td>review</td>
      <td>uZetl9T0NcROGOyFfughhg</td>
      <td>1</td>
      <td>2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>6ozycU1RpktNG2-1BroVtw</td>
      <td>2012-01-05</td>
      <td>1uJFq2r5QfJG_6ExMRCaGw</td>
      <td>5</td>
      <td>General Manager Scott Petello is a good egg!!!...</td>
      <td>review</td>
      <td>vYmM4KTsC8ZfQBg-j5MWkw</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




```python
yelp.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 10000 entries, 0 to 9999
    Data columns (total 10 columns):
     #   Column       Non-Null Count  Dtype 
    ---  ------       --------------  ----- 
     0   business_id  10000 non-null  object
     1   date         10000 non-null  object
     2   review_id    10000 non-null  object
     3   stars        10000 non-null  int64 
     4   text         10000 non-null  object
     5   type         10000 non-null  object
     6   user_id      10000 non-null  object
     7   cool         10000 non-null  int64 
     8   useful       10000 non-null  int64 
     9   funny        10000 non-null  int64 
    dtypes: int64(4), object(6)
    memory usage: 781.4+ KB



```python
yelp.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>stars</th>
      <th>cool</th>
      <th>useful</th>
      <th>funny</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>10000.000000</td>
      <td>10000.000000</td>
      <td>10000.000000</td>
      <td>10000.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>3.777500</td>
      <td>0.876800</td>
      <td>1.409300</td>
      <td>0.701300</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1.214636</td>
      <td>2.067861</td>
      <td>2.336647</td>
      <td>1.907942</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>3.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>4.000000</td>
      <td>0.000000</td>
      <td>1.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>5.000000</td>
      <td>1.000000</td>
      <td>2.000000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>5.000000</td>
      <td>77.000000</td>
      <td>76.000000</td>
      <td>57.000000</td>
    </tr>
  </tbody>
</table>
</div>




```python
# text length
yelp['text_length'] = yelp['text'].apply(len)
yelp['text_length'].describe()
```




    count    10000.000000
    mean       710.738700
    std        617.399827
    min          1.000000
    25%        294.000000
    50%        541.500000
    75%        930.000000
    max       4997.000000
    Name: text_length, dtype: float64



### EDA


```python
# separatore migliaia come punto
import matplotlib as mpl
dot_sep = lambda x, p: format(int(x), ',').replace(",", "X").replace(".", ",").replace("X", ".")

# 5 histograms of text length based off of the star ratings
sns.set_style('whitegrid')
g = sns.FacetGrid(data=yelp,col='stars')
g.map(plt.hist,'text_length',bins=50)


for ax in g.axes[:,0]:
  ax.get_yaxis().set_major_formatter(mpl.ticker.FuncFormatter(dot_sep))
  ax.get_xaxis().set_major_formatter(mpl.ticker.FuncFormatter(dot_sep))
```


![png](/assets/images/Python/Course 001/section-024/output_70_0.png)



```python
# boxplot of text length for each star category
sns.boxplot(x='stars',y='text_length',data=yelp,palette='rainbow')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f9cd731b090>




![png](/assets/images/Python/Course 001/section-024/output_71_1.png)



```python
# countplot numbere of occurrences of each type of star rating
sns.countplot(x='stars',data=yelp,palette='rainbow')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f9cd731b610>




![png](/assets/images/Python/Course 001/section-024/output_72_1.png)



```python
# grouby stars mean attributes
stars = yelp.groupby(by='stars').mean()
stars
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>cool</th>
      <th>useful</th>
      <th>funny</th>
      <th>text_length</th>
    </tr>
    <tr>
      <th>stars</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>1</th>
      <td>0.576769</td>
      <td>1.604806</td>
      <td>1.056075</td>
      <td>826.515354</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.719525</td>
      <td>1.563107</td>
      <td>0.875944</td>
      <td>842.256742</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.788501</td>
      <td>1.306639</td>
      <td>0.694730</td>
      <td>758.498289</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.954623</td>
      <td>1.395916</td>
      <td>0.670448</td>
      <td>712.923142</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.944261</td>
      <td>1.381780</td>
      <td>0.608631</td>
      <td>624.999101</td>
    </tr>
  </tbody>
</table>
</div>




```python
# corr of means by stars
stars.corr()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>cool</th>
      <th>useful</th>
      <th>funny</th>
      <th>text_length</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>cool</th>
      <td>1.000000</td>
      <td>-0.743329</td>
      <td>-0.944939</td>
      <td>-0.857664</td>
    </tr>
    <tr>
      <th>useful</th>
      <td>-0.743329</td>
      <td>1.000000</td>
      <td>0.894506</td>
      <td>0.699881</td>
    </tr>
    <tr>
      <th>funny</th>
      <td>-0.944939</td>
      <td>0.894506</td>
      <td>1.000000</td>
      <td>0.843461</td>
    </tr>
    <tr>
      <th>text_length</th>
      <td>-0.857664</td>
      <td>0.699881</td>
      <td>0.843461</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>




```python
# heatmap
sns.heatmap(stars.corr(),annot=True,cmap='coolwarm')
plt.title('yelp_stars.corr()')
```




    Text(0.5, 1.0, 'yelp_stars.corr()')




![png](/assets/images/Python/Course 001/section-024/output_75_1.png)


### NLP Classification Task


```python
yelp['stars'].value_counts()
```




    4    3526
    5    3337
    3    1461
    2     927
    1     749
    Name: stars, dtype: int64




```python
# only 1 and 5 rated stars
yelp_class = yelp[(yelp['stars']==1)|(yelp['stars']==5)]
yelp_class['stars'].value_counts()
```




    5    3337
    1     749
    Name: stars, dtype: int64




```python
# features and target
X = yelp_class['text']
y = yelp_class['stars']
```


```python
# trasformo in token counts e adattiamo a tutto il corpus
X = CountVectorizer().fit_transform(X)
print('Shape of Sparse Matrix: ', X.shape)
print('Amount of Non-Zero occurences: ', X.nnz)
```

    Shape of Sparse Matrix:  (4086, 19183)
    Amount of Non-Zero occurences:  317288


### Model


```python
# train test split (su matrice già in forma countvectorized)
X_train, X_test, y_train, y_test = \
train_test_split(X, y, test_size=0.3, random_state=101)
```


```python
# naive bayes
nb = MultinomialNB()
nb.fit(X_train, y_train)
```




    MultinomialNB()




```python
# predictions
predictions = nb.predict(X_test)
```


```python
# confusion matrix and classification metrix
print('\nConfusion Matrix:')
print(confusion_matrix(y_test,predictions))
print('\nClassification metrics:')
print(classification_report(y_test,predictions))
```

    
    Confusion Matrix:
    [[159  69]
     [ 22 976]]
    
    Classification metrics:
                  precision    recall  f1-score   support
    
               1       0.88      0.70      0.78       228
               5       0.93      0.98      0.96       998
    
        accuracy                           0.93      1226
       macro avg       0.91      0.84      0.87      1226
    weighted avg       0.92      0.93      0.92      1226
    


### Using Text Processing and Pipeline


```python
# train test split (su dati originali)
X = yelp_class['text']
y = yelp_class['stars']
X_train, X_test, y_train, y_test = \
train_test_split(X, y, test_size=0.3, random_state=101)
```


```python
# pipeline
pipeline = Pipeline([  # lista di tuple
    ('bow', CountVectorizer()),  # strings to token integer counts
    ('tfidf', TfidfTransformer()),  # integer counts to weighted TF-IDF scores
    ('classifier', MultinomialNB()),  # train on TF-IDF vectors w/ Naive Bayes classifier
])
```


```python
# pipeline call
pipeline.fit(X_train,y_train)
```




    Pipeline(steps=[('bow', CountVectorizer()), ('tfidf', TfidfTransformer()),
                    ('classifier', MultinomialNB())])




```python
# predictions
predictions = pipeline.predict(X_test)
```


```python
# confusion matrix and classification metrix
print('\nConfusion Matrix:')
print(confusion_matrix(y_test,predictions))
print('\nClassification metrics:')
print(classification_report(y_test,predictions))
```

    
    Confusion Matrix:
    [[  0 228]
     [  0 998]]
    
    Classification metrics:
                  precision    recall  f1-score   support
    
               1       0.00      0.00      0.00       228
               5       0.81      1.00      0.90       998
    
        accuracy                           0.81      1226
       macro avg       0.41      0.50      0.45      1226
    weighted avg       0.66      0.81      0.73      1226
    


    /home/user/miniconda3/envs/py3/lib/python3.7/site-packages/sklearn/metrics/_classification.py:1221: UndefinedMetricWarning: Precision and F-score are ill-defined and being set to 0.0 in labels with no predicted samples. Use `zero_division` parameter to control this behavior.
      _warn_prf(average, modifier, msg_start, len(result))


Risulta peggiorato con l'aggiunta del TF-IDF, si potrebbe aggiungere un custom analyzer, o direttamente rimuovere lo step del TF-IDF dalla pipeline, o cambiare il modello.

## More resources
[NLTK Book Online](http://www.nltk.org/book/)

[Kaggle Walkthrough](https://www.kaggle.com/c/word2vec-nlp-tutorial/details/part-1-for-beginners-bag-of-words)

[SciKit Learn's Tutorial](http://scikit-learn.org/stable/tutorial/text_analytics/working_with_text_data.html)
