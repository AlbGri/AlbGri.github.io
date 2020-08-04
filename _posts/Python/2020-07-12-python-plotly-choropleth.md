---
title: "Python: Plotly and Choropleth"
excerpt: "Data Visualization -- Covid19 dataset"
date: 2020-07-12
tags: [python, covid19]
---

*Utilizzo l'environment conda py3*  
```console
~$ conda activate py3
```

*Versione modulo installato*  
```console
~$ pip show chart-studio
Name: chart-studio
Version: 1.1.0
Summary: Utilities for interfacing with plotly's Chart Studio
Home-page: https://plot.ly/python/
Author: Chris P
Author-email: chris@plot.ly
License: MIT
Location: /home/user/miniconda3/envs/py3/lib/python3.7/site-packages
Requires: plotly, requests, retrying, six
Required-by:
```

# Plotly and Choropleth

**Per ottenere i grafici interattivi lanciare il codice in locale.**  
Sono riuscito ad esportarli via web con Markdown solo statici (sono necessari *psutil* e *orca*)  

```console
~$ conda install psutil
~$ conda install -c plotly plotly-orca
```

Cheat sheet [Plotly](https://images.plot.ly/plotly-documentation/images/python_cheat_sheet.pdf)  
Documentazione [Choropleth](https://plotly.com/python/reference/#choropleth)  


```python
import chart_studio.plotly as py
import plotly.graph_objs as go
import pandas as pd
from plotly.offline import download_plotlyjs, init_notebook_mode, plot, iplot
from IPython.display import Image
```


```python
# per mostrare nel notebook
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



## Plot USA-states

```python
data = dict(type = 'choropleth',
            locations = ['AZ','CA','NY'],
            locationmode = 'USA-states',
            colorscale= 'Portland',
            text= ['Arizona','Cali','New York'],
            z=[1.0,2.0,3.0],
            marker = dict(line = dict(color = 'rgb(0,0,0)',width = 3)),
            colorbar = {'title':'Colorbar Title'})

layout = dict(title = 'Plot 1')

choromap = go.Figure(data = [data],layout = layout)
choromap.update_geos(
    visible=True, 
    resolution=50, 
    scope="usa",
    
    # projection_type="orthographic", # "natural earth"
    # lataxis_showgrid=True, lonaxis_showgrid=True,
    
    showcoastlines=True, coastlinecolor="RebeccaPurple",
    showland=True, landcolor="LightGreen",
    showocean=True, oceancolor="LightBlue",
    showlakes=True, lakecolor="Blue",
    showrivers=True, rivercolor="Blue",
    
    showcountries=True, countrycolor="Black",
    showsubunits=True, subunitcolor="Black")
# choromap.show() # si può omettere se si usa il comando precedente
# iplot(choromap) # si può omettere se si usa il comando precedente
# plot(choromap)  # apre in nuova finestra
```


```python
# export map
# choromap.write_image("img1.png")
```


```python
# display static image
img_bytes = choromap.to_image(format="png") # parametri: width, height, scale
# img_bytes[:20]
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-012/output_11_0.png)



## Italy - Regioni

[Confini Italiani](https://github.com/openpolis/) fonte Openpolis


```python
import pandas as pd
import requests
import plotly.express as px
```


```python
# carico confini regionali
geojson_url = 'https://raw.githubusercontent.com/AlbGri/AlbGri.github.io/master/assets/files/Openpolis/geojson/limits_IT_regions.geojson'
italy_regions_geo = requests.get(geojson_url).json()
```


```python
# Regioni
regions = ['Piemonte', 'Trentino-Alto Adige/Südtirol', 'Lombardia', 'Puglia', 'Basilicata', 
           'Friuli-Venezia Giulia', 'Liguria', "Valle d'Aosta/Vallée d'Aoste", 'Emilia-Romagna',
           'Molise', 'Lazio', 'Veneto', 'Sardegna', 'Sicilia', 'Abruzzo',
           'Calabria', 'Toscana', 'Umbria', 'Campania', 'Marche']
# Create a dataframe with the region names
df = pd.DataFrame(regions, columns=['reg_name'])
# For demonstration, create a column with the length of the region's name
df['name_length'] = df['reg_name'].str.len()
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
      <th>reg_name</th>
      <th>name_length</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Piemonte</td>
      <td>8</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Trentino-Alto Adige/Südtirol</td>
      <td>28</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Lombardia</td>
      <td>9</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Puglia</td>
      <td>6</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Basilicata</td>
      <td>10</td>
    </tr>
  </tbody>
</table>
</div>



```python
# Choropleth representing the length of region names
fig = px.choropleth(data_frame=df, 
                    geojson=italy_regions_geo, # anche il geojson_url gli si può passare
                    locations='reg_name',      # name of dataframe column
                    featureidkey='properties.reg_name',  # feature object locations
                    color='name_length',
                    color_continuous_scale="Portland",
                    scope="europe",
                   )
fig.update_geos(showcountries=False, showcoastlines=False, showland=False, fitbounds="locations")
fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
# fig.show()
```


```python
# display static image
img_bytes = fig.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-012/output_18_0.png)



## Italy - Province

[Confini Italiani](https://github.com/openpolis/) fonte Openpolis  
[Dati COVID-19](https://github.com/pcm-dpc/) fonte Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civile


```python
# from urllib.request import urlopen
import pandas as pd
import plotly.express as px
# import json
```


```python
# carico confini provinciali
geojson_url = 'https://raw.githubusercontent.com/AlbGri/AlbGri.github.io/master/assets/files/Openpolis/geojson/limits_IT_provinces.geojson'
italy_province_geo = requests.get(geojson_url).json()

# struttura properties (printare tutto il dizionario è pesante)
italy_province_geo['features'][0]['properties']
```




    {'prov_name': 'Torino',
     'prov_istat_code_num': 1,
     'prov_acr': 'TO',
     'reg_name': 'Piemonte',
     'reg_istat_code': '01',
     'reg_istat_code_num': 1,
     'prov_istat_code': '001'}




```python
# carico df covid
covid_url = 'https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province.csv'
df = pd.read_csv(covid_url)
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
      <th>data</th>
      <th>stato</th>
      <th>codice_regione</th>
      <th>denominazione_regione</th>
      <th>codice_provincia</th>
      <th>denominazione_provincia</th>
      <th>sigla_provincia</th>
      <th>lat</th>
      <th>long</th>
      <th>totale_casi</th>
      <th>note</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2020-02-24T18:00:00</td>
      <td>ITA</td>
      <td>13</td>
      <td>Abruzzo</td>
      <td>66</td>
      <td>L'Aquila</td>
      <td>AQ</td>
      <td>42.351222</td>
      <td>13.398438</td>
      <td>0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2020-02-24T18:00:00</td>
      <td>ITA</td>
      <td>13</td>
      <td>Abruzzo</td>
      <td>67</td>
      <td>Teramo</td>
      <td>TE</td>
      <td>42.658918</td>
      <td>13.704400</td>
      <td>0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2020-02-24T18:00:00</td>
      <td>ITA</td>
      <td>13</td>
      <td>Abruzzo</td>
      <td>68</td>
      <td>Pescara</td>
      <td>PE</td>
      <td>42.464584</td>
      <td>14.213648</td>
      <td>0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2020-02-24T18:00:00</td>
      <td>ITA</td>
      <td>13</td>
      <td>Abruzzo</td>
      <td>69</td>
      <td>Chieti</td>
      <td>CH</td>
      <td>42.351032</td>
      <td>14.167546</td>
      <td>0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2020-02-24T18:00:00</td>
      <td>ITA</td>
      <td>13</td>
      <td>Abruzzo</td>
      <td>979</td>
      <td>In fase di definizione/aggiornamento</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 18149 entries, 0 to 18148
    Data columns (total 11 columns):
     #   Column                   Non-Null Count  Dtype  
    ---  ------                   --------------  -----  
     0   data                     18149 non-null  object 
     1   stato                    18149 non-null  object 
     2   codice_regione           18149 non-null  int64  
     3   denominazione_regione    18149 non-null  object 
     4   codice_provincia         18149 non-null  int64  
     5   denominazione_provincia  18149 non-null  object 
     6   sigla_provincia          14734 non-null  object 
     7   lat                      14873 non-null  float64
     8   long                     14873 non-null  float64
     9   totale_casi              18149 non-null  int64  
     10  note                     17 non-null     object 
    dtypes: float64(2), int64(3), object(6)
    memory usage: 1.5+ MB



```python
# non temporanee/fuori italia
df[df['codice_provincia'] > 111]['codice_provincia'].unique()
```




    array([979, 980, 982, 983, 984, 985, 986, 987, 988, 989, 990, 981, 996,
           991, 992, 993, 994, 995, 997, 998, 999, 879, 880, 882, 883, 884,
           885, 886, 887, 888, 889, 890, 881, 896, 891, 892, 893, 894, 895,
           897, 898, 899])




```python
# seleziono colonne d'interesse
df = df[['data', 'codice_provincia','sigla_provincia', 'denominazione_provincia', 'totale_casi', 'note']]

# escludo non temporanee/fuori italia
df = df[df['codice_provincia'] <= 111]

# renaming
df = df.rename(columns={'data': 'time'})

# date formatting
df['data'] = pd.to_datetime(df['time'], format="%Y-%m-%d")
df['data'] = df['data'].dt.strftime('%Y-%m-%d')

# head
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
      <th>time</th>
      <th>codice_provincia</th>
      <th>sigla_provincia</th>
      <th>denominazione_provincia</th>
      <th>totale_casi</th>
      <th>note</th>
      <th>data</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2020-02-24T18:00:00</td>
      <td>66</td>
      <td>AQ</td>
      <td>L'Aquila</td>
      <td>0</td>
      <td>NaN</td>
      <td>2020-02-24</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2020-02-24T18:00:00</td>
      <td>67</td>
      <td>TE</td>
      <td>Teramo</td>
      <td>0</td>
      <td>NaN</td>
      <td>2020-02-24</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2020-02-24T18:00:00</td>
      <td>68</td>
      <td>PE</td>
      <td>Pescara</td>
      <td>0</td>
      <td>NaN</td>
      <td>2020-02-24</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2020-02-24T18:00:00</td>
      <td>69</td>
      <td>CH</td>
      <td>Chieti</td>
      <td>0</td>
      <td>NaN</td>
      <td>2020-02-24</td>
    </tr>
    <tr>
      <th>5</th>
      <td>2020-02-24T18:00:00</td>
      <td>76</td>
      <td>PZ</td>
      <td>Potenza</td>
      <td>0</td>
      <td>NaN</td>
      <td>2020-02-24</td>
    </tr>
  </tbody>
</table>
</div>



```python
# Choropleth representing the progression of COVID-19 in italy province
fig = px.choropleth(df,
                    geojson=geojson_url, 
                    locations='codice_provincia', 
                    color='totale_casi', 
                    color_continuous_scale='Reds', 
                    featureidkey='properties.prov_istat_code_num', 
                    animation_frame='data', 
                    range_color=(0, max(df['totale_casi'])))
fig.update_geos(showcountries=False, showcoastlines=False, showland=False, fitbounds="locations")
fig.update_layout(margin={"r":0,"t":0,"l":0,"b":0})
# fig.write_html('2020-07-11-covid-19-italy.html')
```


```python
# display static image
img_bytes = fig.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-012/output_28_0.png)



## Real Data US Map Choropleth


```python
df = pd.read_csv('2011_US_AGRI_Exports')
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
      <th>code</th>
      <th>state</th>
      <th>category</th>
      <th>total exports</th>
      <th>beef</th>
      <th>pork</th>
      <th>poultry</th>
      <th>dairy</th>
      <th>fruits fresh</th>
      <th>fruits proc</th>
      <th>total fruits</th>
      <th>veggies fresh</th>
      <th>veggies proc</th>
      <th>total veggies</th>
      <th>corn</th>
      <th>wheat</th>
      <th>cotton</th>
      <th>text</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>AL</td>
      <td>Alabama</td>
      <td>state</td>
      <td>1390.63</td>
      <td>34.4</td>
      <td>10.6</td>
      <td>481.0</td>
      <td>4.06</td>
      <td>8.0</td>
      <td>17.1</td>
      <td>25.11</td>
      <td>5.5</td>
      <td>8.9</td>
      <td>14.33</td>
      <td>34.9</td>
      <td>70.0</td>
      <td>317.61</td>
      <td>Alabama&lt;br&gt;Beef 34.4 Dairy 4.06&lt;br&gt;Fruits 25.1...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>AK</td>
      <td>Alaska</td>
      <td>state</td>
      <td>13.31</td>
      <td>0.2</td>
      <td>0.1</td>
      <td>0.0</td>
      <td>0.19</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>0.6</td>
      <td>1.0</td>
      <td>1.56</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.00</td>
      <td>Alaska&lt;br&gt;Beef 0.2 Dairy 0.19&lt;br&gt;Fruits 0.0 Ve...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>AZ</td>
      <td>Arizona</td>
      <td>state</td>
      <td>1463.17</td>
      <td>71.3</td>
      <td>17.9</td>
      <td>0.0</td>
      <td>105.48</td>
      <td>19.3</td>
      <td>41.0</td>
      <td>60.27</td>
      <td>147.5</td>
      <td>239.4</td>
      <td>386.91</td>
      <td>7.3</td>
      <td>48.7</td>
      <td>423.95</td>
      <td>Arizona&lt;br&gt;Beef 71.3 Dairy 105.48&lt;br&gt;Fruits 60...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>AR</td>
      <td>Arkansas</td>
      <td>state</td>
      <td>3586.02</td>
      <td>53.2</td>
      <td>29.4</td>
      <td>562.9</td>
      <td>3.53</td>
      <td>2.2</td>
      <td>4.7</td>
      <td>6.88</td>
      <td>4.4</td>
      <td>7.1</td>
      <td>11.45</td>
      <td>69.5</td>
      <td>114.5</td>
      <td>665.44</td>
      <td>Arkansas&lt;br&gt;Beef 53.2 Dairy 3.53&lt;br&gt;Fruits 6.8...</td>
    </tr>
    <tr>
      <th>4</th>
      <td>CA</td>
      <td>California</td>
      <td>state</td>
      <td>16472.88</td>
      <td>228.7</td>
      <td>11.1</td>
      <td>225.4</td>
      <td>929.95</td>
      <td>2791.8</td>
      <td>5944.6</td>
      <td>8736.40</td>
      <td>803.2</td>
      <td>1303.5</td>
      <td>2106.79</td>
      <td>34.6</td>
      <td>249.3</td>
      <td>1064.95</td>
      <td>California&lt;br&gt;Beef 228.7 Dairy 929.95&lt;br&gt;Frui...</td>
    </tr>
  </tbody>
</table>
</div>



```python
data = dict(type='choropleth',
            colorscale = 'ylorbr',
            locations = df['code'],
            z = df['total exports'],
            locationmode = 'USA-states',
            text = df['text'],
            marker = dict(line = dict(color = 'rgb(12,12,12)',width = 2)),
            colorbar = {'title':"Millions USD"}
            )

layout = dict(title = '2011 US Agriculture Exports by State',
              geo = dict(showlakes = True,
                         lakecolor = 'rgb(85,173,240)')
             )

choromap = go.Figure(data = [data],layout = layout)
choromap = go.Figure(data = [data],layout = layout)
choromap.update_geos(
    visible=True, 
    resolution=50,
    scope='usa',    
    showcountries=True, countrycolor="Black",
    showsubunits=True, subunitcolor="Black")
```


```python
# display static image
img_bytes = choromap.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-012/output_32_0.png)



## World GDP


```python
df = pd.read_csv('2014_World_GDP')
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
      <th>COUNTRY</th>
      <th>GDP (BILLIONS)</th>
      <th>CODE</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Afghanistan</td>
      <td>21.71</td>
      <td>AFG</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Albania</td>
      <td>13.40</td>
      <td>ALB</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Algeria</td>
      <td>227.80</td>
      <td>DZA</td>
    </tr>
    <tr>
      <th>3</th>
      <td>American Samoa</td>
      <td>0.75</td>
      <td>ASM</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Andorra</td>
      <td>4.80</td>
      <td>AND</td>
    </tr>
  </tbody>
</table>
</div>



```python
data = dict(
        type = 'choropleth',
        colorscale = 'ylorbr',
        locations = df['CODE'],
        z = df['GDP (BILLIONS)'],
        text = df['COUNTRY'],
        colorbar = {'title' : 'GDP Billions US'},
      )

layout = dict(
    title = '2014 Global GDP',
    geo = dict(
        showframe = False,
        projection = {'type':'mercator'}
    )
)

choromap = go.Figure(data = [data],layout = layout)
iplot(choromap)
```


```python
# display static image
img_bytes = choromap.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-012/output_36_0.png)



## Word Power Consumption


```python
df = pd.read_csv('2014_World_Power_Consumption')
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
      <th>Country</th>
      <th>Power Consumption KWH</th>
      <th>Text</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>China</td>
      <td>5.523000e+12</td>
      <td>China 5,523,000,000,000</td>
    </tr>
    <tr>
      <th>1</th>
      <td>United States</td>
      <td>3.832000e+12</td>
      <td>United 3,832,000,000,000</td>
    </tr>
    <tr>
      <th>2</th>
      <td>European</td>
      <td>2.771000e+12</td>
      <td>European 2,771,000,000,000</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Russia</td>
      <td>1.065000e+12</td>
      <td>Russia 1,065,000,000,000</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Japan</td>
      <td>9.210000e+11</td>
      <td>Japan 921,000,000,000</td>
    </tr>
  </tbody>
</table>
</div>



```python
data = dict(type = 'choropleth',
            colorscale = 'Viridis',
            reversescale = True,
            locations = df['Country'],
            locationmode = 'country names',  # l'incrocio della mappa si deve basare sul country names
            z = df['Power Consumption KWH'],
            text = df['Country'],
            colorbar = {'title' : 'Power Consumption KWH'},
           )

layout = dict(title = '2014 Power Consumption KWH',
              geo = dict(
                  showframe = False,
                  projection = {'type':'mercator'}
              )
             )

choromap = go.Figure(data = [data],layout = layout)
iplot(choromap,validate=False)
```


```python
# display static image
img_bytes = choromap.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-012/output_40_0.png)



## USA Choropleth


```python
df = pd.read_csv('2012_Election_Data')
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
      <th>Year</th>
      <th>ICPSR State Code</th>
      <th>Alphanumeric State Code</th>
      <th>State</th>
      <th>VEP Total Ballots Counted</th>
      <th>VEP Highest Office</th>
      <th>VAP Highest Office</th>
      <th>Total Ballots Counted</th>
      <th>Highest Office</th>
      <th>Voting-Eligible Population (VEP)</th>
      <th>Voting-Age Population (VAP)</th>
      <th>% Non-citizen</th>
      <th>Prison</th>
      <th>Probation</th>
      <th>Parole</th>
      <th>Total Ineligible Felon</th>
      <th>State Abv</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2012</td>
      <td>41</td>
      <td>1</td>
      <td>Alabama</td>
      <td>NaN</td>
      <td>58.6%</td>
      <td>56.0%</td>
      <td>NaN</td>
      <td>2,074,338</td>
      <td>3,539,217</td>
      <td>3707440.0</td>
      <td>2.6%</td>
      <td>32,232</td>
      <td>57,993</td>
      <td>8,616</td>
      <td>71,584</td>
      <td>AL</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2012</td>
      <td>81</td>
      <td>2</td>
      <td>Alaska</td>
      <td>58.9%</td>
      <td>58.7%</td>
      <td>55.3%</td>
      <td>301,694</td>
      <td>300,495</td>
      <td>511,792</td>
      <td>543763.0</td>
      <td>3.8%</td>
      <td>5,633</td>
      <td>7,173</td>
      <td>1,882</td>
      <td>11,317</td>
      <td>AK</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2012</td>
      <td>61</td>
      <td>3</td>
      <td>Arizona</td>
      <td>53.0%</td>
      <td>52.6%</td>
      <td>46.5%</td>
      <td>2,323,579</td>
      <td>2,306,559</td>
      <td>4,387,900</td>
      <td>4959270.0</td>
      <td>9.9%</td>
      <td>35,188</td>
      <td>72,452</td>
      <td>7,460</td>
      <td>81,048</td>
      <td>AZ</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2012</td>
      <td>42</td>
      <td>4</td>
      <td>Arkansas</td>
      <td>51.1%</td>
      <td>50.7%</td>
      <td>47.7%</td>
      <td>1,078,548</td>
      <td>1,069,468</td>
      <td>2,109,847</td>
      <td>2242740.0</td>
      <td>3.5%</td>
      <td>14,471</td>
      <td>30,122</td>
      <td>23,372</td>
      <td>53,808</td>
      <td>AR</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2012</td>
      <td>71</td>
      <td>5</td>
      <td>California</td>
      <td>55.7%</td>
      <td>55.1%</td>
      <td>45.1%</td>
      <td>13,202,158</td>
      <td>13,038,547</td>
      <td>23,681,837</td>
      <td>28913129.0</td>
      <td>17.4%</td>
      <td>119,455</td>
      <td>0</td>
      <td>89,287</td>
      <td>208,742</td>
      <td>CA</td>
    </tr>
  </tbody>
</table>
</div>



```python
data = dict(type = 'choropleth',
            colorscale = 'Viridis',
            reversescale = True,
            locations = df['State Abv'],
            locationmode = 'USA-states',
            z = df['Voting-Age Population (VAP)'],
            text = df['State'],
            marker = dict(line = dict(color = 'rgb(255,255,255)',width = 1)),
            colorbar = {'title' : 'Voting-Age Population (VAP)'}
           )

layout = dict(title = '2012 Voting-Age Population (VAP)', 
              geo = dict(
                  scope = "usa",
                  showlakes = True,
                  lakecolor = 'rgb(85,173,240)'
                  )
             )

choromap = go.Figure(data = [data],layout = layout)
iplot(choromap,validate=False)
```


```python
# display static image
img_bytes = choromap.to_image(format="png")
Image(img_bytes)
```




![png](/assets/images/Python/Course 001/section-012/output_44_0.png)


