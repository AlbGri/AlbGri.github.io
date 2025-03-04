---
title: "Python: NumPy"
excerpt: "Data Analysis"
date: 2020-07-07
tags: [python]
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

*Versione modulo installato*  
```console
~$ pip show numpy
Name: numpy
Version: 1.18.5
Summary: NumPy is the fundamental package for array computing with Python.
Home-page: https://www.numpy.org
Author: Travis E. Oliphant et al.
Author-email: None
License: BSD
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: 
Required-by: seaborn, scipy, pandas, mkl-random, mkl-fft, matplotlib
```


# NumPy


```python
import numpy as np
```


```python
my_list = [1,2,3]
```


```python
# i can cast the list as array
arr = np.array(my_list)
arr
```




    array([1, 2, 3])




```python
# i can cast list of list for 2d array
my_mat = [[1,2,3], [4,5,6], [7,8,9]]
np.array(my_mat)
```




    array([[1, 2, 3],
           [4, 5, 6],
           [7, 8, 9]])




```python
# numpy array range, 5 è all'index 5, 5 è il 6sto elemento dell'array
print(np.arange(0,10))
```

    [0 1 2 3 4 5 6 7 8 9]



```python
np.arange(0,10)[5:]
```




    array([5, 6, 7, 8, 9])




```python
print(np.arange(0,10,2))
```


```python
# vettore di zeri
print(np.zeros(5))
```

    [0. 0. 0. 0. 0.]



```python
# matrice di zeri
print(np.zeros((2,3))) # due dimensioni, due paraentesi quadre
```

    [[0. 0. 0.]
     [0. 0. 0.]]



```python
# vettore di uno
print(np.ones(4))
```

    [1. 1. 1. 1.]



```python
# matrice di uno
print(np.ones((3,4)))
```

    [[1. 1. 1. 1.]
     [1. 1. 1. 1.]
     [1. 1. 1. 1.]]



```python
# sequenza
print(np.linspace(0,5,10))
```

    [0.         0.55555556 1.11111111 1.66666667 2.22222222 2.77777778
     3.33333333 3.88888889 4.44444444 5.        ]



```python
# identity matrix
np.eye(4)
```




    array([[1., 0., 0., 0.],
           [0., 1., 0., 0.],
           [0., 0., 1., 0.],
           [0., 0., 0., 1.]])




```python
# random number
np.random.rand(3)
```




    array([0.4937736 , 0.05355617, 0.15150906])




```python
# random number 2-dimensional (matrix)
np.random.rand(2,3)
```




    array([[0.35877976, 0.77035627, 0.6324609 ],
           [0.65872722, 0.1121614 , 0.21612267]])




```python
# random number da distribuzione normale standard
np.random.randn(2,3)
```




    array([[-0.14430058,  0.68300621, -0.12764066],
           [ 0.44200093, -0.5766826 , -0.84975525]])




```python
# random integer, low incluso, high escluso
np.random.randint(low=1, high=100, size=2)
```




    array([18, 26])




```python
arr = np.arange(25)
arr
```




    array([ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16,
           17, 18, 19, 20, 21, 22, 23, 24])




```python
# reshape da vettore a matrice
arr.reshape(5,5)
```




    array([[ 0,  1,  2,  3,  4],
           [ 5,  6,  7,  8,  9],
           [10, 11, 12, 13, 14],
           [15, 16, 17, 18, 19],
           [20, 21, 22, 23, 24]])




```python
ranarr = np.random.randint(0,50,10)
ranarr
```




    array([11, 29, 47,  1, 33,  7, 10, 32, 28, 33])




```python
print(ranarr.max())    # massimo
print(ranarr.argmax()) # posizione
```

    47
    2



```python
print(ranarr.min())    # minimo
print(ranarr.argmin()) # posizione
```

    1
    3



```python
# dimensione struttura numpy
print(arr.shape)
print(arr.reshape(5,5).shape)
```

    (25,)
    (5, 5)



```python
# data type
arr.dtype
```




    dtype('int32')




```python
# import specifica funzione dalla libreria
from numpy.random import randint
```


```python
randint(2,10)
```




    7



## Indexing and Selection


```python
import numpy as np
```


```python
arr = np.arange(0,11)
arr
```




    array([ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10])




```python
# bracket and slice notation to filter, come le liste
print(arr[8])   # index 8
print(arr[1:5]) # slite notation
print(arr[0:5])
print(arr[:5])  # lo zero si può omettere, come anche l'ultimo elemento se lo si volesse raggiungere
print(arr[5:])
```

    8
    [1 2 3 4]
    [0 1 2 3 4]
    [0 1 2 3 4]
    [ 5  6  7  8  9 10]



```python
# broadcast a value
arr[0:5] = 100
print(arr)
```

    [100 100 100 100 100   5   6   7   8   9  10]



```python
# puntamenti, reference, non è una copia
arr = np.arange(0,11)
print(arr)
slice_of_arr = arr[0:6]
print(slice_of_arr)
```

    [ 0  1  2  3  4  5  6  7  8  9 10]
    [0 1 2 3 4 5]



