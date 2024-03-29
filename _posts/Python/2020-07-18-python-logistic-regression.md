---
title: "Python: Logistic Regression"
excerpt: "Machine Learning -- Titanic dataset"
date: 2020-07-18
tags: [python, ml]
mathjax: "true"
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
~$ conda deactivate
```




# Logistic Regression

Sigmoid o Logistic

$$
\forall x \in \mathbb{R} \\
f\left (x\right ) \in \left [0,1\right ] \\
f\left (x\right )=\frac{1}{1+e^{-x}}=\frac{e^{x}}{e^{x}+1}
$$

Linear regression to Logistic

$$
y=b_{0}+b_{1}\cdot x \\
p=\frac{1}{1+e^{-\left (b_{0}+b_{1}\cdot x\right )}}
$$


## Titanic dataset


```python
# lib
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
```


```python
# train df
train = pd.read_csv('titanic_train.csv')
train.head()
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
      <th>PassengerId</th>
      <th>Survived</th>
      <th>Pclass</th>
      <th>Name</th>
      <th>Sex</th>
      <th>Age</th>
      <th>SibSp</th>
      <th>Parch</th>
      <th>Ticket</th>
      <th>Fare</th>
      <th>Cabin</th>
      <th>Embarked</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>0</td>
      <td>3</td>
      <td>Braund, Mr. Owen Harris</td>
      <td>male</td>
      <td>22.0</td>
      <td>1</td>
      <td>0</td>
      <td>A/5 21171</td>
      <td>7.2500</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>1</td>
      <td>1</td>
      <td>Cumings, Mrs. John Bradley (Florence Briggs Th...</td>
      <td>female</td>
      <td>38.0</td>
      <td>1</td>
      <td>0</td>
      <td>PC 17599</td>
      <td>71.2833</td>
      <td>C85</td>
      <td>C</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>1</td>
      <td>3</td>
      <td>Heikkinen, Miss. Laina</td>
      <td>female</td>
      <td>26.0</td>
      <td>0</td>
      <td>0</td>
      <td>STON/O2. 3101282</td>
      <td>7.9250</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>1</td>
      <td>1</td>
      <td>Futrelle, Mrs. Jacques Heath (Lily May Peel)</td>
      <td>female</td>
      <td>35.0</td>
      <td>1</td>
      <td>0</td>
      <td>113803</td>
      <td>53.1000</td>
      <td>C123</td>
      <td>S</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>0</td>
      <td>3</td>
      <td>Allen, Mr. William Henry</td>
      <td>male</td>
      <td>35.0</td>
      <td>0</td>
      <td>0</td>
      <td>373450</td>
      <td>8.0500</td>
      <td>NaN</td>
      <td>S</td>
    </tr>
  </tbody>
</table>
</div>




```python
train.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 891 entries, 0 to 890
    Data columns (total 12 columns):
     #   Column       Non-Null Count  Dtype  
    ---  ------       --------------  -----  
     0   PassengerId  891 non-null    int64  
     1   Survived     891 non-null    int64  
     2   Pclass       891 non-null    int64  
     3   Name         891 non-null    object 
     4   Sex          891 non-null    object 
     5   Age          714 non-null    float64
     6   SibSp        891 non-null    int64  
     7   Parch        891 non-null    int64  
     8   Ticket       891 non-null    object 
     9   Fare         891 non-null    float64
     10  Cabin        204 non-null    object 
     11  Embarked     889 non-null    object 
    dtypes: float64(2), int64(5), object(5)
    memory usage: 83.7+ KB



```python
train.describe()
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
      <th>Survived</th>
      <th>Pclass</th>
      <th>Age</th>
      <th>SibSp</th>
      <th>Parch</th>
      <th>Fare</th>
      <th>Sex_male</th>
      <th>Embarked_Q</th>
      <th>Embarked_S</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>889.000000</td>
      <td>889.000000</td>
      <td>889.000000</td>
      <td>889.000000</td>
      <td>889.000000</td>
      <td>889.000000</td>
      <td>889.000000</td>
      <td>889.000000</td>
      <td>889.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>0.382452</td>
      <td>2.311586</td>
      <td>29.019314</td>
      <td>0.524184</td>
      <td>0.382452</td>
      <td>32.096681</td>
      <td>0.649044</td>
      <td>0.086614</td>
      <td>0.724409</td>
    </tr>
    <tr>
      <th>std</th>
      <td>0.486260</td>
      <td>0.834700</td>
      <td>13.209814</td>
      <td>1.103705</td>
      <td>0.806761</td>
      <td>49.697504</td>
      <td>0.477538</td>
      <td>0.281427</td>
      <td>0.447063</td>
    </tr>
    <tr>
      <th>min</th>
      <td>0.000000</td>
      <td>1.000000</td>
      <td>0.420000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>0.000000</td>
      <td>2.000000</td>
      <td>22.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>7.895800</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>0.000000</td>
      <td>3.000000</td>
      <td>26.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>14.454200</td>
      <td>1.000000</td>
      <td>0.000000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1.000000</td>
      <td>3.000000</td>
      <td>36.500000</td>
      <td>1.000000</td>
      <td>0.000000</td>
      <td>31.000000</td>
      <td>1.000000</td>
      <td>0.000000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.000000</td>
      <td>3.000000</td>
      <td>80.000000</td>
      <td>8.000000</td>
      <td>6.000000</td>
      <td>512.329200</td>
      <td>1.000000</td>
      <td>1.000000</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>



### EDA


```python
# view missing data
sns.heatmap(train.isnull(),yticklabels=False,cbar=False,cmap='viridis')
# maybe we will fill age and dropping cabin
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb227a84590>




![png](/assets/images/Python/Course 001/section-016/output_15_1.png)



```python
# target distribution
sns.set_style('whitegrid')
train['Survived'].value_counts().plot.pie(autopct='%1.1f%%',shadow=True,figsize=(4,4))
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb222c5bb50>




![png](/assets/images/Python/Course 001/section-016/output_16_1.png)



```python
# target distribution
sns.set_style('whitegrid')
sns.countplot(x='Survived',data=train,palette='RdBu_r')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb22728c110>




![png](/assets/images/Python/Course 001/section-016/output_17_1.png)



```python
# target barplot stratified with sex
sns.set_style('whitegrid')
sns.countplot(x='Survived',hue='Sex',data=train,palette='RdBu_r')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb2271fff50>




![png](/assets/images/Python/Course 001/section-016/output_18_1.png)



```python
# target barplot stratified with passenger class
sns.set_style('whitegrid')
sns.countplot(x='Survived',hue='Pclass',data=train,palette='rainbow')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb227176150>




![png](/assets/images/Python/Course 001/section-016/output_19_1.png)



```python
# eta histogram
sns.distplot(train['Age'].dropna(),kde=False,color='darkred',bins=30,hist_kws=dict(edgecolor="black", linewidth=1))
# train['Age'].hist(bins=30,color='darkred',alpha=0.7,edgecolor='black', linewidth=1)
# plt.xlabel('Age')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb2235ae310>




![png](/assets/images/Python/Course 001/section-016/output_20_1.png)



```python
# barplot of number of siblings or spouse
sns.countplot(x='SibSp',data=train)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb227045890>




![png](/assets/images/Python/Course 001/section-016/output_21_1.png)



```python
# barplot of number of parents or children
sns.countplot(x='Parch',data=train)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb226fb23d0>




![png](/assets/images/Python/Course 001/section-016/output_22_1.png)



```python
# histogram of price of the ticket
train['Fare'].hist(color='green',bins=40,figsize=(8,4))
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb226ea7990>




![png](/assets/images/Python/Course 001/section-016/output_23_1.png)


### Data Cleaning


```python
# boxplot passenger class and age
# plt.figure(figsize=(12, 7))
# sns.boxplot(x='Pclass',y='Age',data=train,palette='winter')
# object oriented
fig = plt.figure() # .figure() create a new figure whereas .gcf() stands for get current figure
fig.set_size_inches(10,7)
fig = sns.boxplot(x='Pclass',y='Age',data=train,palette='winter')
fig = sns.stripplot(x='Pclass',y='Age',data=train,jitter=True,edgecolor='white',alpha=0.5,linewidth=1,palette='winter')
plt.show()
# la prima classe ha mediamente un'età più avanzata
```


![png](/assets/images/Python/Course 001/section-016/output_25_0.png)



```python
# Boxen Plot
fig=plt.gcf()
fig.set_size_inches(10,7)
fig=sns.boxenplot(x='Pclass',y='Age',data=train,palette='winter')
```


![png](/assets/images/Python/Course 001/section-016/output_26_0.png)



```python
# imputare i missing dell'età
# funzione
def impute_age(cols):
    Age = cols[0]
    Pclass = cols[1]
    
    if pd.isnull(Age):

        if Pclass == 1:
            return 37

        elif Pclass == 2:
            return 29

        else:
            return 24

    else:
        return Age
# assegnazione
print("Pre imputazione:", train['Age'].isnull().sum())
train['Age'] = train[['Age','Pclass']].apply(impute_age,axis=1)
print("Post imputazione:", train['Age'].isnull().sum())
```

    Pre imputazione: 177
    Post imputazione: 0



```python
# esclusione cabin
train.drop('Cabin',axis=1,inplace=True)
```


```python
# esclusione record missing
print("Pre esclusione record missing:", len(train))
train.dropna(inplace=True)
print("Post esclusione record missing:", len(train))
```

    Pre esclusione record missing: 891
    Post esclusione record missing: 889



```python
# view missing data
sns.heatmap(train.isnull(),yticklabels=False,cbar=False,cmap='viridis')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fb223f2a050>




![png](/assets/images/Python/Course 001/section-016/output_30_1.png)


### OneHotEncoding/Dummyfication/Dummy Categorical features


```python
train.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 889 entries, 0 to 890
    Data columns (total 11 columns):
     #   Column       Non-Null Count  Dtype  
    ---  ------       --------------  -----  
     0   PassengerId  889 non-null    int64  
     1   Survived     889 non-null    int64  
     2   Pclass       889 non-null    int64  
     3   Name         889 non-null    object 
     4   Sex          889 non-null    object 
     5   Age          889 non-null    float64
     6   SibSp        889 non-null    int64  
     7   Parch        889 non-null    int64  
     8   Ticket       889 non-null    object 
     9   Fare         889 non-null    float64
     10  Embarked     889 non-null    object 
    dtypes: float64(2), int64(5), object(4)
    memory usage: 83.3+ KB



```python
# dummy
sex = pd.get_dummies(train['Sex'],drop_first=True,prefix='Sex')
embark = pd.get_dummies(train['Embarked'],drop_first=True,prefix='Embarked')

# invece di costruirle singolarmente, si possono dummificare tutte in un record
# train = pd.get_dummies(train,columns=['Sex','Embarked'],drop_first=True)

# escludo variabili inutili
train.drop(['Sex','Embarked','Name','Ticket','PassengerId'],axis=1,inplace=True)

# aggiungo le dummy create
train = pd.concat([train,sex,embark],axis=1)

# head
train.head()
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
      <th>Survived</th>
      <th>Pclass</th>
      <th>Age</th>
      <th>SibSp</th>
      <th>Parch</th>
      <th>Fare</th>
      <th>Sex_male</th>
      <th>Embarked_Q</th>
      <th>Embarked_S</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>3</td>
      <td>22.0</td>
      <td>1</td>
      <td>0</td>
      <td>7.2500</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>1</td>
      <td>38.0</td>
      <td>1</td>
      <td>0</td>
      <td>71.2833</td>
      <td>0</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1</td>
      <td>3</td>
      <td>26.0</td>
      <td>0</td>
      <td>0</td>
      <td>7.9250</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>1</td>
      <td>35.0</td>
      <td>1</td>
      <td>0</td>
      <td>53.1000</td>
      <td>0</td>
      <td>0</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0</td>
      <td>3</td>
      <td>35.0</td>
      <td>0</td>
      <td>0</td>
      <td>8.0500</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



### Logistic Regression


```python
# train test
X_train, X_test, y_train, y_test = train_test_split(train.drop('Survived',axis=1),train['Survived'], test_size=0.30,random_state=101)
```


```python
# model
logmodel = LogisticRegression(max_iter=10000)
# the solver was "liblinear" now it is "lbfgs" and needs more iterations
logmodel.fit(X_train,y_train)
```




    LogisticRegression(max_iter=10000)




```python
# prediction
predictions = logmodel.predict(X_test)
```


```python
# evaluation report
print(classification_report(y_test,predictions))
```

                  precision    recall  f1-score   support
    
               0       0.82      0.92      0.87       163
               1       0.85      0.69      0.76       104
    
        accuracy                           0.83       267
       macro avg       0.84      0.81      0.82       267
    weighted avg       0.83      0.83      0.83       267
    



```python
# confusion matrix
print(confusion_matrix(y_test,predictions))
```

    [[150  13]
     [ 32  72]]


### Improvements
* Try grabbing the Title (Dr.,Mr.,Mrs,etc..) from the name as a feature
* Maybe the Cabin letter could be a feature
* Is there any info you can get from the ticket?
* Evaluate the model on the test data (after clearing it)
