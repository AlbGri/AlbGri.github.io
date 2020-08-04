---
title: "Ubuntu: environment"
excerpt: "improving it"
date: 2020-07-01
tags: [utils, linux, ubuntu]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*  

### Customizzazione ambiente
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













...
