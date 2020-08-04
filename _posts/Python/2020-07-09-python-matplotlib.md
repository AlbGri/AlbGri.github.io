---
title: "Python: Matplotlib"
excerpt: "Data Visualization"
date: 2020-07-09
tags: [learning, python, coding]
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
~$ conda deactivate
```

*Versione modulo installato*  
```console
~$ pip show matplotlib
Name: matplotlib
Version: 3.2.2
Summary: Python plotting package
Home-page: https://matplotlib.org
Author: John D. Hunter, Michael Droettboom
Author-email: matplotlib-users@python.org
License: PSF
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: pyparsing, numpy, cycler, kiwisolver, python-dateutil
Required-by: seaborn
```


# Matplotlib

Documentazione [Matplotlib](https://matplotlib.org/gallery.html)  
Documentazione Matplotlib [rougier](https://www.labri.fr/perso/nrougier/teaching/matplotlib)  



```python
import matplotlib.pyplot as plt
import numpy as np
```


```python
# per plottare sul notebook
%matplotlib inline
# per plottare senza notebook
# plt.show()
```


```python
x = np.linspace(0,5,11)
y = x**2
```

## Functional method


```python
plt.plot(x,y, 'r-') # r- red
plt.xlabel('X Label')
plt.ylabel('Y Label')
plt.title('Title')
# plt.show() # non è necessario se si è specificato %matplotlib inline
```




    Text(0.5, 1.0, 'Title')




![png](/assets/images/Python/Course 001/section-008/output_7_1.png)



```python
# multiple plot same canvas
plt.subplot(1,2,1)
plt.plot(x,y,'r-')

plt.subplot(1,2,2) # 1 row, by 2 columns, 2nd plot
plt.plot(y,x,'b')
```




    [<matplotlib.lines.Line2D at 0x7f4e6c5409d0>]




![png](/assets/images/Python/Course 001/section-008/output_8_1.png)


## Object Oriented method


```python
fig = plt.figure()

axes = fig.add_axes([0.1,0.1,0.8,0.8]) # left axsis, bottom, width, height

axes.plot(x,y)
axes.set_xlabel('X Label')
axes.set_ylabel('Y Label')
axes.set_title('Title')
```




    Text(0.5, 1.0, 'Title')




![png](/assets/images/Python/Course 001/section-008/output_10_1.png)



```python
# multi plot
fig = plt.figure()

axes1 = fig.add_axes([0.1,0.1,0.8,0.8])
axes2 = fig.add_axes([0.2,0.5,0.4,0.3])

axes1.plot(x,y)
axes1.set_title('Larger Plot')

axes2.plot(y,x)
axes2.set_title('Smaller Plot')
```




    Text(0.5, 1.0, 'Smaller Plot')




![png](/assets/images/Python/Course 001/section-008/output_11_1.png)


## subplots


```python
fig,axes = plt.subplots(nrows=1,ncols=2)
# axes è un array (list) di due oggetti matplotlib, che potrei iterare
for current_ax in axes:
    current_ax.plot(x,y)
```


![png](/assets/images/Python/Course 001/section-008/output_13_0.png)



```python
# quindi si può lavorare anche sugli index
fig,axes = plt.subplots(nrows=1,ncols=2)

axes[0].plot(x,y)
axes[0].set_title('First Plot')

axes[1].plot(x,y)
axes[1].set_title('Second Plot')

plt.tight_layout() # pulisce le eventuali sovrapposizioni
```


![png](/assets/images/Python/Course 001/section-008/output_14_0.png)


## Figure Size and DPI


```python
fig = plt.figure(figsize=(8,2),dpi=100) # 8 inches

ax = fig.add_axes([0,0,1,1])
ax.plot(x,y)
```




    [<matplotlib.lines.Line2D at 0x7f4e60dc8750>]




![png](/assets/images/Python/Course 001/section-008/output_16_1.png)



```python
fig,axes = plt.subplots(nrows=2,ncols=1,figsize=(8,2),dpi=100) # 8 inches

axes[0].plot(x,y)
axes[1].plot(y,x)

