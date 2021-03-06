---
title: "Python: Plotly and Cufflinks"
excerpt: "Data Visualization"
date: 2020-07-11
tags: [python]
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

*Versione moduli installati*  
```console
~$ pip show Plotly
Name: plotly
Version: 4.8.2
Summary: An open-source, interactive data visualization library for Python
Home-page: https://plotly.com/python/
Author: Chris P
Author-email: chris@plot.ly
License: MIT
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: retrying, six
Required-by: 
```

```console
~$ pip show Cufflinks
Name: cufflinks
Version: 0.17.3
Summary: Productivity Tools for Plotly + Pandas
Home-page: https://github.com/santosjorge/cufflinks
Author: Jorge Santos
Author-email: santos.jorge@gmail.com
License: MIT
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: six, numpy, ipython, ipywidgets, pandas, setuptools, colorlover, plotly
Required-by: 
```

# Plotly and Cufflinks

**Per ottenere i grafici interattivi lanciare il codice in locale.**  
Non sono riuscito ad esportarli via web con Markdown.  

Documentazione [Plotly](https://plot.ly/python/getting-started)  
Documentazione [Cufflinks](https://github.com/santosjorge/cufflinks)  
Documentazione Cufflinks su [Technical Analysis](https://github.com/santosjorge/cufflinks/blob/master/cufflinks/ta.py) (Moving Averages, etc)


```python
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
import cufflinks as cf
```


```python
# For Notebooks
init_notebook_mode(connected=True)
```


<script type="text/javascript">
window.PlotlyConfig = {MathJaxConfig: 'local'};
if (window.MathJax) {MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}
if (typeof require !== 'undefined') {
require.undef("plotly");
requirejs.config({
    paths: {
        'plotly': ['https://cdn.plot.ly/plotly-latest.min']
    }
});
require(['plotly'], function(Plotly) {
    window._Plotly = Plotly;
});
}
</script>




```python
# For offline use
cf.go_offline()
```


<script type="text/javascript">
window.PlotlyConfig = {MathJaxConfig: 'local'};
if (window.MathJax) {MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}
if (typeof require !== 'undefined') {
require.undef("plotly");
requirejs.config({
    paths: {
        'plotly': ['https://cdn.plot.ly/plotly-latest.min']
    }
});
require(['plotly'], function(Plotly) {
    window._Plotly = Plotly;
});
}
</script>



## Plots


```python
df = pd.DataFrame(np.random.randn(100,4),columns='A B C D'.split())
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
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>-0.856764</td>
      <td>-0.678908</td>
      <td>-0.360994</td>
      <td>-0.850973</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.708704</td>
      <td>1.740536</td>
      <td>-0.427867</td>
      <td>-0.964683</td>
    </tr>
    <tr>
      <th>2</th>
      <td>-0.165188</td>
      <td>-0.798954</td>
      <td>0.756708</td>
      <td>-0.717790</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2.211182</td>
      <td>-1.551565</td>
      <td>0.315461</td>
      <td>0.070881</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1.633826</td>
      <td>0.205886</td>
      <td>-1.986120</td>
      <td>0.017801</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2 = pd.DataFrame({'Category':['A','B','C'],'Values':[32,43,50]})
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
      <th>Category</th>
      <th>Values</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>A</td>
      <td>32</td>
    </tr>
    <tr>
      <th>1</th>
      <td>B</td>
      <td>43</td>
    </tr>
    <tr>
      <th>2</th>
      <td>C</td>
      <td>50</td>
    </tr>
  </tbody>
</table>
</div>




```python
# matplotlib plot
df.plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f2e014fdbd0>




![png](/assets/images/Python/Course 001/section-011/output_14_1.png)


```python
# iplot plot
df.iplot()
# dopo lo zoom per tornare al size originale basta doppio click
```

```python
# scatterplot
df.iplot(kind='scatter',x='A',y='B',mode='markers',size=10)
```

```python
# barplot
df2.iplot(kind='bar',x='Category',y='Values')
```

```python
# barplot con funzione
df.sum().iplot(kind='bar') # sum(), mean(), count(), etc
```

```python
# boxplot
df.iplot(kind='box')
```


```python
df3 = pd.DataFrame({'x':[1,2,3,4,5],'y':[10,20,30,20,10],'z':[5,4,3,2,1]})
df3.head()
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
      <th>x</th>
      <th>y</th>
      <th>z</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>10</td>
      <td>5</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>20</td>
      <td>4</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>30</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>20</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>10</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>



```python
# 3d surface
df3.iplot(kind='surface',colorscale='rdylbu')
```

```python
# spread plot
df[['A','B']].iplot(kind='spread')
# non hanno ancora rimosso 'pandas.np' da pandas e va in conflitto con numpy
```

```console
/home/user/miniconda3/envs/py3/lib/python3.7/site-packages/cufflinks/plotlytools.py:849: FutureWarning:

The pandas.np module is deprecated and will be removed from pandas in a future version. Import numpy directly instead

/home/user/miniconda3/envs/py3/lib/python3.7/site-packages/cufflinks/plotlytools.py:850: FutureWarning:

The pandas.np module is deprecated and will be removed from pandas in a future version. Import numpy directly instead
```

```python
# histogram
df['A'].iplot(kind='hist',bins=25)
```

```python
# multiple histogram
df.iplot(kind='hist',bins=25)
```

```python
# bubble plot
df.iplot(kind='bubble',x='A',y='B',size='C')
```

```python
# scatter matrix
df.scatter_matrix()
```
