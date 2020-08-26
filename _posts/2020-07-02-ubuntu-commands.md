---
title: "Ubuntu: commands"
excerpt: "useful commands"
date: 2020-07-02
tags: [utils, linux, ubuntu, bugs, bash]
mathjax: "true"
---

*Aggiornato il 2020-07-12*  

*funzionanti con Ubuntu 18-04*  

## Utili
1. Trova interattivamente il PID di un programma e terminarlo  
```console
~$ xprop _NET_WM_PID
~$ kill -9 5186
```

1. Controlla tutti i programmi installati  
```console
~$ dpkg -l
~$ sudo dpkg -l | grep -i nomeprogramma
```

1. Trova e modifica PATH  
```console
~$ echo $PATH
~$ sudo gedit /etc/environment
```

1. Trova file/cartelle  
```console
~$ cd /
~$ sudo find / -type d -name "nome"
~$ sudo find . -type d | grep nome
```

1. Trova testo dentro il path  
```console
~$ grep -r WORD *
```

1. Screenshots  
Prt Scrn: ottieni lo screen del destkop.  
Alt + Prt Scrn: ottieni lo screen del programma attivo.  
Shift + Prt Scrn: ottieni lo screen dell'area interattivamente.  

1. Modifica sources  
```console
~$ sudo gedit /etc/apt/sources.list
```

1. Rimuovi cache (da usare solo se necessario)  
```console
~$ sudo apt-get update
~$ sudo apt-get clean --dry-run
~$ sudo apt-get clean
~$ sudo apt-get autoclean --dry-run
~$ sudo apt-get autoclean
~$ sudo apt-get autoremove
```

1. Tilde, Backtick, Accento grave, simboli  
Alt destro + ì ( ~ )  
Alt destro + ' ( ` )  
Alt destro + i ( → )  

1. Rimozione autocompletamento specifico da pagina web (sia Linux che Windows)  
Seleziono l'autocompletamento da eliminare nel box di immissione testo e  
*Shift+DEL* (oppure *Shift+Canc*)  

1. Funzione tasto destro su nautilus dentro la cartella  
Deselezionare il file con *F5*, quindi *Shift+F10* per funzionalità tasto destro










## Bash
1. Per i file con estensione ".txt" sostituisci ".txt" con ".csv"  
```console
~$ cd /home/user/Documents/cartella
~$ for i in *.txt; do mv "$i" "${i/.txt/.csv}"; done
```

1. Per i file con estensione ".png" sostituisci spazi con vuoto  
```console
~$ cd /home/user/Documents/cartella
~$ for i in *\ *.png; do mv "$i" "${i// /_}"; done
```

1. Per i file con estensione ".png" aggiungi numero progressivo (prima rimuovere gli spazi)  
```console
~$ cd /home/user/Documents/cartella
~$ n=1
~$ for i in *.png; do
 p=$(printf "%04d_$i" ${n})
 mv ${i} ${p}
 let n=n+1
 done
```







## Issues & Bugs
1. BugFix  
<img src="{{ site.url }}{{ site.baseurl }}/assets/images/SystemProgBUG.png" 
alt="testo IMG"
align="center">  
"System program problem detected"  
"Do you want to report the problem now?"  
```console
~$ sudo gedit /etc/default/apport
```
enabled=0

1. Windows Partition Permissions  
Da Ubuntu, con i permessi di scrittura sul disco con partizione Windows 10 non riuscivo a fare modifiche ai file.  
Problema *ibernazione attiva*.  
[Soluzione](https://support.microsoft.com/it-it/help/920730/how-to-disable-and-re-enable-hibernation-on-a-computer-that-is-running) cmd con privilegi d'amministratore  
```bash
powercfg.exe /hibernate off
```

1. Bugged Thunderbird connection  
<span style="font-size: 3mm">
Edit → Preferences → General Tab → General screen → "Advanced" tab → "General" subtab → lower right corner find the button "Config Editor" → ok the warning → set "general.useragent.compatMode.firefox" to true (found in Edit/Preferences/Advanced/General/Config Editor)
</span>

1. Errore dopo l'install di numpy  
```console
Traceback (most recent call last):
  File "/home/user/miniconda3/bin/conda", line 7, in <module>
    from conda.cli import main
ModuleNotFoundError: No module named 'conda'
```
Se [si ha fortuna](http://stackoverflow.com/a/20516579/5948656) è solo un problema di path  
Se [non si ha fortuna](https://github.com/conda/conda/issues/2463), risolve reinstallando anaconda :(   
Da ora in poi userò gli [ambienti virtuali](https://www.albgri.com/section-004/#conda-enviroments) di Anaconda!  
[Miniconda](https://docs.conda.io/en/latest/miniconda.html)  
```console
~$ cd Documents
~$ bash Miniconda3-latest-Linux-x86_64.sh
~$ sudo apt update
~$ conda update conda
~$ pip install --upgrade pip
```

1. Apparso (base) fisso nel terminale, per disattivarlo
```console
~$ conda config --set auto_activate_base False
~$ source ~/.bashrc
```
per riattivarlo è sufficiente reimpostare *True*

1. Se si ha fatto danno sul .bashrc e lo si vuole ripristinare  
[Soluzione](https://askubuntu.com/a/404428/1092300)  
*There exist backup copies of .bashrc, .profile etc. in /etc/skel/. So one could replace a corrupt .bashrc simply by overwitting from there.*  




## In cerca di una soluzione
1. Custom Nautilus  
Aggiungere "up" button sulla toolbar di Nautilus per Ubuntu 18.04, per ora il backspace è sufficiente :(

1. Escape buggato di Markdown  
se uso `html block highlight e inizio con "<link" si spacca il block.. ci sarà un escape?

1. Escape buggato di Markdown  
se uso qualsiasi block highlight e inizio con " -" si spacca il block.. ci sarà un escape?




...