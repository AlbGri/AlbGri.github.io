---
title: "(ubuntu) commands"
excerpt: "utils, issues"
date: 2020-07-04
tags: [utils, linux, ubuntu, issues, bugfix, goal]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*  

### Utili
1. Trova interattivamente il PID di un programma e terminarlo  
```console
xprop _NET_WM_PID
kill -9 5186
```

1. Controlla tutti i programmi installati  
```console
dpkg -l
sudo dpkg -l | grep -i nomeprogramma
```

1. Trova e modifica PATH  
```console
echo $PATH
sudo gedit /etc/environment
```

1. Trova file/cartelle  
```console
cd /
sudo find / -type d -name "nome"
sudo find . -type d | grep nome
```

1. Trova testo dentro il path  
```console
grep -r WORD *
```

1. Screenshots  
Prt Scrn to take a screenshot of the desktop.  
Alt + Prt Scrn to take a screenshot of a window.  
Shift + Prt Scrn to take a screenshot of an area you select.  

1. Modifica sources  
```console
sudo gedit /etc/apt/sources.list
```

1. Rimuovi cache (da usare solo se necessario)  
```console
sudo apt-get update
sudo apt-get clean --dry-run
sudo apt-get clean
sudo apt-get autoclean --dry-run
sudo apt-get autoclean
sudo apt-get autoremove
```


### Issues & Bugs
1. BugFix  
"System program problem detected"  
"Do you want to report the problem now?"  
```console
sudo gedit /etc/default/apport
enabled=0
```

1. Windows Partition Permissions  
Da Ubuntu, con i permessi di scrittura sul disco con partizione Windows 10 non riuscivo a fare modifiche ai file.  
Problema *ibernazione attiva*.  
[Soluzione](https://support.microsoft.com/it-it/help/920730/how-to-disable-and-re-enable-hibernation-on-a-computer-that-is-running) cmd con privilegi d'amministratore  
```bash
powercfg.exe /hibernate off
```

2. Bugged Thunderbird connection  
<span style="font-size: 3mm">
Edit → Preferences → General Tab → General screen → "Advanced" tab → "General" subtab → lower right corner find the button "Config Editor" → ok the warning → set "general.useragent.compatMode.firefox" to true (found in Edit/Preferences/Advanced/General/Config Editor)
</span>


### In cerca di una soluzione
1. Custom Nautilus  
Aggiungere "up" button sulla toolbar di Nautilus per Ubuntu 18.04, per ora il backspace è sufficiente :(



...
