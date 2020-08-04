---
title: "Python: Support Vector Machine"
excerpt: "Machine Learning -- Iris dataset"
date: 2020-07-21
tags: [python, ml]
mathjax: "true"

---
*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

# SVM

Prima o poi pubblico gli appunti di università!
<img src="/assets/images/Python/Course 001/section-020/001-SVM.png" width="400">

I kernel permettono di fare trasformazioni ai dati e quindi di separare casi non linearmente separabili.


```python
# lib
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import classification_report,confusion_matrix
from sklearn.model_selection import GridSearchCV
```


```python
# cancer Bunch
cancer = load_breast_cancer()
cancer.keys()
```




    dict_keys(['data', 'target', 'frame', 'target_names', 'DESCR', 'feature_names', 'filename'])




```python
# type
type(cancer)
```




    sklearn.utils.Bunch




```python
# description of the Bunch
print(cancer['DESCR'])
```

    .. _breast_cancer_dataset:
    
    Breast cancer wisconsin (diagnostic) dataset
    --------------------------------------------
    
    **Data Set Characteristics:**
    
        :Number of Instances: 569
    
        :Number of Attributes: 30 numeric, predictive attributes and the class
    
        :Attribute Information:
            - radius (mean of distances from center to points on the perimeter)
            - texture (standard deviation of gray-scale values)
            - perimeter
            - area
            - smoothness (local variation in radius lengths)
            - compactness (perimeter^2 / area - 1.0)
            - concavity (severity of concave portions of the contour)
            - concave points (number of concave portions of the contour)
            - symmetry
            - fractal dimension ("coastline approximation" - 1)
    
            The mean, standard error, and "worst" or largest (mean of the three
            worst/largest values) of these features were computed for each image,
            resulting in 30 features.  For instance, field 0 is Mean Radius, field
            10 is Radius SE, field 20 is Worst Radius.
    
            - class:
                    - WDBC-Malignant
                    - WDBC-Benign
    
        ...



```python
# columns
cancer['feature_names']
```




    array(['mean radius', 'mean texture', 'mean perimeter', 'mean area',
           'mean smoothness', 'mean compactness', 'mean concavity',
           'mean concave points', 'mean symmetry', 'mean fractal dimension',
           'radius error', 'texture error', 'perimeter error', 'area error',
           'smoothness error', 'compactness error', 'concavity error',
           'concave points error', 'symmetry error',
           'fractal dimension error', 'worst radius', 'worst texture',
           'worst perimeter', 'worst area', 'worst smoothness',
           'worst compactness', 'worst concavity', 'worst concave points',
           'worst symmetry', 'worst fractal dimension'], dtype='<U23')




```python
# dataframe (solo le esplicative)
df_feat = pd.DataFrame(cancer['data'],columns=cancer['feature_names'])
df_feat.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 569 entries, 0 to 568
    Data columns (total 30 columns):
     #   Column                   Non-Null Count  Dtype  
    ---  ------                   --------------  -----  
     0   mean radius              569 non-null    float64
     1   mean texture             569 non-null    float64
     ....................................................
     28  worst symmetry           569 non-null    float64
     29  worst fractal dimension  569 non-null    float64
    dtypes: float64(30)
    memory usage: 133.5 KB



```python
# dataframe (target)
df_target = pd.DataFrame(cancer['target'],columns=['Cancer'])
df_target['Cancer'].value_counts()
```




    1    357
    0    212
    Name: Cancer, dtype: int64



## EDA

skipped today :))

## SVM Model


```python
# train test set
X = df_feat
y = cancer['target'] # oppure np.ravel(df_target) per renderlo array

