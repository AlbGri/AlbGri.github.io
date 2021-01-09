---
title: "Python: Principal Component Analysis"
excerpt: "Machine Learning"
date: 2020-07-23
tags: [python, ml]
mathjax: "true"

---
*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

# PCA

<img src="/assets/images/Python/Course 001/section-022/001-PCA.png" width="400">

<img src="/assets/images/Python/Course 001/section-022/002-PCA.png" width="400">


```python
# lib
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import seaborn as sns
%matplotlib inline

from sklearn.datasets import load_breast_cancer
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
```


```python
# cancer data
cancer = load_breast_cancer()
cancer.keys()
```




    dict_keys(['data', 'target', 'frame', 'target_names', 'DESCR', 'feature_names', 'filename'])




```python
# df
df = pd.DataFrame(cancer['data'],columns=cancer['feature_names'])
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
      <th>mean radius</th>
      <th>mean texture</th>
      <th>mean perimeter</th>
      <th>mean area</th>
      <th>mean smoothness</th>
      <th>mean compactness</th>
      <th>mean concavity</th>
      <th>mean concave points</th>
      <th>mean symmetry</th>
      <th>mean fractal dimension</th>
      <th>...</th>
      <th>worst radius</th>
      <th>worst texture</th>
      <th>worst perimeter</th>
      <th>worst area</th>
      <th>worst smoothness</th>
      <th>worst compactness</th>
      <th>worst concavity</th>
      <th>worst concave points</th>
      <th>worst symmetry</th>
      <th>worst fractal dimension</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>17.99</td>
      <td>10.38</td>
      <td>122.80</td>
      <td>1001.0</td>
      <td>0.11840</td>
      <td>0.27760</td>
      <td>0.3001</td>
      <td>0.14710</td>
      <td>0.2419</td>
      <td>0.07871</td>
      <td>...</td>
      <td>25.38</td>
      <td>17.33</td>
      <td>184.60</td>
      <td>2019.0</td>
      <td>0.1622</td>
      <td>0.6656</td>
      <td>0.7119</td>
      <td>0.2654</td>
      <td>0.4601</td>
      <td>0.11890</td>
    </tr>
    <tr>
      <th>1</th>
      <td>20.57</td>
      <td>17.77</td>
      <td>132.90</td>
      <td>1326.0</td>
      <td>0.08474</td>
      <td>0.07864</td>
      <td>0.0869</td>
      <td>0.07017</td>
      <td>0.1812</td>
      <td>0.05667</td>
      <td>...</td>
      <td>24.99</td>
      <td>23.41</td>
      <td>158.80</td>
      <td>1956.0</td>
      <td>0.1238</td>
      <td>0.1866</td>
      <td>0.2416</td>
      <td>0.1860</td>
      <td>0.2750</td>
      <td>0.08902</td>
    </tr>
    <tr>
      <th>2</th>
      <td>19.69</td>
      <td>21.25</td>
      <td>130.00</td>
      <td>1203.0</td>
      <td>0.10960</td>
      <td>0.15990</td>
      <td>0.1974</td>
      <td>0.12790</td>
      <td>0.2069</td>
      <td>0.05999</td>
      <td>...</td>
      <td>23.57</td>
      <td>25.53</td>
      <td>152.50</td>
      <td>1709.0</td>
      <td>0.1444</td>
      <td>0.4245</td>
      <td>0.4504</td>
      <td>0.2430</td>
      <td>0.3613</td>
      <td>0.08758</td>
    </tr>
    <tr>
      <th>3</th>
      <td>11.42</td>
      <td>20.38</td>
      <td>77.58</td>
      <td>386.1</td>
      <td>0.14250</td>
      <td>0.28390</td>
      <td>0.2414</td>
      <td>0.10520</td>
      <td>0.2597</td>
      <td>0.09744</td>
      <td>...</td>
      <td>14.91</td>
      <td>26.50</td>
      <td>98.87</td>
      <td>567.7</td>
      <td>0.2098</td>
      <td>0.8663</td>
      <td>0.6869</td>
      <td>0.2575</td>
      <td>0.6638</td>
      <td>0.17300</td>
    </tr>
    <tr>
      <th>4</th>
      <td>20.29</td>
      <td>14.34</td>
      <td>135.10</td>
      <td>1297.0</td>
      <td>0.10030</td>
      <td>0.13280</td>
      <td>0.1980</td>
      <td>0.10430</td>
      <td>0.1809</td>
      <td>0.05883</td>
      <td>...</td>
      <td>22.54</td>
      <td>16.67</td>
      <td>152.20</td>
      <td>1575.0</td>
      <td>0.1374</td>
      <td>0.2050</td>
      <td>0.4000</td>
      <td>0.1625</td>
      <td>0.2364</td>
      <td>0.07678</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 30 columns</p>
</div>




```python
# scaling data
scaler = StandardScaler()
scaler.fit(df)
scaled_data = scaler.transform(df)
```


```python
# PCA
pca = PCA(n_components=2)
pca.fit(scaled_data)
```




    PCA(n_components=2)




```python
# trasform data to two components (da 30 colonne a 2)
x_pca = pca.transform(scaled_data)
```


```python
print(scaled_data.shape)
print(x_pca.shape)
```

    (569, 30)
    (569, 2)



```python
# plot PCA
plt.figure(figsize=(8,6))
plt.scatter(x_pca[:,0],x_pca[:,1],c=cancer['target'],cmap='plasma',edgecolors='black',alpha=0.5)
plt.xlabel('First principal component')
plt.ylabel('Second Principal Component')
```




    Text(0, 0.5, 'Second Principal Component')




![png](/assets/images/Python/Course 001/section-022/output_13_1.png)


## Coefficients


```python
# interpretazioni coefficienti
# correlazione tra le variabili e le componenti
df_comp = pd.DataFrame(pca.components_,columns=cancer['feature_names'])
df_comp.head()
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
      <th>mean radius</th>
      <th>mean texture</th>
      <th>mean perimeter</th>
      <th>mean area</th>
      <th>mean smoothness</th>
      <th>mean compactness</th>
      <th>mean concavity</th>
      <th>mean concave points</th>
      <th>mean symmetry</th>
      <th>mean fractal dimension</th>
      <th>...</th>
      <th>worst radius</th>
      <th>worst texture</th>
      <th>worst perimeter</th>
      <th>worst area</th>
      <th>worst smoothness</th>
      <th>worst compactness</th>
      <th>worst concavity</th>
      <th>worst concave points</th>
      <th>worst symmetry</th>
      <th>worst fractal dimension</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0.218902</td>
      <td>0.103725</td>
      <td>0.227537</td>
      <td>0.220995</td>
      <td>0.142590</td>
      <td>0.239285</td>
      <td>0.258400</td>
      <td>0.260854</td>
      <td>0.138167</td>
      <td>0.064363</td>
      <td>...</td>
      <td>0.227997</td>
      <td>0.104469</td>
      <td>0.236640</td>
      <td>0.224871</td>
      <td>0.127953</td>
      <td>0.210096</td>
      <td>0.228768</td>
      <td>0.250886</td>
      <td>0.122905</td>
      <td>0.131784</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-0.233857</td>
      <td>-0.059706</td>
      <td>-0.215181</td>
      <td>-0.231077</td>
      <td>0.186113</td>
      <td>0.151892</td>
      <td>0.060165</td>
      <td>-0.034768</td>
      <td>0.190349</td>
      <td>0.366575</td>
      <td>...</td>
      <td>-0.219866</td>
      <td>-0.045467</td>
      <td>-0.199878</td>
      <td>-0.219352</td>
      <td>0.172304</td>
      <td>0.143593</td>
      <td>0.097964</td>
      <td>-0.008257</td>
      <td>0.141883</td>
      <td>0.275339</td>
    </tr>
  </tbody>