plt.tight_layout()
```


![png](/assets/images/Python/Course 001/section-008/output_17_0.png)



```python
pwd
```




    '/media/user/Public/Python/Course 001'




```python
# salvare plot, png, jpg, svg
fig.savefig('my_picture.png',dpi=200)
```


```python
# legends
fig = plt.figure()

ax = fig.add_axes([0,0,1,1])

ax.plot(x,x**2,label='X Squared')
ax.plot(x,x**3,label='X Cubed')

# per il parametro loc vedi la guida
# https://matplotlib.org/api/pyplot_api.html#matplotlib.pyplot.legend
ax.legend(loc=(0.1,0.1)) # una tupla che specifica la posizione
```




    <matplotlib.legend.Legend at 0x7f4e5bae5950>




![png](/assets/images/Python/Course 001/section-008/output_20_1.png)



```python
# colors, line width, trasparenza
fig = plt.figure()

ax = fig.add_axes([0,0,1,1])

ax.plot(x,y,color='purple',lw=2,alpha=0.5,ls='-.',marker='o',markersize=20,markerfacecolor='red',markeredgewidth=5,markeredgecolor='black') # Color #FF8C00, etc RGB Hex Code; lwd o linewidth; ls o linestyle step, --, :, etc.
```




    [<matplotlib.lines.Line2D at 0x7fa306796610>]




![png](/assets/images/Python/Course 001/section-008/output_21_1.png)



```python
# plot range
fig = plt.figure()

ax = fig.add_axes([0,0,1,1])

ax.plot(x,y,color='purple',lw=2,ls='--')

ax.set_xlim([0,1])
ax.set_ylim([0,2])
```




    (0.0, 2.0)




![png](/assets/images/Python/Course 001/section-008/output_22_1.png)


## Special Plot Types


```python
plt.scatter(x,y)
```




    <matplotlib.collections.PathCollection at 0x7fa305280190>




![png](/assets/images/Python/Course 001/section-008/output_24_1.png)



```python
# scatterplot, histogram, boxplot
```

# Altro


```python
x = np.arange(0,100)
y = x*2
z = x**2
```


```python
fig = plt.figure()

axes1 = fig.add_axes([0,0,1,1])
axes2 = fig.add_axes([0.2,0.5,0.2,0.2])
```


![png](/assets/images/Python/Course 001/section-008/output_28_0.png)



```python
axes1.plot(x,z,color='red', ls='-.', lw=3)
axes1.set_xlabel('x')
axes1.set_ylabel('y')
axes1.set_title('full')

axes2.plot(x,y,color='blue')
axes2.set_xlabel('x')
axes2.set_ylabel('y')
axes2.set_title('zoom')
axes2.set_xlim([20,22])
axes2.set_ylim([30,50])

fig # si può anche richiamare alla fine invece di reinizializzare la fig all'inizio della cella
```




![png](/assets/images/Python/Course 001/section-008/output_29_0.png)


# Matplotlib with Pandas


```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline
```


```python
pwd
```




    '/media/user/Public/Python/Course 001'




```python
df1 = pd.read_csv('df1',index_col=0)
df1.head()
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
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2000-01-01</th>
      <td>1.339091</td>
      <td>-0.163643</td>
      <td>-0.646443</td>
      <td>1.041233</td>
    </tr>
    <tr>
      <th>2000-01-02</th>
      <td>-0.774984</td>
      <td>0.137034</td>
      <td>-0.882716</td>
      <td>-2.253382</td>
    </tr>
    <tr>
      <th>2000-01-03</th>
      <td>-0.921037</td>
      <td>-0.482943</td>
      <td>-0.417100</td>
      <td>0.478638</td>
    </tr>
    <tr>
      <th>2000-01-04</th>
      <td>-1.738808</td>
      <td>-0.072973</td>
      <td>0.056517</td>
      <td>0.015085</td>
    </tr>
    <tr>
      <th>2000-01-05</th>
      <td>-0.905980</td>
      <td>1.778576</td>
      <td>0.381918</td>
      <td>0.291436</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2 = pd.read_csv('df2')
