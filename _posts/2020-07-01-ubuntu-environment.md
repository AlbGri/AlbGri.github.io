---
title: "Ubuntu: environment"
excerpt: "improving it"
date: 2020-07-01
tags: [utils, linux, ubuntu]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*  

## Customizzazione ambiente
1. Aggiungi data, minuti e secondi nella barra superiore  
```console
~$ sudo apt install gnome-tweak-tool
~$ gnome-tweaks
```
<span style="font-size: 3mm">
→ Top Bar → Date</span>

1. Aggiungi il tasto di mostra desktop  
<span style="font-size: 3mm">
Ubuntu Software → Show Desktop Button
</span>

1. Aggiungi Shortcut per mostra desktop  
<span style="font-size: 3mm">
Settings → Keyboard → Navigation → Hide all normal windows → Super and D
</span>

1. Aggiungi widget weather  
<span style="font-size: 3mm">
Ubuntu Software → OpenWeather
</span>

1. Cambia alt-tab switcher  
<span style="font-size: 3mm">
System →  Keyboard → Switch windows direcly → Alt+Tab
</span>

1. Aggiungi tasto destro create nuovo .txt  
```console
~$ touch ~/Templates/Empty\ Document
```

1. Disabilita aggiornamenti  
<span style="font-size: 3mm">
Software & Updates →  Updates → Automatically... → Never!
</span>

1. Disabilita aggiornamenti secondari  
```console
~$ sudo dpkg-reconfigure unattended-upgrades
```

1. Cambia velocità cursore  
```console
~$ xset m 3/2 1
```

1. Rimuovi Mozilla Thunderbird  
```console
~$ sudo apt-get remove --purge thunderbird -y
```

1. Nautilus top address bar  
```console
~$ dconf write /org/gnome/nautilus/preferences/always-use-location-entry true
```

1. Gedit Themes/Styles  
```console
~$ sudo nautilus '/usr/share/gtksourceview-3.0/styles'
```
[Qui](https://github.com/AlbGri/AlbGri.github.io/raw/master/assets/files/gedit_themes.zip) una collezione oppure [qui](https://raw.githubusercontent.com/AlbGri/AlbGri.github.io/master/assets/files/alb_gedit_theme.xml) quello che uso io.

1. Come montare unità exFAT su Ubuntu Linux  
```console
~$ sudo apt-get install exfat-fuse exfat-utils
~$ sudo apt install exfat-fuse exfat-utils
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

1. Washed out colors  
Si vedono i colori sbiaditi, dal pannello di NVIDIA → GPU 0 → HDMI-0 → Color Controls → Color Range: Limited  
<img src="{{ site.url }}{{ site.baseurl }}/assets/images/NVIDIA_colors.png" 
alt="testo IMG"
align="center"
height="426"
width="408">

1. Orologio sfasato al cambio Ubuntu/Windows  
```console
timedatectl
timedatectl set-local-rtc 1 --adjust-system-clock
date
```
Settings → Date & Time → Disable Automatic Date & Time  
Settings → Date & Time → Enable Automatic Date & Time  
Da Windows apri l'orologio disattivi e attivi la sincronizzazione online dell'ora.








## In cerca di una soluzione
1. Custom Nautilus  
Aggiungere "up" button sulla toolbar di Nautilus per Ubuntu 18.04, per ora il backspace è sufficiente :(

1. Escape buggato di Markdown  
se uso `html block highlight e inizio con "<link" si spacca il block.. ci sarà un escape?

1. Escape buggato di Markdown  
se uso qualsiasi block highlight e inizio con " -" si spacca il block.. ci sarà un escape?

1. Le icone del desktop si sovrappongono.  
Sembra essere un bug esistente dal 2005 che non è stato risolto.. fantastico /s.









...