X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.30, random_state=101)
```


```python
# svm
model = SVC()
model.fit(X_train,y_train)
```




    SVC()




```python
# predictions
predictions = model.predict(X_test)
```


```python
# metrics
print('\nConfusion Matrix:')
print(confusion_matrix(y_test,predictions))
print('\nClassification metrics:')
print(classification_report(y_test,predictions))
```

    
    Confusion Matrix:
    [[ 56  10]
     [  3 102]]
    
    Classification metrics:
                  precision    recall  f1-score   support
    
               0       0.95      0.85      0.90        66
               1       0.91      0.97      0.94       105
    
        accuracy                           0.92       171
       macro avg       0.93      0.91      0.92       171
    weighted avg       0.93      0.92      0.92       171
    


## GridSearch


```python
# grid
param_grid = {'C': [0.01,0.1,1, 10, 100, 1000], 'gamma': [1,0.1,0.01,0.001,0.0001,0.00001], 'kernel': ['rbf']}
# large C low bias high variance e viceversa per C elevato
grid = GridSearchCV(SVC(),param_grid,refit=True,verbose=3)
# verbose più è alto e più lascia traccia
```


```python
# grid fitting
grid.fit(X_train,y_train)
```

    Fitting 5 folds for each of 36 candidates, totalling 180 fits
    [CV] C=0.01, gamma=1, kernel=rbf .....................................
    [CV] ......... C=0.01, gamma=1, kernel=rbf, score=0.637, total=   0.0s
    ...
    [CV] C=1000, gamma=1e-05, kernel=rbf .................................
    [CV] ..... C=1000, gamma=1e-05, kernel=rbf, score=0.975, total=   0.0s


    [Parallel(n_jobs=1)]: Done 180 out of 180 | elapsed:    2.3s finished


    GridSearchCV(estimator=SVC(),
                 param_grid={'C': [0.01, 0.1, 1, 10, 100, 1000],
                             'gamma': [1, 0.1, 0.01, 0.001, 0.0001, 1e-05],
                             'kernel': ['rbf']},
                 verbose=3)




```python
# best parameters
grid.best_params_
```




    {'C': 100, 'gamma': 1e-05, 'kernel': 'rbf'}




```python
# best estimators
grid.best_estimator_
```




    SVC(C=100, gamma=1e-05)




```python
# predictions
predictions_grid = grid.predict(X_test)
```


```python
# metrics
print('\nConfusion Matrix:')
print(confusion_matrix(y_test,predictions_grid))
print('\nClassification metrics:')
print(classification_report(y_test,predictions_grid))
```

    
    Confusion Matrix:
    [[ 59   7]
     [  4 101]]
    
    Classification metrics:
                  precision    recall  f1-score   support
    
               0       0.94      0.89      0.91        66
               1       0.94      0.96      0.95       105
    
        accuracy                           0.94       171
       macro avg       0.94      0.93      0.93       171
    weighted avg       0.94      0.94      0.94       171
    



```python
# pulisco il workspace
%reset -f
```

## Iris Dataset

The famous [Iris flower data set](http://en.wikipedia.org/wiki/Iris_flower_data_set). 

The Iris flower data set or Fisher's Iris data set is a multivariate data set introduced by Sir Ronald Fisher in the 1936 as an example of discriminant analysis. 

The data set consists of 50 samples from each of three species of Iris (Iris setosa, Iris virginica and Iris versicolor), so 150 total samples. Four features were measured from each sample: the length and the width of the sepals and petals, in centimeters.

Here's a picture of the three different Iris types:


```python
# The Iris Setosa
from IPython.display import Image
url = 'http://upload.wikimedia.org/wikipedia/commons/5/56/Kosaciec_szczecinkowaty_Iris_setosa.jpg'
Image(url,width=300, height=300)
```



<img src="/assets/images/Python/Course 001/section-020/output_31_0.jpg" width="400">




```python
# The Iris Versicolor
from IPython.display import Image
url = 'http://upload.wikimedia.org/wikipedia/commons/4/41/Iris_versicolor_3.jpg'
Image(url,width=300, height=300)
```



<img src="/assets/images/Python/Course 001/section-020/output_32_0.jpg" width="400">




```python
# The Iris Virginica
from IPython.display import Image
url = 'http://upload.wikimedia.org/wikipedia/commons/9/9f/Iris_virginica.jpg'
Image(url,width=300, height=300)
```



<img src="/assets/images/Python/Course 001/section-020/output_33_0.jpg" width="400">



The iris dataset contains measurements for 150 iris flowers from three different species.

The three classes in the Iris dataset:

    Iris-setosa (n=50)
    Iris-versicolor (n=50)
    Iris-virginica (n=50)

The four features of the Iris dataset:

    sepal length in cm
    sepal width in cm
    petal length in cm
    petal width in cm


```python
# lib
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
%matplotlib inline