</table>
<p>2 rows × 30 columns</p>
</div>




```python
# heatmap
plt.figure(figsize=(12,6))
sns.heatmap(df_comp,cmap='plasma')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7fee706d6d50>




![png](/assets/images/Python/Course 001/section-022/output_16_1.png)


## Biplot


```python
# il biplot è la rappresentazione grafica delle due prime componenti
# utile anche per identificare gli outliers

# funzione per il biplot
def biplot(score,coeff,y=None,labels=None):
    xs = score[:,0] # projection of PC1
    ys = score[:,1] # projection of PC2
    n = coeff.shape[0]
    scalex = 1.0/(xs.max() - xs.min())
    scaley = 1.0/(ys.max() - ys.min())
    plt.scatter(xs * scalex,ys * scaley, c = y)
    
    # aggiungo frecce
    for i in range(n):
        plt.arrow(0, 0, coeff[i,0], coeff[i,1],color = 'r',alpha = 0.5)
        if labels is None:
            plt.text(coeff[i,0]* 1.15, coeff[i,1] * 1.15, "Var"+str(i+1), color = 'g', ha = 'center', va = 'center')
        else:
            plt.text(coeff[i,0]* 1.15, coeff[i,1] * 1.15, labels[i], color = 'g', ha = 'center', va = 'center')

    # aggiungo flag outliers
    for i in range(len(xs)):
        if ((xs[i]>np.quantile(xs,0.99)) | (ys[i]>np.quantile(xs,0.99))):
            plt.text(xs[i] * scalex,ys[i] * scaley, str(i))

    # etichette
    plt.xlabel("PC{}".format(1), size=14)
    plt.ylabel("PC{}".format(2), size=14)
    plt.grid()
    plt.tick_params(axis='both', which='both', labelsize=14)
    plt.tight_layout()
