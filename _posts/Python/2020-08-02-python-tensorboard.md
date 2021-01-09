---
title: "Python: TensorBoard"
excerpt: "Machine Learning"
date: 2020-08-02
tags: [python, ml, utils]
mathjax: "true"
---

*Scritto ed eseguito sul portatile con Windows 10 -- Effetto South Working*

*Utilizzo l'environment conda py3_tf*  
```console
~$ conda activate py3_tf
```

# TensorBoard
Basato Breast cancer Wisconsin costruiamo i log per tenere traccia


```python
import pandas as pd
import numpy as np

from datetime import datetime
import os

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler

import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Activation,Dropout
from tensorflow.keras.callbacks import EarlyStopping,TensorBoard
```


```python
# df
df = pd.read_csv('cancer_classification.csv')
```


```python
# X e y
X = df.drop('benign_0__mal_1',axis=1).values
y = df['benign_0__mal_1'].values
```


```python
# train e test
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.25,random_state=101)
```


```python
# scaling
scaler = MinMaxScaler()
scaler.fit(X_train)
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)
```


```python
# early stopping
early_stop = EarlyStopping(monitor='val_loss', mode='min', verbose=1, patience=25)
```


```python
# working directory
os.getcwd()
```




    'F:\\Python\\Course 001'




```python
# time
datetime.now().strftime("%Y-%m-%d--%H%M")
```




    '2020-08-01--1701'




```python
# definizione tensorboard
# WINDOWS: Use "logs\\fit"
# MACOS/LINUX: Use "logs\fit"

log_directory = 'logs\\fit'

# OPTIONAL: ADD A TIMESTAMP FOR UNIQUE FOLDER
timestamp = datetime.now().strftime("%Y-%m-%d--%H%M")
log_directory = log_directory + '\\' + timestamp

board = TensorBoard(
    log_dir=log_directory,
    histogram_freq=1, # dopo ciascuna epoch calcola i pesi
    write_graph=True,
    write_images=True,
    update_freq='epoch',
    profile_batch=2,
    embeddings_freq=1)
```


```python
# definizione modello
model = Sequential()
model.add(Dense(units=30,activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(units=15,activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(units=1,activation='sigmoid'))
model.compile(loss='binary_crossentropy', optimizer='adam')
```


```python
# training modello (lanciarlo solo una volta nella stessa callback log_dir)
model.fit(x=X_train, 
          y=y_train, 
          epochs=600,
          validation_data=(X_test, y_test), verbose=0,
          callbacks=[early_stop,board]
          )
```

    Epoch 00138: early stopping

    <tensorflow.python.keras.callbacks.History at 0x2a852471d08>



### Monitoring
Attivo tensorboard dal terminale
```sh
tensorboard --logdir logs\fit
```
Con il servizio attivo posso visitare [http://localhost:6006/](http://localhost:6006/)  
Questo servizio di controllo e diagnostica è più utile per le convolutional neural networks.


```python
print(log_directory)
```

    logs\fit\2020-08-01--1701
    
