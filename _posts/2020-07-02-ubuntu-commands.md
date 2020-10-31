---
title: "Ubuntu: commands"
excerpt: "useful commands"
date: 2020-10-30
tags: [utils, linux, ubuntu, bugs, bash]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*  

## Utili
1. Crea cartella  
```console
~$ mkdir -p ~/Downloads/nuova_cartella/nuova_sottocartella
```

1. Trova testo dentro tutti i documenti nel path  
```console
~$ grep -r testoDaCercare *
```

1. Trova file/cartelle  
```console
~$ sudo find / -type d -name "nome"
~$ sudo find . -type d | grep nome
```

1. Trova cartella  
```console
~$ find -name "nomeCartella"
```

1. Elimina caretelle vuote  
```console
~$ cd ~/Downloads
~$ find . -empty -type d -delete
```

1. Trova interattivamente il processo PID di un programma e terminarlo  
```console
~$ xprop _NET_WM_PID
~$ kill -9 5186
```

1. Processi attivi su USB
```console
~$ lsof | grep /media/usaTabPerAutocompletamento
~$ lsof +f -- /media/unknown/usaTabPerAutocompletamento
```

1. Controlla tutti i programmi installati  
```console
~$ dpkg -l
~$ sudo dpkg -l | grep -i nomeprogramma
```

1. Verifica se il programma specifico è installato  
```console
~$ apt list --installed firefox
```

1. Screenshots  
![png](/assets/images/screenshot_ubuntu.png)

1. Apri il cestino con privilegi root  
```console
~$ sudo nautilus /home/unknown/.local/share/Trash
```

1. Modifica sources  
```console
~$ sudo gedit /etc/apt/sources.list
```

1. Trova e modifica PATH  
```console
~$ echo $PATH
~$ sudo gedit /etc/environment
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







...
