---
title: "Windows 10: utilities"
excerpt: ""
date: 2020-07-04
tags: [utils, windows, setup]
mathjax: "true"
---

## Comandi utili
1. Cerca in tutte le subfolders, stringa esatta
```console
findstr /S /c:"testo da cercare" *
```
1. Cerca in tutte le subfolders, mostra solo nome file
```
findstr /M /S /c:"testo da cercare" *
```

## Scorciatoie
1. Strumento di cattura  
<span style="font-size: 3mm">
Windows Key + Shift + S  
</span>
Gli screen si salvano in automatico in '*C:\Users\nomeUtente\AppData\Local\Packages\Microsoft.Windows.ShellExperienceHost_cw5n1h2txyewy\TempState\ScreenClip*'




## Websites
1. [Web Flow Charts](https://app.diagrams.net)
1. [Ping Site](https://ping.canbeuseful.com/en#ping)
1. [Check Site UP](https://www.uptrends.com/tools/uptime)
1. [Paste IMG](https://snipboard.io)

## Altro
1. Costruisco un collegamento per lanciare velocemente uno specifico conda environment da un percorso specifico  
Creo un file .bat (nuovo file di testo e poi rinomino l'estensione) contenente il seguente codice (nota: modificare i path con i propri percorsi e il nome dell'ambiente)
```bash
@echo off    
set PATH=%PATH%;C:\Users\miniconda3\Scripts
cd /d F:\Python\Course 001\
%windir%\system32\cmd.exe "/K" C:\Users\miniconda3\Scripts\activate.bat py3_tf
```

1. Google Drive Fix Folder  
Google Drive sembra avere rimosso la possibilità di aggiugnere una cartella condivisa in locale.  
Da browser tra i file condivisi, selezionare la cartella da portare sul client di Google Drive → shift+z → aggiungi a Drive









...