from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.metrics import classification_report,confusion_matrix
from sklearn.model_selection import GridSearchCV
```


```python
# df
iris = sns.load_dataset('iris')
iris.head()
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
      <th>sepal_length</th>
      <th>sepal_width</th>
      <th>petal_length</th>
      <th>petal_width</th>
      <th>species</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>5.1</td>
      <td>3.5</td>
      <td>1.4</td>
      <td>0.2</td>
      <td>setosa</td>
    </tr>
    <tr>
      <th>1</th>
      <td>4.9</td>
      <td>3.0</td>
      <td>1.4</td>
      <td>0.2</td>
      <td>setosa</td>
    </tr>
    <tr>
      <th>2</th>
      <td>4.7</td>
      <td>3.2</td>
      <td>1.3</td>
      <td>0.2</td>
      <td>setosa</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4.6</td>
      <td>3.1</td>
      <td>1.5</td>
      <td>0.2</td>
      <td>setosa</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5.0</td>
      <td>3.6</td>
      <td>1.4</td>
      <td>0.2</td>
      <td>setosa</td>
    </tr>
  </tbody>
</table>
</div>



### EDA


```python
iris.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 150 entries, 0 to 149
    Data columns (total 5 columns):
     #   Column        Non-Null Count  Dtype  
    ---  ------        --------------  -----  
     0   sepal_length  150 non-null    float64
     1   sepal_width   150 non-null    float64
     2   petal_length  150 non-null    float64
     3   petal_width   150 non-null    float64
     4   species       150 non-null    object 
    dtypes: float64(4), object(1)
    memory usage: 6.0+ KB



```python
iris.describe()
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
      <th>sepal_length</th>
      <th>sepal_width</th>
      <th>petal_length</th>
      <th>petal_width</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>150.000000</td>
      <td>150.000000</td>
      <td>150.000000</td>
      <td>150.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>5.843333</td>
      <td>3.057333</td>
      <td>3.758000</td>
      <td>1.199333</td>
    </tr>
    <tr>
      <th>std</th>
      <td>0.828066</td>
      <td>0.435866</td>
      <td>1.765298</td>
      <td>0.762238</td>
    </tr>
    <tr>
      <th>min</th>
      <td>4.300000</td>
      <td>2.000000</td>
      <td>1.000000</td>
      <td>0.100000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>5.100000</td>
      <td>2.800000</td>
      <td>1.600000</td>
      <td>0.300000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>5.800000</td>
      <td>3.000000</td>
      <td>4.350000</td>
      <td>1.300000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>6.400000</td>
      <td>3.300000</td>
      <td>5.100000</td>
      <td>1.800000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>7.900000</td>
      <td>4.400000</td>
      <td>6.900000</td>
      <td>2.500000</td>
    </tr>
  </tbody>
</table>
</div>




```python
# pairplot
sns.pairplot(iris,hue='species',diag_kind='hist',diag_kws=dict(edgecolor='black',alpha=0.6),palette='Dark2')
# setosa sembra più separabile
```




    <seaborn.axisgrid.PairGrid at 0x7f2cb4206390>




![png](/assets/images/Python/Course 001/section-020/output_40_1.png)



```python
# kde plot per 'setosa'
setosa = iris[iris['species']=='setosa']
sns.kdeplot(setosa['sepal_width'],setosa['sepal_length'],cmap="plasma",shade=True,shade_lowest=False)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f2cb4363f50>




![png](/assets/images/Python/Course 001/section-020/output_41_1.png)


### Model


```python
# train test set
X = iris.drop('species',axis=1)
y = iris['species']
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.30, random_state=101)
```


```python
# svm
model = SVC()
model.fit(X_train,y_train)

# predictions
predictions = model.predict(X_test)

# metrics
print('\nConfusion Matrix:')
print(confusion_matrix(y_test,predictions))
print('\nClassification metrics:')
print(classification_report(y_test,predictions))
```

    
    Confusion Matrix:
    [[13  0  0]
     [ 0 19  1]
     [ 0  0 12]]
    
    Classification metrics:
                  precision    recall  f1-score   support
    
          setosa       1.00      1.00      1.00        13
      versicolor       1.00      0.95      0.97        20
       virginica       0.92      1.00      0.96        12
    
        accuracy                           0.98        45
       macro avg       0.97      0.98      0.98        45
    weighted avg       0.98      0.98      0.98        45
    



```python
# pulisco il workspace
%reset -f
```


