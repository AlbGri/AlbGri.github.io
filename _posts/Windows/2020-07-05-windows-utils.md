---
title: "windows-utils"
excerpt: "something useful"
date: 2020-07-04
tags: [utils, windows]
mathjax: "true"
---

*funzionanti con Windows 10*  

### Programmi
1. [Miniconda](https://docs.conda.io/en/latest/miniconda.html) e Jupyter Notebook  
Anaconda Prompt (miniconda3)  
```console
conda install -c conda-forge notebook
conda install -c anaconda numpy
conda install -c anaconda pandas
cd /d "F:\Python\Course 001"
jupyter notebook
```

### Comandi utili
1. Cerca in tutte le subfolders, stringa esatta
```console
findstr /S /c:"testo da cercare" *
```
1. Cerca in tutte le subfolders, mostra solo nome file
```
findstr /M /S /c:"testo da cercare" *
```


### Altro
1. Costruisco file BAT eseguibile per lanciare uno specifico conda environment da un percorso specifico
	* Creo un file .bat contenente il seguente codice (nota: modificare i path con i propri percorsi e il nome dell'ambiente)
	```bash
	@echo off    
	set PATH=%PATH%;C:\Users\miniconda3\Scripts
	cd /d F:\Python\Course 001\
	%windir%\system32\cmd.exe "/K" C:\Users\miniconda3\Scripts\activate.bat py3_tf
	```
...
















...