df2.head()
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
      <th>a</th>
      <th>b</th>
      <th>c</th>
      <th>d</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.039762</td>
      <td>0.218517</td>
      <td>0.103423</td>
      <td>0.957904</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.937288</td>
      <td>0.041567</td>
      <td>0.899125</td>
      <td>0.977680</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.780504</td>
      <td>0.008948</td>
      <td>0.557808</td>
      <td>0.797510</td>
    </tr>
    <tr>
      <th>3</th>
      <td>0.672717</td>
      <td>0.247870</td>
      <td>0.264071</td>
      <td>0.444358</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.053829</td>
      <td>0.520124</td>
      <td>0.552264</td>
      <td>0.190008</td>
    </tr>
  </tbody>
</table>
</div>




```python
# histogram
df1['A'].hist(bins=30)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdb58a2b10>




![png](/assets/images/Python/Course 001/section-010/output_8_1.png)



```python
# ggplot style
plt.style.use('ggplot')
df1['A'].plot(kind='hist',bins=30)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdb0856a10>




![png](/assets/images/Python/Course 001/section-010/output_9_1.png)



```python
plt.style.use('fivethirtyeight')
df1['A'].hist(bins=30)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdb032ced0>




![png](/assets/images/Python/Course 001/section-010/output_10_1.png)



```python
plt.style.use('dark_background')
df1['A'].plot.hist(bins=30)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdabfaa710>




![png](/assets/images/Python/Course 001/section-010/output_11_1.png)



```python
# area plot
plt.style.use('bmh')
df2.plot.area(alpha=0.4)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdabb399d0>




![png](/assets/images/Python/Course 001/section-010/output_12_1.png)



```python
# bar plot
df2.plot.bar(stacked=True) # gli index come variabili categoriche
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdabab23d0>




![png](/assets/images/Python/Course 001/section-010/output_13_1.png)



```python
df1.index
```




    Index(['2000-01-01', '2000-01-02', '2000-01-03', '2000-01-04', '2000-01-05',
           '2000-01-06', '2000-01-07', '2000-01-08', '2000-01-09', '2000-01-10',
           ...
           '2002-09-17', '2002-09-18', '2002-09-19', '2002-09-20', '2002-09-21',
           '2002-09-22', '2002-09-23', '2002-09-24', '2002-09-25', '2002-09-26'],
          dtype='object', length=1000)




```python
# line plot
df1.plot.line(y="B",figsize=(12,3),lw=1) # di default prende l'index per le ascisse
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdab89d2d0>




![png](/assets/images/Python/Course 001/section-010/output_15_1.png)



```python
# scatterplot
df1.plot.scatter(x='A',y='B',c='C',cmap='coolwarm')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdab6d9a50>




![png](/assets/images/Python/Course 001/section-010/output_16_1.png)



```python
# scatterplot bubble
df1.plot.scatter(x='A',y='B',s=df1['C']*10)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdab4c3790>




![png](/assets/images/Python/Course 001/section-010/output_17_1.png)



```python
# boxplot
# df2.boxplot()
df2.plot.box() # si può anche specificare by per il gruppo
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdaab90510>




![png](/assets/images/Python/Course 001/section-010/output_18_1.png)



```python
# hexagonal plot
df = pd.DataFrame(np.random.randn(1000,2),columns=['a','b'])
df.head()
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
      <th>a</th>
      <th>b</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.391031</td>
      <td>1.272535</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-0.084391</td>
      <td>0.471284</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3.207212</td>
      <td>-0.404945</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.951644</td>
      <td>-0.234280</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2.843900</td>
      <td>0.860997</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.plot.hexbin(x='a',y='b',gridsize=25,cmap='magma')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdab11a150>




![png](/assets/images/Python/Course 001/section-010/output_20_1.png)



```python
# kernel density estimation
df2['a'].plot.kde()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdab06edd0>




![png](/assets/images/Python/Course 001/section-010/output_21_1.png)



```python
# density
df2.plot.density()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7efdab17a1d0>




![png](/assets/images/Python/Course 001/section-010/output_22_1.png)


# Altro


```python
# legenda esterna
fig = plt.figure()
df2.plot.density(ax=fig.gca())
plt.legend(loc='center left', bbox_to_anchor=(1.0, 0.5))
```




    <matplotlib.legend.Legend at 0x7efdaabaa710>




![png](/assets/images/Python/Course 001/section-010/output_24_1.png)

