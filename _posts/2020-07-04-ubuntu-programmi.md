---
title: "(ubuntu) programs"
excerpt: "must have.. for me"
date: 2020-07-04
tags: [utils, linux, ubuntu]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*  

### Programmi
1. [Miniconda](https://conda.io/miniconda.html) e Jupyter Notebook  
```console
bash Miniconda3-latest-Linux-x86_64.sh  
sudo apt-get update  
conda update conda  
pip install --upgrade pip  
conda install jupyter
```

1. [Conky](https://wiki.ubuntu-it.org/AmbienteGrafico/Conky)  
Comandi ([1](http://conky.sourceforge.net/conkyrc-gon), [2](http://conky.sourceforge.net/variables.html)) utili dal sito ufficiale.    
<span style="font-size: 3mm">
Per delay dopo l'avvio del PC, aggiungo in 
<span style="font-size: 3mm">
Startup Applications Preferences → sh -c "sleep 10 && conky"  
</span>
Preview della [configurazione](https://github.com/AlbGri/AlbGri.github.io/blob/master/assets/files/.conkyrc) che uso:  
<img src="{{ site.url }}{{ site.baseurl }}/assets/images/Conky_20200705.png" 
alt="testo IMG"
align="center"
height="328"
width="100">

1. Spotify  
<span style="font-size: 3mm">
Ubuntu Software → Spotify
</span>

1. 7ZIP  
<span style="font-size: 3mm">
Ubuntu Software → P7Zip - Desktop
</span>

1. <span style="text-decoration: line-through">Pinta</span>  
su Ubuntu 18.04 crasha frequentemente, meglio KolourPaint:  
<span style="font-size: 3mm">
Ubuntu Software → KolourPaint
</span>

1. LaTeX  
[Ottima guida](https://linuxconfig.org/how-to-install-latex-on-ubuntu-18-04-bionic-beaver-linux) per LaTeX su 18.04  
```console
sudo apt install texlive-latex-extra  
sudo apt install kile  
```

1. NetHogs  
Programma utile simil firewall per monitorare programmi in entrata e uscita  
```console
sudo apt-get install nethogs  
```

1. Screen recording  
```console
sudo apt-get update
sudo apt-get install gtk-recordmydesktop
```

1. Video conversion  
```console
sudo apt-get install ffmpeg
ffmpeg -i /path/out-1.ogv /path/out-1.mp4
```





### R-statistical software
Come aggiornare R su Ubuntu (18.04)  
Idenficare la [versione](https://cloud.r-project.org/bin/linux/ubuntu) da installare (es. bionic-cran40)  

1. Pulizia versione precedente  
```console
sudo apt-get remove r-base
sudo apt-get remove r-base-core
```

1. (Facoltativo) pulizia più aggressiva  
```console
dpkg --get-selections | grep "^r\-"
sudo apt-get purge r-*
dpkg -l | grep ^ii | awk '$2 ~ /^r-/ { print $2 }'
dpkg -l | grep ^ii | awk '$2 ~ /^r-/ { print $2 }' | sudo xargs apt-get remove --purge -y
```

1. Install key e repository  
```console
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
sudo apt update
sudo apt upgrade
```

1. Identificare il codice versione da installare  
```console
apt-cache showpkg r-base
apt-cache policy r-base
apt-cache madison r-base
```

1. Installare la versione identificata  
```console
sudo apt-get install -f r-base=4.0.0-1.1804.0
```

1. Dopo l'istallazione  
```R
update.packages(checkBuilt = TRUE, ask = FALSE) # Update packages
.libPaths()	# path dei packages
```




















...
