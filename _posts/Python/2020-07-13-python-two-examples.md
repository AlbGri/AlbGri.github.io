---
title: "Python: two examples"
excerpt: "Exploratory Data Analysis -- 911 Calls and Finance datasets"
date: 2020-07-13
tags: [python, finance]
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

*Versione modulo installato*  
```console
~$ pip show pandas_datareader
Name: pandas-datareader
Version: 0.9.0
Summary: Data readers extracted from the pandas codebase,should be compatible with recent pandas versions
Home-page: https://github.com/pydata/pandas-datareader
Author: The PyData Development Team
Author-email: pydata@googlegroups.com
License: BSD License
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: requests, pandas, lxml
Required-by: 
```

# Indice

Due laboratori
1. [911 Calls Project](https://www.albgri.com/python-two-examples/#911-calls-project)
2. [Finance Project](https://www.albgri.com/python-two-examples/#finance-project)

# 911 Calls Project

Kaggle [data](https://www.kaggle.com/mchirico/montcoalert)


```python
import numpy as np
import pandas as pd

import matplotlib.pyplot as plt
import seaborn as sns

%matplotlib inline
```


```python
# import df
df = pd.read_csv('911.csv')
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
      <th>lat</th>
      <th>lng</th>
      <th>desc</th>
      <th>zip</th>
      <th>title</th>
      <th>timeStamp</th>
      <th>twp</th>
      <th>addr</th>
      <th>e</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>40.297876</td>
      <td>-75.581294</td>
      <td>REINDEER CT &amp; DEAD END;  NEW HANOVER; Station ...</td>
      <td>19525.0</td>
      <td>EMS: BACK PAINS/INJURY</td>
      <td>2015-12-10 17:40:00</td>
      <td>NEW HANOVER</td>
      <td>REINDEER CT &amp; DEAD END</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>40.258061</td>
      <td>-75.264680</td>
      <td>BRIAR PATH &amp; WHITEMARSH LN;  HATFIELD TOWNSHIP...</td>
      <td>19446.0</td>
      <td>EMS: DIABETIC EMERGENCY</td>
      <td>2015-12-10 17:40:00</td>
      <td>HATFIELD TOWNSHIP</td>
      <td>BRIAR PATH &amp; WHITEMARSH LN</td>
      <td>1</td>
    </tr>
    <tr>
      <th>2</th>
      <td>40.121182</td>
      <td>-75.351975</td>
      <td>HAWS AVE; NORRISTOWN; 2015-12-10 @ 14:39:21-St...</td>
      <td>19401.0</td>
      <td>Fire: GAS-ODOR/LEAK</td>
      <td>2015-12-10 17:40:00</td>
      <td>NORRISTOWN</td>
      <td>HAWS AVE</td>
      <td>1</td>
    </tr>
    <tr>
      <th>3</th>
      <td>40.116153</td>
      <td>-75.343513</td>
      <td>AIRY ST &amp; SWEDE ST;  NORRISTOWN; Station 308A;...</td>
      <td>19401.0</td>
      <td>EMS: CARDIAC EMERGENCY</td>
      <td>2015-12-10 17:40:01</td>
      <td>NORRISTOWN</td>
      <td>AIRY ST &amp; SWEDE ST</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>40.251492</td>
      <td>-75.603350</td>
      <td>CHERRYWOOD CT &amp; DEAD END;  LOWER POTTSGROVE; S...</td>
      <td>NaN</td>
      <td>EMS: DIZZINESS</td>
      <td>2015-12-10 17:40:01</td>
      <td>LOWER POTTSGROVE</td>
      <td>CHERRYWOOD CT &amp; DEAD END</td>
      <td>1</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 99492 entries, 0 to 99491
    Data columns (total 9 columns):
     #   Column     Non-Null Count  Dtype  
    ---  ------     --------------  -----  
     0   lat        99492 non-null  float64
     1   lng        99492 non-null  float64
     2   desc       99492 non-null  object 
     3   zip        86637 non-null  float64
     4   title      99492 non-null  object 
     5   timeStamp  99492 non-null  object 
     6   twp        99449 non-null  object 
     7   addr       98973 non-null  object 
     8   e          99492 non-null  int64  
    dtypes: float64(3), int64(1), object(5)
    memory usage: 6.8+ MB



```python
# top 5 zipcode for 911 cals
df['zip'].value_counts().head()
```




    19401.0    6979
    19464.0    6643
    19403.0    4854
    19446.0    4748
    19406.0    3174
    Name: zip, dtype: int64




```python
# top 5 townships (twp) for 911 calls
df['twp'].value_counts().head()
```




    LOWER MERION    8443
    ABINGTON        5977
    NORRISTOWN      5890
    UPPER MERION    5227
    CHELTENHAM      4575
    Name: twp, dtype: int64




```python
# unique title codes
# len(df['title'].unique())
df['title'].nunique()
```




    110




```python
# 'Reasons/Departments' extraction from title
df['Reason'] = df['title'].apply(lambda x: x.split(':')[0])
```


```python
# frequency table of 'Reasons/Departments'
df['Reason'].value_counts()
```




    EMS        48877
    Traffic    35695
    Fire       14920
    Name: Reason, dtype: int64




```python
# countplot with seaborn
sns.countplot(x='Reason', data=df)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff700edb9d0>




![png](/assets/images/Python/Course 001/section-013/output_15_1.png)



```python
# timeStamp
df['timeStamp'][0]
```




    '2015-12-10 17:40:00'




```python
# data type of the objects in the timeStamp column
type(df['timeStamp'][0])
```




    str




```python
# convert timeStamp string to DateTime
df['timeStamp'] = pd.to_datetime(df['timeStamp'])
df['timeStamp'][0]
```




    Timestamp('2015-12-10 17:40:00')




```python
# assegno la prima osservazione, così posso usare shift+tab nella cella successiva per vedere i methods
ora = df['timeStamp'][0]
```


```python
# estraggo l'ora
ora.hour
```




    17




```python
# costruisco variabile ora, mese e giorno della settimana
df['Hour'] = df['timeStamp'].apply(lambda x: x.hour)
df['Month'] = df['timeStamp'].apply(lambda x: x.month)
df['Day of Week'] = df['timeStamp'].apply(lambda x: x.dayofweek)
```


```python
# mapping number day week to day week
dmap = {0:'Mon',1:'Tue',2:'Wed',3:'Thu',4:'Fri',5:'Sat',6:'Sun'}
df['Day of Week'] = df['Day of Week'].map(dmap)
```


```python
# countplot day week
sns.countplot(x='Day of Week',data=df,hue='Reason',palette='viridis')
# plt.legend(loc='center left', bbox_to_anchor=(1.0, 0.5))
plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
```




    <matplotlib.legend.Legend at 0x7ff6fffce450>




![png](/assets/images/Python/Course 001/section-013/output_23_1.png)



```python
# countplot month
sns.countplot(x='Month',data=df,hue='Reason',palette='viridis')
# plt.legend(loc='center left', bbox_to_anchor=(1.0, 0.5))
plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
```




    <matplotlib.legend.Legend at 0x7ff6ff24ea50>




![png](/assets/images/Python/Course 001/section-013/output_24_1.png)



```python
# 9-10-11 months missing
```


```python
# attenzione sono presenti dei missing, non usare le colonne con i missing per i conteggi
df.isnull().sum()
```




    lat                0
    lng                0
    desc               0
    zip            12855
    title              0
    timeStamp          0
    twp               43
    addr             519
    e                  0
    Reason             0
    Hour               0
    Month              0
    Day of Week        0
    dtype: int64




```python
# attenzione sono presenti dei missing, non usare le colonne con i missing per i conteggi
df.isnull().any()
```




    lat            False
    lng            False
    desc           False
    zip             True
    title          False
    timeStamp      False
    twp             True
    addr            True
    e              False
    Reason         False
    Hour           False
    Month          False
    Day of Week    False
    dtype: bool




```python
# groupby month
byMonth = df.groupby(by='Month').count()
byMonth.head()
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
      <th>lat</th>
      <th>lng</th>
      <th>desc</th>
      <th>zip</th>
      <th>title</th>
      <th>timeStamp</th>
      <th>twp</th>
      <th>addr</th>
      <th>e</th>
      <th>Reason</th>
      <th>Hour</th>
      <th>Day of Week</th>
    </tr>
    <tr>
      <th>Month</th>
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
      <th>1</th>
      <td>13205</td>
      <td>13205</td>
      <td>13205</td>
      <td>11527</td>
      <td>13205</td>
      <td>13205</td>
      <td>13203</td>
      <td>13096</td>
      <td>13205</td>
      <td>13205</td>
      <td>13205</td>
      <td>13205</td>
    </tr>
    <tr>
      <th>2</th>
      <td>11467</td>
      <td>11467</td>
      <td>11467</td>
      <td>9930</td>
      <td>11467</td>
      <td>11467</td>
      <td>11465</td>
      <td>11396</td>
      <td>11467</td>
      <td>11467</td>
      <td>11467</td>
      <td>11467</td>
    </tr>
    <tr>
      <th>3</th>
      <td>11101</td>
      <td>11101</td>
      <td>11101</td>
      <td>9755</td>
      <td>11101</td>
      <td>11101</td>
      <td>11092</td>
      <td>11059</td>
      <td>11101</td>
      <td>11101</td>
      <td>11101</td>
      <td>11101</td>
    </tr>
    <tr>
      <th>4</th>
      <td>11326</td>
      <td>11326</td>
      <td>11326</td>
      <td>9895</td>
      <td>11326</td>
      <td>11326</td>
      <td>11323</td>
      <td>11283</td>
      <td>11326</td>
      <td>11326</td>
      <td>11326</td>
      <td>11326</td>
    </tr>
    <tr>
      <th>5</th>
      <td>11423</td>
      <td>11423</td>
      <td>11423</td>
      <td>9946</td>
      <td>11423</td>
      <td>11423</td>
      <td>11420</td>
      <td>11378</td>
      <td>11423</td>
      <td>11423</td>
      <td>11423</td>
      <td>11423</td>
    </tr>
  </tbody>
</table>
</div>




```python
# line plot count, è evidente la caduta causata dal dato mancante
plt.figure(figsize=(4,2),dpi=100)
plt.style.use('default')
byMonth['lat'].plot()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff703e0eed0>




![png](/assets/images/Python/Course 001/section-013/output_29_1.png)



```python
# count plot, è evidente la caduta causata dal dato mancante
plt.figure(figsize=(4,2),dpi=100)
sns.countplot(x='Month',data=df,palette='viridis')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff6ff5d5c50>




![png](/assets/images/Python/Course 001/section-013/output_30_1.png)



```python
# linear fit calls per month
# trasformo l'index month in una colonna così da poterlo usare come variabile x
sns.lmplot(x='Month',y='twp',data=byMonth.reset_index())
```




    <seaborn.axisgrid.FacetGrid at 0x7ff6ff5a60d0>




![png](/assets/images/Python/Course 001/section-013/output_31_1.png)



```python
# creo colonna data da timeStamp
df['Date'] = df['timeStamp'].apply(lambda x: x.date())
df['Date'].head()
```




    0    2015-12-10
    1    2015-12-10
    2    2015-12-10
    3    2015-12-10
    4    2015-12-10
    Name: Date, dtype: object




```python
# line plot time
plt.figure(figsize=(8,2),dpi=100)
plt.style.use('ggplot') # plt.style.use('default')
df.groupby(by='Date').count()['twp'].plot()
plt.tight_layout()
```


![png](/assets/images/Python/Course 001/section-013/output_33_0.png)



```python
# plot per ogni Reason
fig,axes = plt.subplots(nrows=3,ncols=1,figsize=(8,6))

axes[0].plot(df[df['Reason']=='EMS'].groupby(by='Date').count()['twp'])
axes[0].set_title('EMS')

axes[1].plot(df[df['Reason']=='Fire'].groupby(by='Date').count()['twp'])
axes[1].set_title('Fire')

axes[2].plot(df[df['Reason']=='Traffic'].groupby(by='Date').count()['twp'])
axes[2].set_title('Traffic')

plt.tight_layout()
```


![png](/assets/images/Python/Course 001/section-013/output_34_0.png)



```python
# heatmap column Hours & Index Day of the Week (prepare data - metodo 1)
dayHour = df[['Day of Week','Hour']].pivot_table(index='Day of Week',columns='Hour',values='Day of Week',aggfunc=len)
dayHour
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
      <th>Hour</th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>...</th>
      <th>14</th>
      <th>15</th>
      <th>16</th>
      <th>17</th>
      <th>18</th>
      <th>19</th>
      <th>20</th>
      <th>21</th>
      <th>22</th>
      <th>23</th>
    </tr>
    <tr>
      <th>Day of Week</th>
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
      <th>Fri</th>
      <td>275</td>
      <td>235</td>
      <td>191</td>
      <td>175</td>
      <td>201</td>
      <td>194</td>
      <td>372</td>
      <td>598</td>
      <td>742</td>
      <td>752</td>
      <td>...</td>
      <td>932</td>
      <td>980</td>
      <td>1039</td>
      <td>980</td>
      <td>820</td>
      <td>696</td>
      <td>667</td>
      <td>559</td>
      <td>514</td>
      <td>474</td>
    </tr>
    <tr>
      <th>Mon</th>
      <td>282</td>
      <td>221</td>
      <td>201</td>
      <td>194</td>
      <td>204</td>
      <td>267</td>
      <td>397</td>
      <td>653</td>
      <td>819</td>
      <td>786</td>
      <td>...</td>
      <td>869</td>
      <td>913</td>
      <td>989</td>
      <td>997</td>
      <td>885</td>
      <td>746</td>
      <td>613</td>
      <td>497</td>
      <td>472</td>
      <td>325</td>
    </tr>
    <tr>
      <th>Sat</th>
      <td>375</td>
      <td>301</td>
      <td>263</td>
      <td>260</td>
      <td>224</td>
      <td>231</td>
      <td>257</td>
      <td>391</td>
      <td>459</td>
      <td>640</td>
      <td>...</td>
      <td>789</td>
      <td>796</td>
      <td>848</td>
      <td>757</td>
      <td>778</td>
      <td>696</td>
      <td>628</td>
      <td>572</td>
      <td>506</td>
      <td>467</td>
    </tr>
    <tr>
      <th>Sun</th>
      <td>383</td>
      <td>306</td>
      <td>286</td>
      <td>268</td>
      <td>242</td>
      <td>240</td>
      <td>300</td>
      <td>402</td>
      <td>483</td>
      <td>620</td>
      <td>...</td>
      <td>684</td>
      <td>691</td>
      <td>663</td>
      <td>714</td>
      <td>670</td>
      <td>655</td>
      <td>537</td>
      <td>461</td>
      <td>415</td>
      <td>330</td>
    </tr>
    <tr>
      <th>Thu</th>
      <td>278</td>
      <td>202</td>
      <td>233</td>
      <td>159</td>
      <td>182</td>
      <td>203</td>
      <td>362</td>
      <td>570</td>
      <td>777</td>
      <td>828</td>
      <td>...</td>
      <td>876</td>
      <td>969</td>
      <td>935</td>
      <td>1013</td>
      <td>810</td>
      <td>698</td>
      <td>617</td>
      <td>553</td>
      <td>424</td>
      <td>354</td>
    </tr>
    <tr>
      <th>Tue</th>
      <td>269</td>
      <td>240</td>
      <td>186</td>
      <td>170</td>
      <td>209</td>
      <td>239</td>
      <td>415</td>
      <td>655</td>
      <td>889</td>
      <td>880</td>
      <td>...</td>
      <td>943</td>
      <td>938</td>
      <td>1026</td>
      <td>1019</td>
      <td>905</td>
      <td>731</td>
      <td>647</td>
      <td>571</td>
      <td>462</td>
      <td>274</td>
    </tr>
    <tr>
      <th>Wed</th>
      <td>250</td>
      <td>216</td>
      <td>189</td>
      <td>209</td>
      <td>156</td>
      <td>255</td>
      <td>410</td>
      <td>701</td>
      <td>875</td>
      <td>808</td>
      <td>...</td>
      <td>904</td>
      <td>867</td>
      <td>990</td>
      <td>1037</td>
      <td>894</td>
      <td>686</td>
      <td>668</td>
      <td>575</td>
      <td>490</td>
      <td>335</td>
    </tr>
  </tbody>
</table>
<p>7 rows × 24 columns</p>
</div>




```python
# heatmap column Hours & Index Day of the Week (prepare data - metodo 2)
dayHour = df.groupby(by=['Day of Week','Hour']).count()['Reason'].unstack(level=-1)
dayHour
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
      <th>Hour</th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
      <th>4</th>
      <th>5</th>
      <th>6</th>
      <th>7</th>
      <th>8</th>
      <th>9</th>
      <th>...</th>
      <th>14</th>
      <th>15</th>
      <th>16</th>
      <th>17</th>
      <th>18</th>
      <th>19</th>
      <th>20</th>
      <th>21</th>
      <th>22</th>
      <th>23</th>
    </tr>
    <tr>
      <th>Day of Week</th>
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
      <th>Fri</th>
      <td>275</td>
      <td>235</td>
      <td>191</td>
      <td>175</td>
      <td>201</td>
      <td>194</td>
      <td>372</td>
      <td>598</td>
      <td>742</td>
      <td>752</td>
      <td>...</td>
      <td>932</td>
      <td>980</td>
      <td>1039</td>
      <td>980</td>
      <td>820</td>
      <td>696</td>
      <td>667</td>
      <td>559</td>
      <td>514</td>
      <td>474</td>
    </tr>
    <tr>
      <th>Mon</th>
      <td>282</td>
      <td>221</td>
      <td>201</td>
      <td>194</td>
      <td>204</td>
      <td>267</td>
      <td>397</td>
      <td>653</td>
      <td>819</td>
      <td>786</td>
      <td>...</td>
      <td>869</td>
      <td>913</td>
      <td>989</td>
      <td>997</td>
      <td>885</td>
      <td>746</td>
      <td>613</td>
      <td>497</td>
      <td>472</td>
      <td>325</td>
    </tr>
    <tr>
      <th>Sat</th>
      <td>375</td>
      <td>301</td>
      <td>263</td>
      <td>260</td>
      <td>224</td>
      <td>231</td>
      <td>257</td>
      <td>391</td>
      <td>459</td>
      <td>640</td>
      <td>...</td>
      <td>789</td>
      <td>796</td>
      <td>848</td>
      <td>757</td>
      <td>778</td>
      <td>696</td>
      <td>628</td>
      <td>572</td>
      <td>506</td>
      <td>467</td>
    </tr>
    <tr>
      <th>Sun</th>
      <td>383</td>
      <td>306</td>
      <td>286</td>
      <td>268</td>
      <td>242</td>
      <td>240</td>
      <td>300</td>
      <td>402</td>
      <td>483</td>
      <td>620</td>
      <td>...</td>
      <td>684</td>
      <td>691</td>
      <td>663</td>
      <td>714</td>
      <td>670</td>
      <td>655</td>
      <td>537</td>
      <td>461</td>
      <td>415</td>
      <td>330</td>
    </tr>
    <tr>
      <th>Thu</th>
      <td>278</td>
      <td>202</td>
      <td>233</td>
      <td>159</td>
      <td>182</td>
      <td>203</td>
      <td>362</td>
      <td>570</td>
      <td>777</td>
      <td>828</td>
      <td>...</td>
      <td>876</td>
      <td>969</td>
      <td>935</td>
      <td>1013</td>
      <td>810</td>
      <td>698</td>
      <td>617</td>
      <td>553</td>
      <td>424</td>
      <td>354</td>
    </tr>
    <tr>
      <th>Tue</th>
      <td>269</td>
      <td>240</td>
      <td>186</td>
      <td>170</td>
      <td>209</td>
      <td>239</td>
      <td>415</td>
      <td>655</td>
      <td>889</td>
      <td>880</td>
      <td>...</td>
      <td>943</td>
      <td>938</td>
      <td>1026</td>
      <td>1019</td>
      <td>905</td>
      <td>731</td>
      <td>647</td>
      <td>571</td>
      <td>462</td>
      <td>274</td>
    </tr>
    <tr>
      <th>Wed</th>
      <td>250</td>
      <td>216</td>
      <td>189</td>
      <td>209</td>
      <td>156</td>
      <td>255</td>
      <td>410</td>
      <td>701</td>
      <td>875</td>
      <td>808</td>
      <td>...</td>
      <td>904</td>
      <td>867</td>
      <td>990</td>
      <td>1037</td>
      <td>894</td>
      <td>686</td>
      <td>668</td>
      <td>575</td>
      <td>490</td>
      <td>335</td>
    </tr>
  </tbody>
</table>
<p>7 rows × 24 columns</p>
</div>




```python
# heatmap column Hours & Index Day of the Week
plt.figure(figsize=(5,5))
sns.heatmap(dayHour,cmap='magma',linecolor='white',linewidths=1)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff6ff321a90>




![png](/assets/images/Python/Course 001/section-013/output_37_1.png)



```python
# clustermap column Hours & Index Day of the Week
sns.clustermap(dayHour,cmap='viridis',linecolor='black',linewidths=1,figsize=(5,5))
```




    <seaborn.matrix.ClusterGrid at 0x7ff6feffc690>




![png](/assets/images/Python/Course 001/section-013/output_38_1.png)



```python
# heatmap column Hours & Index Day of the Week
dayMonth = df.groupby(by=['Day of Week','Month']).count()['Reason'].unstack(level=-1)
plt.figure(figsize=(5,5))
sns.heatmap(dayMonth,cmap='magma',linecolor='white',linewidths=1)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff6fe48b310>




![png](/assets/images/Python/Course 001/section-013/output_39_1.png)



```python
# clustermap column Month & Index Day of the Week
sns.clustermap(dayMonth,cmap='viridis',linecolor='black',linewidths=1,figsize=(5,5))
```




    <seaborn.matrix.ClusterGrid at 0x7ff6fe3ba150>




![png](/assets/images/Python/Course 001/section-013/output_40_1.png)


# Finance Project

Read data from Google finance with [pandas-datareader](https://github.com/pydata/pandas-datareader)  
Documentazione pandas-datareader [remote_data](https://pandas-datareader.readthedocs.io/en/latest/remote_data.html)


```python
from pandas_datareader import data, wb

import pandas as pd
import numpy as np
import datetime

import matplotlib.pyplot as plt
import seaborn as sns

%matplotlib inline
```


*Aggiunta 16/04/2021*  
Per scaricare indici di borsa torna comodo [yfinance](https://pypi.org/project/yfinance/) che ha una granularità anche del minuto ma con un limite di download massimo di 7 giorni.  
```python
import yfinance as yf
import datetime
FTSEMIB = yf.download(tickers="FTSEMIB.MI", 
            start=datetime.datetime(2021, 4, 14), 
            end=datetime.datetime(2021, 4, 16), 
            interval="1m").sort_values(by='Datetime', ascending=False).head()

NASDAQ = yf.download(tickers="^IXIC", 
            start=datetime.datetime(2021, 4, 14), 
            end=datetime.datetime(2021, 4, 16), 
            interval="1m").sort_values(by='Datetime', ascending=False).head()

BITCOIN_USD = yf.download(tickers="BTC-USD", 
                          start=datetime.datetime(2021, 4, 14), 
                          end=datetime.datetime(2021, 4, 16), 
                          interval="1m").sort_values(by='Datetime', ascending=False).head()

TESLA = yf.download(tickers="TSLA", 
                    start=datetime.datetime(2021, 4, 14), 
                    end=datetime.datetime(2021, 4, 16), 
                    interval="1m").sort_values(by='Datetime', ascending=False).head()
```

Riprendendo l'esercitazione..  

```python
# download data
start = datetime.datetime(2006, 1, 1)
end = datetime.datetime(2016, 1, 1)
BAC = data.DataReader('BAC', 'yahoo', start, end) # Bank of America
C = data.DataReader('C', 'yahoo', start, end)     # CitiGroup
GS = data.DataReader('GS', 'yahoo', start, end)   # Goldman Sachs
JPM = data.DataReader('JPM', 'yahoo', start, end) # JPMorgan Chase
MS = data.DataReader('MS', 'yahoo', start, end)   # Morgan Stanley
WFC = data.DataReader('WFC', 'yahoo', start, end) # Wells Fargo

# per scaricarli tutti in un comando
# df = data.DataReader(['BAC', 'C', 'GS', 'JPM', 'MS', 'WFC'],'yahoo', start, end)

# nel caso in cui non vada l'import (nb. qui CitiGroup presenta un dato anomalo eccessivo 'Stock Split C')
# df = pd.read_pickle('all_banks')
```


```python
# lista delle sigle banche ordinata
tickers = sorted(['C', 'BAC','JPM','GS','MS','WFC'])
tickers
```




    ['BAC', 'C', 'GS', 'JPM', 'MS', 'WFC']




```python
# creo df unico
bank_stocks = pd.concat([BAC, C, GS, JPM, MS, WFC],axis=1,keys=tickers)
bank_stocks.head()
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
      <th colspan="6" halign="left">BAC</th>
      <th colspan="4" halign="left">C</th>
      <th>...</th>
      <th colspan="4" halign="left">MS</th>
      <th colspan="6" halign="left">WFC</th>
    </tr>
    <tr>
      <th></th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Close</th>
      <th>Volume</th>
      <th>Adj Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Close</th>
      <th>...</th>
      <th>Open</th>
      <th>Close</th>
      <th>Volume</th>
      <th>Adj Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Close</th>
      <th>Volume</th>
      <th>Adj Close</th>
    </tr>
    <tr>
      <th>Date</th>
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
      <th>2006-01-03</th>
      <td>47.180000</td>
      <td>46.150002</td>
      <td>46.919998</td>
      <td>47.080002</td>
      <td>16296700.0</td>
      <td>35.054218</td>
      <td>493.799988</td>
      <td>481.100006</td>
      <td>490.000000</td>
      <td>492.899994</td>
      <td>...</td>
      <td>57.169998</td>
      <td>58.310001</td>
      <td>5377000.0</td>
      <td>37.399338</td>
      <td>31.975000</td>
      <td>31.195000</td>
      <td>31.600000</td>
      <td>31.900000</td>
      <td>11016400.0</td>
      <td>20.408512</td>
    </tr>
    <tr>
      <th>2006-01-04</th>
      <td>47.240002</td>
      <td>46.450001</td>
      <td>47.000000</td>
      <td>46.580002</td>
      <td>17757900.0</td>
      <td>34.681938</td>
      <td>491.000000</td>
      <td>483.500000</td>
      <td>488.600006</td>
      <td>483.799988</td>
      <td>...</td>
      <td>58.700001</td>
      <td>58.349998</td>
      <td>7977800.0</td>
      <td>37.424999</td>
      <td>31.820000</td>
      <td>31.365000</td>
      <td>31.799999</td>
      <td>31.530001</td>
      <td>10870000.0</td>
      <td>20.171795</td>
    </tr>
    <tr>
      <th>2006-01-05</th>
      <td>46.830002</td>
      <td>46.320000</td>
      <td>46.580002</td>
      <td>46.639999</td>
      <td>14970700.0</td>
      <td>34.726604</td>
      <td>487.799988</td>
      <td>484.000000</td>
      <td>484.399994</td>
      <td>486.200012</td>
      <td>...</td>
      <td>58.549999</td>
      <td>58.509998</td>
      <td>5778000.0</td>
      <td>37.527611</td>
      <td>31.555000</td>
      <td>31.309999</td>
      <td>31.500000</td>
      <td>31.495001</td>
      <td>10158000.0</td>
      <td>20.149401</td>
    </tr>
    <tr>
      <th>2006-01-06</th>
      <td>46.910000</td>
      <td>46.349998</td>
      <td>46.799999</td>
      <td>46.570000</td>
      <td>12599800.0</td>
      <td>34.674480</td>
      <td>489.000000</td>
      <td>482.000000</td>
      <td>488.799988</td>
      <td>486.200012</td>
      <td>...</td>
      <td>58.770000</td>
      <td>58.570000</td>
      <td>6889800.0</td>
      <td>37.566090</td>
      <td>31.775000</td>
      <td>31.385000</td>
      <td>31.580000</td>
      <td>31.680000</td>
      <td>8403800.0</td>
      <td>20.267757</td>
    </tr>
    <tr>
      <th>2006-01-09</th>
      <td>46.970001</td>
      <td>46.360001</td>
      <td>46.720001</td>
      <td>46.599998</td>
      <td>15619400.0</td>
      <td>34.696808</td>
      <td>487.399994</td>
      <td>483.000000</td>
      <td>486.000000</td>
      <td>483.899994</td>
      <td>...</td>
      <td>58.630001</td>
      <td>59.189999</td>
      <td>4144500.0</td>
      <td>37.963749</td>
      <td>31.825001</td>
      <td>31.555000</td>
      <td>31.674999</td>
      <td>31.674999</td>
      <td>5619600.0</td>
      <td>20.264565</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 36 columns</p>
</div>




```python
# definisco i nomi colonna del multilevel df
bank_stocks.columns.names = ['Bank Ticker','Stock Info']
bank_stocks.columns.names
```




    FrozenList(['Bank Ticker', 'Stock Info'])



### EDA (Exploratory Data Analysis)

Documentazione [Multi-Level Indexing](http://pandas.pydata.org/pandas-docs/stable/advanced.html) and [Cross Section](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.xs.html)


```python
bank_stocks.head()
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
      <th>Bank Ticker</th>
      <th colspan="6" halign="left">BAC</th>
      <th colspan="4" halign="left">C</th>
      <th>...</th>
      <th colspan="4" halign="left">MS</th>
      <th colspan="6" halign="left">WFC</th>
    </tr>
    <tr>
      <th>Stock Info</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Close</th>
      <th>Volume</th>
      <th>Adj Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Close</th>
      <th>...</th>
      <th>Open</th>
      <th>Close</th>
      <th>Volume</th>
      <th>Adj Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Close</th>
      <th>Volume</th>
      <th>Adj Close</th>
    </tr>
    <tr>
      <th>Date</th>
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
      <th>2006-01-03</th>
      <td>47.180000</td>
      <td>46.150002</td>
      <td>46.919998</td>
      <td>47.080002</td>
      <td>16296700.0</td>
      <td>35.054218</td>
      <td>493.799988</td>
      <td>481.100006</td>
      <td>490.000000</td>
      <td>492.899994</td>
      <td>...</td>
      <td>57.169998</td>
      <td>58.310001</td>
      <td>5377000.0</td>
      <td>37.399338</td>
      <td>31.975000</td>
      <td>31.195000</td>
      <td>31.600000</td>
      <td>31.900000</td>
      <td>11016400.0</td>
      <td>20.408512</td>
    </tr>
    <tr>
      <th>2006-01-04</th>
      <td>47.240002</td>
      <td>46.450001</td>
      <td>47.000000</td>
      <td>46.580002</td>
      <td>17757900.0</td>
      <td>34.681938</td>
      <td>491.000000</td>
      <td>483.500000</td>
      <td>488.600006</td>
      <td>483.799988</td>
      <td>...</td>
      <td>58.700001</td>
      <td>58.349998</td>
      <td>7977800.0</td>
      <td>37.424999</td>
      <td>31.820000</td>
      <td>31.365000</td>
      <td>31.799999</td>
      <td>31.530001</td>
      <td>10870000.0</td>
      <td>20.171795</td>
    </tr>
    <tr>
      <th>2006-01-05</th>
      <td>46.830002</td>
      <td>46.320000</td>
      <td>46.580002</td>
      <td>46.639999</td>
      <td>14970700.0</td>
      <td>34.726604</td>
      <td>487.799988</td>
      <td>484.000000</td>
      <td>484.399994</td>
      <td>486.200012</td>
      <td>...</td>
      <td>58.549999</td>
      <td>58.509998</td>
      <td>5778000.0</td>
      <td>37.527611</td>
      <td>31.555000</td>
      <td>31.309999</td>
      <td>31.500000</td>
      <td>31.495001</td>
      <td>10158000.0</td>
      <td>20.149401</td>
    </tr>
    <tr>
      <th>2006-01-06</th>
      <td>46.910000</td>
      <td>46.349998</td>
      <td>46.799999</td>
      <td>46.570000</td>
      <td>12599800.0</td>
      <td>34.674480</td>
      <td>489.000000</td>
      <td>482.000000</td>
      <td>488.799988</td>
      <td>486.200012</td>
      <td>...</td>
      <td>58.770000</td>
      <td>58.570000</td>
      <td>6889800.0</td>
      <td>37.566090</td>
      <td>31.775000</td>
      <td>31.385000</td>
      <td>31.580000</td>
      <td>31.680000</td>
      <td>8403800.0</td>
      <td>20.267757</td>
    </tr>
    <tr>
      <th>2006-01-09</th>
      <td>46.970001</td>
      <td>46.360001</td>
      <td>46.720001</td>
      <td>46.599998</td>
      <td>15619400.0</td>
      <td>34.696808</td>
      <td>487.399994</td>
      <td>483.000000</td>
      <td>486.000000</td>
      <td>483.899994</td>
      <td>...</td>
      <td>58.630001</td>
      <td>59.189999</td>
      <td>4144500.0</td>
      <td>37.963749</td>
      <td>31.825001</td>
      <td>31.555000</td>
      <td>31.674999</td>
      <td>31.674999</td>
      <td>5619600.0</td>
      <td>20.264565</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 36 columns</p>
</div>




```python
# Close price massimo per ciascuna banca
bank_stocks.xs(key='Close',level='Stock Info',axis=1).max()
```




    Bank Ticker
    BAC     54.900002
    C      564.099976
    GS     247.919998
    JPM     70.080002
    MS      89.300003
    WFC     58.520000
    dtype: float64



Formula rendimenti
$$r_t = \frac{p_t - p_{t-1}}{p_{t-1}} = \frac{p_t}{p_{t-1}} - 1$$


```python
# calcolo dei Rendimenti
returns = bank_stocks.xs(key='Close',level='Stock Info',axis=1).pct_change()
returns.columns = returns.columns+' Return'
# returns = pd.DataFrame()
# for tick in tickers:
#     returns[tick+' Return'] = bank_stocks[tick]['Close'].pct_change()

returns.head()
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
      <th>Bank Ticker</th>
      <th>BAC Return</th>
      <th>C Return</th>
      <th>GS Return</th>
      <th>JPM Return</th>
      <th>MS Return</th>
      <th>WFC Return</th>
    </tr>
    <tr>
      <th>Date</th>
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
      <th>2006-01-03</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2006-01-04</th>
      <td>-0.010620</td>
      <td>-0.018462</td>
      <td>-0.013812</td>
      <td>-0.014183</td>
      <td>0.000686</td>
      <td>-0.011599</td>
    </tr>
    <tr>
      <th>2006-01-05</th>
      <td>0.001288</td>
      <td>0.004961</td>
      <td>-0.000393</td>
      <td>0.003029</td>
      <td>0.002742</td>
      <td>-0.001110</td>
    </tr>
    <tr>
      <th>2006-01-06</th>
      <td>-0.001501</td>
      <td>0.000000</td>
      <td>0.014169</td>
      <td>0.007046</td>
      <td>0.001025</td>
      <td>0.005874</td>
    </tr>
    <tr>
      <th>2006-01-09</th>
      <td>0.000644</td>
      <td>-0.004731</td>
      <td>0.012030</td>
      <td>0.016242</td>
      <td>0.010586</td>
      <td>-0.000158</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Citigroup has no 'great' outliers
returns['C Return'].describe()
```




    count    2516.000000
    mean       -0.000157
    std         0.038672
    min        -0.390244
    25%        -0.011182
    50%        -0.000210
    75%         0.010751
    max         0.578249
    Name: C Return, dtype: float64




```python
# pairplot
sns.pairplot(returns)
```




    <seaborn.axisgrid.PairGrid at 0x7ff6d75a6bd0>




![png](/assets/images/Python/Course 001/section-013/output_55_1.png)



```python
# Worst Drop (4 of them on Inauguration day)
returns.idxmin()
```




    Bank Ticker
    BAC Return   2009-01-20
    C Return     2009-02-27
    GS Return    2009-01-20
    JPM Return   2009-01-20
    MS Return    2008-10-09
    WFC Return   2009-01-20
    dtype: datetime64[ns]




```python
# Best Single Day Gain (JPM e MS il migliore poco dopo)
returns.idxmax()
```




    Bank Ticker
    BAC Return   2009-04-09
    C Return     2008-11-24
    GS Return    2008-11-24
    JPM Return   2009-01-21
    MS Return    2008-10-13
    WFC Return   2008-07-16
    dtype: datetime64[ns]




```python
# standard deviation intero periodo
returns.std()
```




    Bank Ticker
    BAC Return    0.036647
    C Return      0.038672
    GS Return     0.025390
    JPM Return    0.027667
    MS Return     0.037819
    WFC Return    0.030238
    dtype: float64




```python
# standard deviation sul 2015 (filtro o apply con map sull'index)
# returns[returns.index.map(lambda x: x.year)==2015].std()
returns.loc['2015-01-01':'2015-12-31'].std()
```




    Bank Ticker
    BAC Return    0.016163
    C Return      0.015289
    GS Return     0.014046
    JPM Return    0.014017
    MS Return     0.016249
    WFC Return    0.012591
    dtype: float64




```python
# distplot return del 2015 di MS
plt.figure(figsize=(4,2),dpi=100)
sns.distplot(returns.loc['2015-01-01':'2015-12-31']['MS Return'],bins=100,color='green')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff6cf835e50>




![png](/assets/images/Python/Course 001/section-013/output_60_1.png)



```python
# distplot return del 2015 di C
plt.figure(figsize=(4,2),dpi=100)
sns.distplot(returns.loc['2008-01-01':'2008-12-31']['C Return'],bins=100,color='red')
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff6ce6f98d0>




![png](/assets/images/Python/Course 001/section-013/output_61_1.png)


### More Visualization


```python
import matplotlib.pyplot as plt
import seaborn as sns
sns.set_style('whitegrid')
%matplotlib inline

import plotly
import cufflinks as cf
cf.go_offline()

from IPython.display import Image
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
# close stock per ogni banca
close = bank_stocks.xs(key='Close',level='Stock Info',axis=1)
close.head()
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
      <th>Bank Ticker</th>
      <th>BAC</th>
      <th>C</th>
      <th>GS</th>
      <th>JPM</th>
      <th>MS</th>
      <th>WFC</th>
    </tr>
    <tr>
      <th>Date</th>
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
      <th>2006-01-03</th>
      <td>47.080002</td>
      <td>492.899994</td>
      <td>128.869995</td>
      <td>40.189999</td>
      <td>58.310001</td>
      <td>31.900000</td>
    </tr>
    <tr>
      <th>2006-01-04</th>
      <td>46.580002</td>
      <td>483.799988</td>
      <td>127.089996</td>
      <td>39.619999</td>
      <td>58.349998</td>
      <td>31.530001</td>
    </tr>
    <tr>
      <th>2006-01-05</th>
      <td>46.639999</td>
      <td>486.200012</td>
      <td>127.040001</td>
      <td>39.740002</td>
      <td>58.509998</td>
      <td>31.495001</td>
    </tr>
    <tr>
      <th>2006-01-06</th>
      <td>46.570000</td>
      <td>486.200012</td>
      <td>128.839996</td>
      <td>40.020000</td>
      <td>58.570000</td>
      <td>31.680000</td>
    </tr>
    <tr>
      <th>2006-01-09</th>
      <td>46.599998</td>
      <td>483.899994</td>
      <td>130.389999</td>
      <td>40.669998</td>
      <td>59.189999</td>
      <td>31.674999</td>
    </tr>
  </tbody>
</table>
</div>




```python
# line plot per ogni close stock (matplotlib)
close.plot(figsize=(12,4))
# for tick in tickers:
#     bank_stocks[tick]['Close'].plot(figsize=(12,4),label=tick)
# plt.legend()
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff6df437790>




![png](/assets/images/Python/Course 001/section-013/output_65_1.png)


```python
# line plot per ogni close stock (plotly)
fig = close.iplot(asFigure=True)
fig.show()
```


```python
# display static image
img_bytes = fig.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-013/output_67_0.png)



### Moving Averages


```python
# close stock BAC e MA 30 giorni
fig = plt.figure(figsize=(12,6))
close.loc['2008-01-01':'2008-12-31']['BAC'].rolling(window=30).mean().plot(label='30 Day MA')
close.loc['2008-01-01':'2008-12-31']['BAC'].plot(label='BAC Close')
plt.legend()
plt.tight_layout()
```


![png](/assets/images/Python/Course 001/section-013/output_69_0.png)



```python
# heatmap close price (reversescale color)
plt.figure(figsize=(5,4),dpi=100)
sns.heatmap(close.corr(),cmap='magma_r',linecolor='white',linewidths=1,annot=True)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x7ff6daa16210>




![png](/assets/images/Python/Course 001/section-013/output_70_1.png)



```python
# clustermap close price
sns.clustermap(close.corr(),standard_scale=1,figsize=(6,6),annot=True,cmap='magma_r')
```




    <seaborn.matrix.ClusterGrid at 0x7ff6da90a1d0>




![png](/assets/images/Python/Course 001/section-013/output_71_1.png)


### Technical Analysis

```python
# candle plot BAC
fig = BAC[['Open', 'High', 'Low', 'Close']].loc['2015-01-01':'2016-01-01'].iplot(kind='candle',asFigure=True,title='Candle plot BAC stock')
fig.show()
```


```python
# display static image
img_bytes = fig.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-013/output_74_0.png)



```python
# Simple Moving Average per MS (da lanciare in locale, non sono riuscito ad esportarla come immagine)
MS['Close'].loc['2015-01-01':'2016-01-01'].ta_plot(study='sma',periods=[13,21,55])
```

```python
# Bollinger Band Plot per BAC
BAC['Close'].loc['2015-01-01':'2016-01-01'].ta_plot(study='boll')
```