```python
slice_of_arr[:] = 99  # se non uso [:] lo trasforma in scalare
print(slice_of_arr)
print(arr)
```

    [99 99 99 99 99 99]
    [99 99 99 99 99 99  6  7  8  9 10]



```python
# per creare una copia
arr_copy = arr.copy()
print(arr)
arr_copy[:] = 100
print(arr_copy)
print(arr)
```

    [99 99 99 99 99 99  6  7  8  9 10]
    [100 100 100 100 100 100 100 100 100 100 100]
    [99 99 99 99 99 99  6  7  8  9 10]



```python
arr_2d = np.array([[5,10,15], [20,25,30], [30,40,45]])
print(arr_2d) # 2 dimensional matrix
```

    [[ 5 10 15]
     [20 25 30]
     [30 40 45]]



```python
print(arr_2d[0])    # filtro record 1
print(arr_2d[0][0]) # filtro elemento 1, 1
print(arr_2d[0,0])  # filtro elemento 1, 1
```

    [ 5 10 15]
    5
    5



```python
print(arr_2d[:2]) # estrae riga 0 e 1
```


```python
# grab ":" everything, up to row 2 "2", and then "," grab from column 1 "1" onwards ":"
print(arr_2d[:2,1:])
```

    [[10 15]
     [25 30]]



```python
arr_2d[:3,0]    # è 1-dimensional
```




    array([ 5, 20, 30])




```python
arr_2d[:3,0:1]  # è 2-dimensional
```




    array([[ 0],
           [10],
           [20]])




```python
arr_2d[:3,:1]
```




    array([[ 5],
           [20],
           [30]])




```python
# conditional selection
arr = np.arange(1,11)
print(arr)
```

    [ 1  2  3  4  5  6  7  8  9 10]



```python
bool_arr = arr > 5
print(bool_arr)
print(arr[bool_arr]) # idexing con conditional selection
```

    [False False False False False  True  True  True  True  True]
    [ 6  7  8  9 10]



```python
arr_2d = np.arange(50).reshape(5,10)
print(arr_2d)
```

    [[ 0  1  2  3  4  5  6  7  8  9]
     [10 11 12 13 14 15 16 17 18 19]
     [20 21 22 23 24 25 26 27 28 29]
     [30 31 32 33 34 35 36 37 38 39]
     [40 41 42 43 44 45 46 47 48 49]]



```python
arr_2d[1:3,:]
```




    array([[10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
           [20, 21, 22, 23, 24, 25, 26, 27, 28, 29]])




```python
arr_2d[:,3:5]
```




    array([[ 3,  4],
           [13, 14],
           [23, 24],
           [33, 34],
           [43, 44]])




```python
arr_2d[1:3,3:5]
```




    array([[13, 14],
           [23, 24]])



## NumPy Operations


```python
import numpy as np
```


```python
# Universal Array Functions
```


```python
# Array with Array
arr = np.arange(0,11)
print(arr)
print(arr + arr)
print(arr - arr)
print(arr * arr)
```

    [ 0  1  2  3  4  5  6  7  8  9 10]
    [ 0  2  4  6  8 10 12 14 16 18 20]
    [0 0 0 0 0 0 0 0 0 0 0]
    [  0   1   4   9  16  25  36  49  64  81 100]



```python
# Array with Scalars
print(arr + 100) # it broadcasts to every element of the array
```

    [100 101 102 103 104 105 106 107 108 109 110]



```python
# warning con numpy
arr / arr
```

    C:\Users\user\miniconda3\lib\site-packages\ipykernel_launcher.py:1: RuntimeWarning: invalid value encountered in true_divide
      """Entry point for launching an IPython kernel.





    array([nan,  1.,  1.,  1.,  1.,  1.,  1.,  1.,  1.,  1.,  1.])




```python
1 / arr
```

    C:\Users\user\miniconda3\lib\site-packages\ipykernel_launcher.py:1: RuntimeWarning: divide by zero encountered in true_divide
      """Entry point for launching an IPython kernel.





    array([       inf, 1.        , 0.5       , 0.33333333, 0.25      ,
           0.2       , 0.16666667, 0.14285714, 0.125     , 0.11111111,
           0.1       ])




```python
print(np.max(arr) == arr.max())
```

    True



```python
# Universal fucntion
# https://numpy.org/doc/stable/reference/ufuncs.html
print(np.sqrt(arr)) # sqrt, exp, sin, log
```

    [0.         1.         1.41421356 1.73205081 2.         2.23606798
     2.44948974 2.64575131 2.82842712 3.         3.16227766]


# Altro


```python
mat = np.arange(1,26).reshape(5,5)
mat
```




    array([[ 1,  2,  3,  4,  5],
           [ 6,  7,  8,  9, 10],
           [11, 12, 13, 14, 15],
           [16, 17, 18, 19, 20],
           [21, 22, 23, 24, 25]])




```python
# list comprehension
np.array([mat[:,i].sum() for i in range(0,5)])
```




    array([55, 60, 65, 70, 75])




```python
mat.sum(axis=0)
```




    array([55, 60, 65, 70, 75])


