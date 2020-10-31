---
title: "Ubuntu: software"
excerpt: "must have.. for me"
date: 2020-07-03
tags: [utils, linux, ubuntu, r, setup]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*  

## Programmi
1. [Miniconda](https://conda.io/miniconda.html) e Jupyter Notebook  
```console
~$ bash Miniconda3-latest-Linux-x86_64.sh  
~$ sudo apt-get update  
~$ conda update conda  
~$ pip install --upgrade pip  
~$ conda install jupyter
```

1. [Conky](https://wiki.ubuntu-it.org/AmbienteGrafico/Conky)  
Comandi ([1](http://conky.sourceforge.net/conkyrc-gon), [2](http://conky.sourceforge.net/variables.html)) utili dal sito ufficiale.    
Per l'auto avvio, aggiungo in  
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
in alternativa:  
```console
sudo apt-get install p7zip-full
```

1. <span style="text-decoration: line-through">Pinta</span>  
su Ubuntu 18.04 crasha frequentemente  
<span style="text-decoration: line-through">KolourPaint</span>:  
su Ubuntu 18.04 è esploso dopo un'aggiornamento, meglio il buon vecchio GIMP  
<span style="font-size: 3mm">
Ubuntu Software → GNU Image Manipulation Program
</span>

1. LaTeX  
[Ottima guida](https://linuxconfig.org/how-to-install-latex-on-ubuntu-18-04-bionic-beaver-linux) per LaTeX su 18.04  
```console
~$ sudo apt install texlive-latex-extra
~$ sudo apt install kile
~$ pdflatex hello-world.tex
~$ evince hello-world.pdf
```

1. NetHogs  
Programma utile simil firewall per monitorare programmi in entrata e uscita  
```console
~$ sudo apt-get install nethogs
```

1. Screen recording  
```console
~$ sudo apt-get update
~$ sudo apt-get install gtk-recordmydesktop
```

1. Video conversion  
```console
~$ sudo apt-get install ffmpeg
~$ ffmpeg -i /path/out-1.ogv /path/out-1.mp4
```

1. Thunderbird con accesso a Google Calendar  
[Guida ufficiale](https://support.mozilla.org/en-US/kb/using-lightning-google-calendar)  
[Download](https://addons.thunderbird.net/en-US/thunderbird/addon/provider-for-google-calendar/) del componente aggiuntivo  
Da Thunderbird → App Manager → Installa componente aggiuntivo da file

1. Audacity  
```
~$ sudo add-apt-repository ppa:ubuntuhandbook1/audacity
~$ sudo apt-get update
~$ sudo apt-get install audacity
~$ snap connect gimp:removable-media :removable-media
```
note utili:  
SHIFT+SPACE → Loop  
CTRL+S → Save  
CTR+B → Aggiungi Label Track  

1. PIGZ Compressore Multicore  
```console
~$ sudo apt-get update
~$ sudo apt install pigz
~$ tar --use-compress-program="pigz -9 -k " -cf cartella_compressa.tar.gz cartella
```

1. DupeGuru  
Elimina i doppioni  
```console
~$ sudo add-apt-repository ppa:dupeguru/ppa
~$ sudo apt-get update
~$ sudo apt-get install dupeguru
```
* View → Options → Language: Italian → Ok → Riavvia programma
* [+] → Aggiungi Cartella 
* Più Opzioni: [v] Includi tipi diversi di file
* Più Opzioni: [v] Rimuovi le cartelle vuote dopo aver cancellato o spostato
* Scansiona
* In alto: [v] Solo duplicati
* Marca → Marca tutti
* Azioni → Sposta elementi marcati nel Cestino... → [v] Elimina file direttamente



### Google Drive
Mi sarebbe piaciuto usare il default di GNOME (Settings → Online Accounts → Google) per la sincronizzazione di Drive, ma la cartella che crea ha dei path non leggibili da KeePass (/run/user/1000/gvfs/google-drive:host=gmail.com,user=nomeutente).  
Uso quindi [google-drive-ocamlfuse](https://github.com/astrada/google-drive-ocamlfuse) che non sincronizza il contenuto in locale ma monta Google Drive remoto in una cartella del file system integrandosi perfettamente con tutti i file manager (Nautilus, Dolphin, Nemo, ...). Inoltre, consente di sincronizzare più account Google Drive.  
```console
sudo add-apt-repository ppa:alessandro-strada/ppa
sudo apt-get update
sudo apt-get install google-drive-ocamlfuse
```
Stabilisco path per la cartella di google drive da sincronizzare  
```console
mkdir ~/Documents/google-drive
google-drive-ocamlfuse ~/Documents/google-drive
```
Per smontare il collegamento  
```console
fusermount -u ~/Documents/google-drive
```
Per fare il mount in automatico segui [questa](https://github.com/astrada/google-drive-ocamlfuse/wiki/Automounting) guida oppure aggiungi  
<span style="font-size: 3mm">
Startup Applications Preferences → sh -c "sleep 30 && google-drive-ocamlfuse ~/Documents/google-drive"  
</span>

<img src="/assets/images/automount_gdrive.png" width="400">



### KeePass 2.x
Installazione KeePass su Ubuntu 18.04 con configurazione [Kee](https://forum.kee.pm/t/installing-kee-with-keepassrpc-for-keepass-password-safe-instructions/23) nel browser  
```console
sudo apt-add-repository ppa:jtaylor/keepass
sudo apt-get update
sudo apt-get install mono-complete
sudo apt-get install keepass2
```
Per il corretto funzionamento via browser bisogna scaricare [KeePassRPC.plgx](https://github.com/kee-org/keepassrpc/releases/latest) e aggiungerlo alla cartella Plugins  
```console
cd /usr/lib/keepass2/Plugins
sudo wget https://github.com/kee-org/keepassrpc/releases/download/v1.14.0/KeePassRPC.plgx
```
Estensione [Firefox](https://addons.mozilla.org/firefox/addon/keefox/) o [Chrome](https://chrome.google.com/webstore/detail/kee/mmhlniccooihdimnnjhamobppdhaolme)  
Installata l'estensione mi chiede di creare un nuovo db o caricarne uno, in questo caso ne creo uno e lo sincronizzo su Google Drive mediante la cartella [precedentemente costruita](https://www.albgri.com/ubuntu-software/#google-drive) in documents. Conviene seguire il [tutorial](https://tutorial-addon.kee.pm/) di kee se è la prima volta che lo si utilizza.  
Tutte le password create verranno automaticamente sincronizzate nel db creato su Google Drive.  
[![Foo](https://imgs.xkcd.com/comics/password_strength.png)](https://xkcd.com/936/)






### R-statistical software
#### Aggiornare R su Ubuntu (18.04)
Quando il semplice apt upgrade non aggiorna R, questi step possono essere utili.  
Idenficare la [versione](https://cloud.r-project.org/bin/linux/ubuntu) da installare (es. bionic-cran40)  

1. Pulizia versione precedente  
```console
~$ sudo apt-get remove r-base
~$ sudo apt-get remove r-base-core
```

1. (Facoltativo) pulizia più aggressiva  
```console
~$ dpkg --get-selections | grep "^r\-"
~$ sudo apt-get purge r-*
~$ dpkg -l | grep ^ii | awk '$2 ~ /^r-/ { print $2 }'
~$ dpkg -l | grep ^ii | awk '$2 ~ /^r-/ { print $2 }' | sudo xargs apt-get remove --purge -y
```

1. Install key e il repository della versione d'interesse  
```console
~$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
~$ sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
~$ sudo apt update
~$ sudo apt upgrade
```

1. Identificare il codice versione da installare  
```console
~$ apt-cache showpkg r-base
~$ apt-cache policy r-base
~$ apt-cache madison r-base
```

1. Installare la versione identificata  
```console
~$ sudo apt-get install -f r-base=4.0.0-1.1804.0
```

1. Dopo l'istallazione  
```R
update.packages(checkBuilt = TRUE, ask = FALSE) # Update packages
.libPaths()	# path dei packages
```

#### Errore Signature Verification
L'apt get update restituisce errore sulla signature verification, [qui](https://cran.r-project.org/bin/linux/ubuntu/README.html#secure-apt) e [qua](https://www.bentoh.my/post/gpg-key-problem/) link utili.  
```raw
W: An error occurred during the signature verification. The repository is not updated and the previous index files will be used. GPG error: https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/ InRelease: The following signatures were invalid: EXPKEYSIG 51716619E084DAB9 Michael Rutter <marutter@gmail.com>
W: Failed to fetch https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran40/InRelease  The following signatures were invalid: EXPKEYSIG 51716619E084DAB9 Michael Rutter <marutter@gmail.com>
W: Some index files failed to download. They have been ignored, or old ones used instead.
```

```console
sudo apt-key list
```

```raw
pub   rsa2048 2010-10-19 [SCA] [expired: 2020-10-16]
      E298 A3A8 25C0 D65D FD57  CBB6 5171 6619 E084 DAB9
uid           [ expired] Michael Rutter <marutter@gmail.com>

/etc/apt/trusted.gpg.d/alessandro-strada_ubuntu_ppa.gpg
```
Expired! La rimuovo e aggiungo

```console
sudo apt-key del "E298 A3A8 25C0 D65D FD57 CBB6 5171 6619 E084 DAB9"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo apt-key list
```

Ora è aggiornato
```raw
pub   rsa2048 2010-10-19 [SCA] [expires: 2027-09-30]
      E298 A3A8 25C0 D65D FD57  CBB6 5171 6619 E084 DAB9
uid           [ unknown] Michael Rutter <marutter@gmail.com>
sub   rsa2048 2010-10-19 [E] [expires: 2027-09-30]

/etc/apt/trusted.gpg.d/alessandro-strada_ubuntu_ppa.gpg
```


















...