```


```python
# plot
plt.figure(figsize=(10,8))
biplot(score=x_pca,coeff=np.transpose(pca.components_),labels=df.columns)

# se ci fossero più componenti plotto solo le prime due (nb. sono array non dataframes)
# score=x_pca[:,0:2],coef=np.transpose(pca.components_[0:2, :])

# le variabili nella stessa direzione sono correlate
```


![png](/assets/images/Python/Course 001/section-022/output_19_0.png)



```python
# esempio stessa direzione
np.corrcoef(df['worst perimeter'],df['mean perimeter'])[1,0]
```




    0.9703868870426392



### Outliers


```python
# l'osservazione 461 è outliers per la prima componente, che ha coefficienti positivi verso le variabili 
# infatti i valori delle sue variabili sono vicini ai massimi (vedi il describe)
x_pca[461,]
```




    array([16.31923323, -7.7758528 ])




```python
# l'osservazione 152 è outliers per la seconda componente
# la PC2 ha coefficienti negativi verso le variabili tranne per 'mean fractal dimension'
# infatti i valori delle sue variabili sono vicini ai minimi, tranne per 'mean fractal dimension' che è elevata
x_pca[152,]
```




    array([ 7.09330671, 12.57319423])




```python
# describe stats assieme a due outliers
pd.concat([df.describe(),df.iloc[[461,152]]],axis=0)
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
      <th>mean radius</th>
      <th>mean texture</th>
      <th>mean perimeter</th>
      <th>mean area</th>
      <th>mean smoothness</th>
      <th>mean compactness</th>
      <th>mean concavity</th>
      <th>mean concave points</th>
      <th>mean symmetry</th>
      <th>mean fractal dimension</th>
      <th>...</th>
      <th>worst radius</th>
      <th>worst texture</th>
      <th>worst perimeter</th>
      <th>worst area</th>
      <th>worst smoothness</th>
      <th>worst compactness</th>
      <th>worst concavity</th>
      <th>worst concave points</th>
      <th>worst symmetry</th>
      <th>worst fractal dimension</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>...</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
      <td>569.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>14.127292</td>
      <td>19.289649</td>
      <td>91.969033</td>
      <td>654.889104</td>
      <td>0.096360</td>
      <td>0.104341</td>
      <td>0.088799</td>
      <td>0.048919</td>
      <td>0.181162</td>
      <td>0.062798</td>
      <td>...</td>
      <td>16.269190</td>
      <td>25.677223</td>
      <td>107.261213</td>
      <td>880.583128</td>
      <td>0.132369</td>
      <td>0.254265</td>
      <td>0.272188</td>
      <td>0.114606</td>
      <td>0.290076</td>
      <td>0.083946</td>
    </tr>
    <tr>
      <th>std</th>
      <td>3.524049</td>
      <td>4.301036</td>
      <td>24.298981</td>
      <td>351.914129</td>
      <td>0.014064</td>
      <td>0.052813</td>
      <td>0.079720</td>
      <td>0.038803</td>
      <td>0.027414</td>
      <td>0.007060</td>
      <td>...</td>
      <td>4.833242</td>
      <td>6.146258</td>
      <td>33.602542</td>
      <td>569.356993</td>
      <td>0.022832</td>
      <td>0.157336</td>
      <td>0.208624</td>
      <td>0.065732</td>
      <td>0.061867</td>
      <td>0.018061</td>
    </tr>
    <tr>
      <th>min</th>
      <td>6.981000</td>
      <td>9.710000</td>
      <td>43.790000</td>
      <td>143.500000</td>
      <td>0.052630</td>
      <td>0.019380</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.106000</td>
      <td>0.049960</td>
      <td>...</td>
      <td>7.930000</td>
      <td>12.020000</td>
      <td>50.410000</td>
      <td>185.200000</td>
      <td>0.071170</td>
      <td>0.027290</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.156500</td>
      <td>0.055040</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>11.700000</td>
      <td>16.170000</td>
      <td>75.170000</td>
      <td>420.300000</td>
      <td>0.086370</td>
      <td>0.064920</td>
      <td>0.029560</td>
      <td>0.020310</td>
      <td>0.161900</td>
      <td>0.057700</td>
      <td>...</td>
      <td>13.010000</td>
      <td>21.080000</td>
      <td>84.110000</td>
      <td>515.300000</td>
      <td>0.116600</td>
      <td>0.147200</td>
      <td>0.114500</td>
      <td>0.064930</td>
      <td>0.250400</td>
      <td>0.071460</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>13.370000</td>
      <td>18.840000</td>
      <td>86.240000</td>
      <td>551.100000</td>
      <td>0.095870</td>
      <td>0.092630</td>
      <td>0.061540</td>
      <td>0.033500</td>
      <td>0.179200</td>
      <td>0.061540</td>
      <td>...</td>
      <td>14.970000</td>
      <td>25.410000</td>
      <td>97.660000</td>
      <td>686.500000</td>
      <td>0.131300</td>
      <td>0.211900</td>
      <td>0.226700</td>
      <td>0.099930</td>
      <td>0.282200</td>
      <td>0.080040</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>15.780000</td>
      <td>21.800000</td>
      <td>104.100000</td>
      <td>782.700000</td>
      <td>0.105300</td>
      <td>0.130400</td>
      <td>0.130700</td>
      <td>0.074000</td>
      <td>0.195700</td>
      <td>0.066120</td>
      <td>...</td>
      <td>18.790000</td>
      <td>29.720000</td>
      <td>125.400000</td>
      <td>1084.000000</td>
      <td>0.146000</td>
      <td>0.339100</td>
      <td>0.382900</td>
      <td>0.161400</td>
      <td>0.317900</td>
      <td>0.092080</td>
    </tr>
    <tr>
      <th>max</th>
      <td>28.110000</td>
      <td>39.280000</td>
      <td>188.500000</td>
      <td>2501.000000</td>
      <td>0.163400</td>
      <td>0.345400</td>
      <td>0.426800</td>
      <td>0.201200</td>
      <td>0.304000</td>
      <td>0.097440</td>
      <td>...</td>
      <td>36.040000</td>
      <td>49.540000</td>
      <td>251.200000</td>
      <td>4254.000000</td>
      <td>0.222600</td>
      <td>1.058000</td>
      <td>1.252000</td>
      <td>0.291000</td>
      <td>0.663800</td>
      <td>0.207500</td>
    </tr>
    <tr>
      <th>461</th>
      <td>27.420000</td>
      <td>26.270000</td>
      <td>186.900000</td>
      <td>2501.000000</td>
      <td>0.108400</td>
      <td>0.198800</td>
      <td>0.363500</td>
      <td>0.168900</td>
      <td>0.206100</td>
      <td>0.056230</td>
      <td>...</td>
      <td>36.040000</td>
      <td>31.370000</td>
      <td>251.200000</td>
      <td>4254.000000</td>
      <td>0.135700</td>
      <td>0.425600</td>
      <td>0.683300</td>
      <td>0.262500</td>
      <td>0.264100</td>
      <td>0.074270</td>
    </tr>
    <tr>
      <th>152</th>
      <td>9.731000</td>
      <td>15.340000</td>
      <td>63.780000</td>
      <td>300.200000</td>
      <td>0.107200</td>
      <td>0.159900</td>
      <td>0.410800</td>
      <td>0.078570</td>
      <td>0.254800</td>
      <td>0.092960</td>
      <td>...</td>
      <td>11.020000</td>
      <td>19.490000</td>
      <td>71.040000</td>
      <td>380.500000</td>
      <td>0.129200</td>
      <td>0.277200</td>
      <td>0.821600</td>
      <td>0.157100</td>
      <td>0.310800</td>
      <td>0.125900</td>
    </tr>
  </tbody>
</table>
<p>10 rows × 30 columns</p>
</div>




```python
# pulisco il workspace
%reset -f
```
