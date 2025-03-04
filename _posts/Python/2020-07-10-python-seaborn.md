---
title: "Python: Seaborn"
excerpt: "Data Visualization"
date: 2020-07-10
tags: [python]
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

*Versione modulo installato*  
```console
~$ pip show seaborn
Name: seaborn
Version: 0.10.1
Summary: seaborn: statistical data visualization
Home-page: https://seaborn.pydata.org
Author: Michael Waskom
Author-email: mwaskom@nyu.edu
License: BSD (3-clause)
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: scipy, matplotlib, pandas, numpy
Required-by: 
```

# Seaborn

Documentazione [Seaborn](https://seaborn.pydata.org/)


```python
import seaborn as sns
%matplotlib inline
```


```python
tips = sns.load_dataset('tips') # default df in sns
tips.head()
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16.99</td>
      <td>1.01</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10.34</td>
      <td>1.66</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>2</th>
      <td>21.01</td>
      <td>3.50</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>23.68</td>
      <td>3.31</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>24.59</td>
      <td>3.61</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
  </tbody>
</table>
</div>




```python
# dist plot (histogram e kernel density estimation)
sns.distplot(tips['total_bill'],kde=False,bins=30,color='purple')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7ddeea0c50>




![png](/assets/images/Python/Course 001/section-009/output_6_1.png)



```python
# kde plot
sns.kdeplot(tips['total_bill'])
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7de3ca07d0>




![png](/assets/images/Python/Course 001/section-009/output_7_1.png)



```python
# jointplot
sns.jointplot(x='total_bill',y='tip',data=tips,kind='kde') # kind default è scatter, hex è scatterplot esagonali, reg è scatter con regression, kde è 2dimensianl density
# from scipy import stats
# sns.jointplot(x='total_bill',y='tip',data=tips,color='red',marginal_kws=dict(bins=15, rug=True),annot_kws=dict(stat="r"),s=40, edgecolor="black", alpha=0.4, linewidth=1).annotate(stats.pearsonr) # invece di annotate si può mettere dentro il jointplot "stat_func=stats.pearsonr"
```




    <seaborn.axisgrid.JointGrid at 0x7f7de3c96ed0>




![png](/assets/images/Python/Course 001/section-009/output_8_1.png)



```python
# pairplot, come jointplot per tutto il df
sns.pairplot(tips,hue='sex') # hue specifico le categoriche per fare stratificazione
# sns.pairplot(tips,hue='sex',diag_kind='hist',diag_kws=dict(edgecolor='black',alpha=0.6))
```




    <seaborn.axisgrid.PairGrid at 0x7f7de3bfe690>




![png](/assets/images/Python/Course 001/section-009/output_9_1.png)



```python
# rug plot, distribuzione univariata
sns.rugplot(tips['total_bill'])
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7dedf8dad0>




![png](/assets/images/Python/Course 001/section-009/output_10_1.png)



```python
# Don't worry about understanding this code!
# It's just for the diagram below
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

#Create dataset
dataset = np.random.randn(25)

# Create another rugplot
sns.rugplot(dataset);

# Set up the x-axis for the plot
x_min = dataset.min() - 2
x_max = dataset.max() + 2

# 100 equally spaced points from x_min to x_max
x_axis = np.linspace(x_min,x_max,100)

# Set up the bandwidth, for info on this:
url = 'http://en.wikipedia.org/wiki/Kernel_density_estimation#Practical_estimation_of_the_bandwidth'

bandwidth = ((4*dataset.std()**5)/(3*len(dataset)))**.2


# Create an empty kernel list
kernel_list = []

# Plot each basis function
for data_point in dataset:
    
    # Create a kernel for each point and append to list
    kernel = stats.norm(data_point,bandwidth).pdf(x_axis)
    kernel_list.append(kernel)
    
    #Scale for plotting
    kernel = kernel / kernel.max()
    kernel = kernel * .4
    plt.plot(x_axis,kernel,color = 'grey',alpha=0.5)

plt.ylim(0,1)
```




    (0.0, 1.0)




![png](/assets/images/Python/Course 001/section-009/output_11_1.png)



```python
# To get the kde plot we can sum these basis functions.

# Plot the sum of the basis function
sum_of_kde = np.sum(kernel_list,axis=0)

# Plot figure
fig = plt.plot(x_axis,sum_of_kde,color='indianred')

# Add the initial rugplot
sns.rugplot(dataset,c = 'indianred')

# Get rid of y-tick marks
plt.yticks([])

# Set title
plt.suptitle("Sum of the Basis Functions")
```




    Text(0.5, 0.98, 'Sum of the Basis Functions')




![png](/assets/images/Python/Course 001/section-009/output_12_1.png)


## Categorical Plots


```python
import numpy as np
```


```python
# barplot with function
sns.barplot(x='sex',y='total_bill',data=tips,estimator=np.std) # di default l'estimator è la media
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7de1d7cfd0>




![png](/assets/images/Python/Course 001/section-009/output_15_1.png)



```python
# countplot, barplot
sns.countplot(x='sex',data=tips)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7ded503450>




![png](/assets/images/Python/Course 001/section-009/output_16_1.png)



```python
# boxplot
sns.boxplot(x='day',y='total_bill',data=tips,hue='sex') # con hue stratifico
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7de1d530d0>




![png](/assets/images/Python/Course 001/section-009/output_17_1.png)



```python
# violin plot
sns.violinplot(x='day',y='total_bill',data=tips,hue='sex',split=True)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7dec907f90>




![png](/assets/images/Python/Course 001/section-009/output_18_1.png)



```python
# strip plot
sns.stripplot(x='day',y='total_bill',data=tips,hue='sex',jitter=True, split=True) # con jitter migliora la vista delle sovrapposizioni dei punti
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7decc7df90>




![png](/assets/images/Python/Course 001/section-009/output_19_1.png)



```python
# swarplot (combina stripplot con violin plot)
sns.violinplot(x='day',y='total_bill',data=tips,palette='rainbow')
sns.swarmplot(x='day',y='total_bill',data=tips,color='black',alpha=0.5)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7ddf32bb10>




![png](/assets/images/Python/Course 001/section-009/output_20_1.png)



```python
# factor o cat plot
sns.catplot(x='day',y='total_bill',data=tips,kind='bar') # kind puoi usare anche violin, ma è analogo ai singoli comandi
```




    <seaborn.axisgrid.FacetGrid at 0x7f7dec4a5290>




![png](/assets/images/Python/Course 001/section-009/output_21_1.png)


## Matrix Plots


```python
tips = sns.load_dataset('tips')
flights = sns.load_dataset('flights')
```


```python
tips.head()
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
      <th>total_bill</th>
      <th>tip</th>
      <th>sex</th>
      <th>smoker</th>
      <th>day</th>
      <th>time</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>16.99</td>
      <td>1.01</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>1</th>
      <td>10.34</td>
      <td>1.66</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>2</th>
      <td>21.01</td>
      <td>3.50</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>3</td>
    </tr>
    <tr>
      <th>3</th>
      <td>23.68</td>
      <td>3.31</td>
      <td>Male</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>2</td>
    </tr>
    <tr>
      <th>4</th>
      <td>24.59</td>
      <td>3.61</td>
      <td>Female</td>
      <td>No</td>
      <td>Sun</td>
      <td>Dinner</td>
      <td>4</td>
    </tr>
  </tbody>
</table>
</div>




```python
flights.head()
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
      <th>year</th>
      <th>month</th>
      <th>passengers</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1949</td>
      <td>January</td>
      <td>112</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1949</td>
      <td>February</td>
      <td>118</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1949</td>
      <td>March</td>
      <td>132</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1949</td>
      <td>April</td>
      <td>129</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1949</td>
      <td>May</td>
      <td>121</td>
    </tr>
  </tbody>
</table>
</div>




```python
# la heat map necessita la struttura matriciale
tc = tips.corr()
tc
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
      <th>total_bill</th>
      <th>tip</th>
      <th>size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>total_bill</th>
      <td>1.000000</td>
      <td>0.675734</td>
      <td>0.598315</td>
    </tr>
    <tr>
      <th>tip</th>
      <td>0.675734</td>
      <td>1.000000</td>
      <td>0.489299</td>
    </tr>
    <tr>
      <th>size</th>
      <td>0.598315</td>
      <td>0.489299</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>




```python
# heat map
sns.heatmap(tc,annot=True,cmap='coolwarm')
plt.title('tips.corr()')
```




    Text(0.5, 1.0, 'tips.corr()')




![png](/assets/images/Python/Course 001/section-009/output_27_1.png)



```python
# per il df flights la struttura matriciale si può anche costruire rendendo il df wide
fp = flights.pivot_table(index='month',columns='year',values='passengers')
fp
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
      <th>year</th>
      <th>1949</th>
      <th>1950</th>
      <th>1951</th>
      <th>1952</th>
      <th>1953</th>
      <th>1954</th>
      <th>1955</th>
      <th>1956</th>
      <th>1957</th>
      <th>1958</th>
      <th>1959</th>
      <th>1960</th>
    </tr>
    <tr>
      <th>month</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
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
      <th>January</th>
      <td>112</td>
      <td>115</td>
      <td>145</td>
      <td>171</td>
      <td>196</td>
      <td>204</td>
      <td>242</td>
      <td>284</td>
      <td>315</td>
      <td>340</td>
      <td>360</td>
      <td>417</td>
    </tr>
    <tr>
      <th>February</th>
      <td>118</td>
      <td>126</td>
      <td>150</td>
      <td>180</td>
      <td>196</td>
      <td>188</td>
      <td>233</td>
      <td>277</td>
      <td>301</td>
      <td>318</td>
      <td>342</td>
      <td>391</td>
    </tr>
    <tr>
      <th>March</th>
      <td>132</td>
      <td>141</td>
      <td>178</td>
      <td>193</td>
      <td>236</td>
      <td>235</td>
      <td>267</td>
      <td>317</td>
      <td>356</td>
      <td>362</td>
      <td>406</td>
      <td>419</td>
    </tr>
    <tr>
      <th>April</th>
      <td>129</td>
      <td>135</td>
      <td>163</td>
      <td>181</td>
      <td>235</td>
      <td>227</td>
      <td>269</td>
      <td>313</td>
      <td>348</td>
      <td>348</td>
      <td>396</td>
      <td>461</td>
    </tr>
    <tr>
      <th>May</th>
      <td>121</td>
      <td>125</td>
      <td>172</td>
      <td>183</td>
      <td>229</td>
      <td>234</td>
      <td>270</td>
      <td>318</td>
      <td>355</td>
      <td>363</td>
      <td>420</td>
      <td>472</td>
    </tr>
    <tr>
      <th>June</th>
      <td>135</td>
      <td>149</td>
      <td>178</td>
      <td>218</td>
      <td>243</td>
      <td>264</td>
      <td>315</td>
      <td>374</td>
      <td>422</td>
      <td>435</td>
      <td>472</td>
      <td>535</td>
    </tr>
    <tr>
      <th>July</th>
      <td>148</td>
      <td>170</td>
      <td>199</td>
      <td>230</td>
      <td>264</td>
      <td>302</td>
      <td>364</td>
      <td>413</td>
      <td>465</td>
      <td>491</td>
      <td>548</td>
      <td>622</td>
    </tr>
    <tr>
      <th>August</th>
      <td>148</td>
      <td>170</td>
      <td>199</td>
      <td>242</td>
      <td>272</td>
      <td>293</td>
      <td>347</td>
      <td>405</td>
      <td>467</td>
      <td>505</td>
      <td>559</td>
      <td>606</td>
    </tr>
    <tr>
      <th>September</th>
      <td>136</td>
      <td>158</td>
      <td>184</td>
      <td>209</td>
      <td>237</td>
      <td>259</td>
      <td>312</td>
      <td>355</td>
      <td>404</td>
      <td>404</td>
      <td>463</td>
      <td>508</td>
    </tr>
    <tr>
      <th>October</th>
      <td>119</td>
      <td>133</td>
      <td>162</td>
      <td>191</td>
      <td>211</td>
      <td>229</td>
      <td>274</td>
      <td>306</td>
      <td>347</td>
      <td>359</td>
      <td>407</td>
      <td>461</td>
    </tr>
    <tr>
      <th>November</th>
      <td>104</td>
      <td>114</td>
      <td>146</td>
      <td>172</td>
      <td>180</td>
      <td>203</td>
      <td>237</td>
      <td>271</td>
      <td>305</td>
      <td>310</td>
      <td>362</td>
      <td>390</td>
    </tr>
    <tr>
      <th>December</th>
      <td>118</td>
      <td>140</td>
      <td>166</td>
      <td>194</td>
      <td>201</td>
      <td>229</td>
      <td>278</td>
      <td>306</td>
      <td>336</td>
      <td>337</td>
      <td>405</td>
      <td>432</td>
    </tr>
  </tbody>
</table>
</div>




```python
sns.heatmap(fp,cmap='magma',linecolor='white',linewidths=1)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7de7ea59d0>




![png](/assets/images/Python/Course 001/section-009/output_29_1.png)



```python
# cluster map (hierarchical)
sns.clustermap(fp,cmap='coolwarm',standard_scale=1)
```




    <seaborn.matrix.ClusterGrid at 0x7f7de1cf2b10>




![png](/assets/images/Python/Course 001/section-009/output_30_1.png)


## Grids


```python
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




```python
iris['species'].unique()
```




    array(['setosa', 'versicolor', 'virginica'], dtype=object)




```python
sns.pairplot(iris)
```




    <seaborn.axisgrid.PairGrid at 0x7f7de1aed490>




![png](/assets/images/Python/Course 001/section-009/output_34_1.png)



```python
# pairgrid, per personalizzare il pairplot
g = sns.PairGrid(iris)
# g.map(plt.scatter)
g.map_diag(sns.distplot)
g.map_upper(plt.scatter)
g.map_lower(sns.kdeplot)
```




    <seaborn.axisgrid.PairGrid at 0x7f7de1ac7c10>




![png](/assets/images/Python/Course 001/section-009/output_35_1.png)



```python
# facegrid, plot condizionali, mix matplotlib
g = sns.FacetGrid(data=tips,col='time',row='smoker')
# g.map(sns.distplot,'total_bill')
g.map(plt.scatter,'total_bill','tip') # invece di plt.scatter si possono usare altri grafici sia di plt che sns
```




    <seaborn.axisgrid.FacetGrid at 0x7f7de4d73290>




![png](/assets/images/Python/Course 001/section-009/output_36_1.png)


## Regression Plots


```python
# lm plot
sns.lmplot(x='total_bill',y='tip',data=tips,hue='sex',markers=['o','v'],scatter_kws={'s':50}) # scatter_kws per modificare i parametri di matplotlib sottostante tramite dizionario (es s è il size del marker)
# fit_reg=False per lasciare solo lo scatterplot
```




    <seaborn.axisgrid.FacetGrid at 0x7f7de4ad89d0>




![png](/assets/images/Python/Course 001/section-009/output_38_1.png)



```python
# multiplo by categorical
sns.lmplot(x='total_bill',y='tip',data=tips,col='day',row='time',hue='sex',aspect=0.6,height=8)
```




    <seaborn.axisgrid.FacetGrid at 0x7f7de25eaa90>




![png](/assets/images/Python/Course 001/section-009/output_39_1.png)


## Style and Color

Styles
```python
sns.set_style('ticks')
# sns.set_style('whitegrid')
# sns.set_style('darkgrid')
# sns.reset_orig() # resetta style
```


```python
sns.countplot(x='sex',data=tips)
sns.despine(bottom=True)
```


![png](/assets/images/Python/Course 001/section-009/output_41_0.png)



```python
plt.figure(figsize=(12,3))
sns.countplot(x='sex',data=tips)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7ddf8ddc90>




![png](/assets/images/Python/Course 001/section-009/output_42_1.png)



```python
sns.set_context('poster',font_scale=1.2)
sns.countplot(x='sex',data=tips)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7f7de56ed810>




![png](/assets/images/Python/Course 001/section-009/output_43_1.png)


### Palette
[Colors](https://matplotlib.org/3.2.2/gallery/color/colormap_reference.html#sphx-glr-gallery-color-colormap-reference-py)


```python
# sns.set_palette("GnBu_d")
# sns.set_palette("bwr")
```


```python
sns.set_context('notebook')
sns.lmplot(x='total_bill',y='tip',data=tips,hue='sex',palette='seismic')
```




    <seaborn.axisgrid.FacetGrid at 0x7f7ddf3dbf90>




![png](/assets/images/Python/Course 001/section-009/output_45_1.png)


# Altro


```python
# df utile
titanic = sns.load_dataset('titanic')
titanic.head()
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
      <th>survived</th>
      <th>pclass</th>
      <th>sex</th>
      <th>age</th>
      <th>sibsp</th>
      <th>parch</th>
      <th>fare</th>
      <th>embarked</th>
      <th>class</th>
      <th>who</th>
      <th>adult_male</th>
      <th>deck</th>
      <th>embark_town</th>
      <th>alive</th>
      <th>alone</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>3</td>
      <td>male</td>
      <td>22.0</td>
      <td>1</td>
      <td>0</td>
      <td>7.2500</td>
      <td>S</td>
      <td>Third</td>
      <td>man</td>
      <td>True</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>no</td>
      <td>False</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>1</td>
      <td>female</td>
      <td>38.0</td>
      <td>1</td>
      <td>0</td>
      <td>71.2833</td>
      <td>C</td>
      <td>First</td>
      <td>woman</td>
      <td>False</td>
      <td>C</td>
      <td>Cherbourg</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1</td>
      <td>3</td>
      <td>female</td>
      <td>26.0</td>
      <td>0</td>
      <td>0</td>
      <td>7.9250</td>
      <td>S</td>
      <td>Third</td>
      <td>woman</td>
      <td>False</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>True</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1</td>
      <td>1</td>
      <td>female</td>
      <td>35.0</td>
      <td>1</td>
      <td>0</td>
      <td>53.1000</td>
      <td>S</td>
      <td>First</td>
      <td>woman</td>
      <td>False</td>
      <td>C</td>
      <td>Southampton</td>
      <td>yes</td>
      <td>False</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0</td>
      <td>3</td>
      <td>male</td>
      <td>35.0</td>
      <td>0</td>
      <td>0</td>
      <td>8.0500</td>
      <td>S</td>
      <td>Third</td>
      <td>man</td>
      <td>True</td>
      <td>NaN</td>
      <td>Southampton</td>
      <td>no</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>


