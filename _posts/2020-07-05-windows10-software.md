---
title: "Windows 10: software"
excerpt: ""
date: 2020-07-05
tags: [utils, windows, setup]
mathjax: "true"
---


## Must-have
- Windows Photo Viewer
- Search Everything
- TinyWall/simplewall (o Comodo Firewall)

### [Windows Photo Viewer](https://github.com/AlbGri/AlbGri.github.io/blob/master/assets/files/photo_viewer.reg)
Il codice (visionabile con un file di testo) modifica il registro per consentire a Windows 10 di visualizzare con "tasto destro apri con.." il vecchio visualizzatore di immagini e impostarlo come default. Il nuovo di Windows 10 è fin troppo lento. Da provare l'alternativa [nomacs](https://nomacs.org/).

### [Search Everything]((https://www.voidtools.com/))
Esiste anche la versione portable, ma è un tool così veloce, piccolo ed efficiente che è un insulto non installarlo. Permette di indicizzare molto velocemente tutti i file del PC e fare ricerche estremamente veloci.

### [TinyWall](https://tinywall.pados.hu/download.php) o [simplewall](https://www.henrypp.org/product/simplewall)
Il firewall permette di gestire le connessioni in uscita o entrata. Per diversi anni, da quando è uscito Windows XP a quando è morto, ho usato ZoneAlarm, poi con Windows 7 e 10 sono stato costretto ad abbandonare ZA e ho usato Comodo Firewall, ma vorrei disfarmene sebbene abbia aspetti interessanti. Devo provare questi firewall più "skinny". Comunque sia un firewall che non sia Windows Firewall lo trovo necessario in quanto non permette una gestione agevole dei programmi che vogliono connettersi ad internet.

### [Comodo Firewall](https://www.comodo.com/home/internet-security/firewall.php)
Dopo anni di utilizzo sto provando ad abbandonarlo a favore di TinyWall o simplewall.  
**Contro**  
&nbsp; &nbsp; - Installa bloatware se non si sta attenti in fase di install  
&nbsp; &nbsp; - Non è opensource e non è noto cosa fanno dei tuoi dati  
**Pro**  
&nbsp; &nbsp; - Consente di bloccare programmi in uscita e/o entrata  
&nbsp; &nbsp; - Consente di bloccare azioni che stanno modificando il registro di Windows  
&nbsp; &nbsp; - Identifica potenziali malaware  
&nbsp; &nbsp; - Servizio di sandbox per avviare i programmi in modo "inoffensivo"  
&nbsp; &nbsp; - Consuma poche risorse  
&nbsp; &nbsp; - Non va in conflitto con Windows Defender  
&nbsp; &nbsp; - Widget per monitoraggio velocità download/upload


## Utili 
1. [Locate32](https://locate32.cogit.net/)  
Tool di ricerca simile a Search Everything, meno potente ma permette di indicizzare bene anche server remoti.

1. [Greenshot](https://getgreenshot.org/)  
Permette di fare gli screenshot stile linux con scorciatoie come shift+print etc.

1. [WizTree](https://wiztreefree.com/download)  
Software per controllo spazio su periferiche di massa. Utile per pulire il proprio disco. Consiglio di scaricare la versione portable senza installazione. Questo è un tool da tenere su pendrive :). Prima utilizzavo WinDirStat ma è molto lento al confronto.

1. [WinMerge](https://winmerge.org/)  
Tool per il confronto tra file di testo. Da provare [FreeFileSync](https://freefilesync.org/) come alternativa.

1. [TestDisk & PhotoRec](https://www.cgsecurity.org/wiki/TestDisk_Download)  
Per recuperare file eliminati, simile a [Recuva](https://www.ccleaner.com/recuva) ma opensource.

1. Mozilla Firefox (vedi [questa](https://www.albgri.com/browser-configuration/) guida per le estensioni must-have)

1. [Miktex](https://miktex.org/download)  
Gestore LaTeX che preferisco per Windows

1. Notepad++  
Editor di testo semplice ed avanzato

1. Nitro PRO PDF  
Modifiche file pdf non esiste gratuito *legalmente*.

1. VLC  
Lettore multimediale

1. Sumatra PDF  
Lettore pdf gratuito e leggero

1. 7-Zip  
Gestore file compressi


## [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
1. Ci assicuriamo di avere rimosso la precedente installazione (eg. Uninstall-Miniconda3.exe)
1. Installazione
<img src="/assets/images/miniconda_1.png" width="400">
<img src="/assets/images/miniconda_2.png" width="400">
![png](/assets/images/miniconda_3.png)
1. altro
1. Una volta installato apro l'Anaconda Prompt (miniconda3)  
```console
conda install -c conda-forge notebook
conda install -c anaconda numpy
conda install -c anaconda pandas
cd /d "E:\path"
jupyter notebook
```




## [KeePass 2.x](https://keepass.info/download.html)
Software multiplatform per gestione password  
&nbsp; &nbsp; - [Google Drive Sync Plugin](https://sourceforge.net/p/kp-googlesync/support/Getting%20Started/)  
&nbsp; &nbsp; - [Firefox](https://addons.mozilla.org/en-US/firefox/addon/keefox/)  
&nbsp; &nbsp; - [Chrome](https://chrome.google.com/webstore/detail/kee/mmhlniccooihdimnnjhamobppdhaolme)  
&nbsp; &nbsp; - [Android](https://play.google.com/store/apps/details?id=keepass2android.keepass2android)  
nb. la sincronizzazione con Google Drive su Windows non è banale ma è simile a quella di [Ubuntu](https://www.albgri.com/ubuntu-software/#keepass).


## Opera Browser
Un browser che ho "amato". Ma nel 2016 diventa cinese e i creatori di Opera rilasciano Vivaldi.  
[Qui](https://www.reddit.com/r/operabrowser/comments/ajmbox/opera_is_spyware/) un link interessante che mostra una breve analisi sul problema che sia controllato da un consorzio cinese.  
Si apre un tema etico molto interessante e a me molto vicino: [Nothing to Hide, Nothing to Fear](https://www.openrightsgroup.org/blog/responding-to-nothing-to-hide-nothing-to-fear/).  
Comunque sia Opera, si basa su Chromium, si può scaricare [questa](https://addons.opera.com/en/extensions/details/install-chrome-extensions/) estensione che permette di installare i componenti aggiuntivi direttamente dal webstore di Chrome. Ad esempio [ClearUrls](https://chrome.google.com/webstore/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk) non c'è nello store di Opera, ma [uBlock](https://addons.opera.com/en/extensions/details/ublock/) è presente. Per le estensioni must-have rimando a [questo](https://www.albgri.com/browser-configuration/) link.  








...
