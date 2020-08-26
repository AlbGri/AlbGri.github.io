---
title: "OpenProject"
excerpt: "Project Management Software"
date: 2020-08-25
tags: [utils, windows, setup]
mathjax: "true"
---


Non supportano [Windows](https://docs.openproject.org/installation-and-operations/operation/faq/#why-dont-you-support-windows), 
quindi lavoriamo con una macchina virtuale con la versione unofficial di Bitnami.  
1. Download [OpenProject 10.6.5-0](https://bitnami.com/stack/openproject/virtual-machine)  
1. Download & Install [VMware Workstation 15.5.6 Player for Windows 64-bit Operating Systems](https://my.vmware.com/web/vmware/downloads/#all_products)  
1. Avvia *bitnami-openproject-10.6.5-0-linux-debian-10-x86_64.vmx* (al primo avvio di VMWare chiede di installare tools utili per la macchina, nb. CTRL+ALT per liberare il cursore)  
1. Login e password: 'bitnami', invio per non cambiare la password e si fa reboot...
1. Avviata il vmx, con un po' di pazienza si avvierà il servizio e restituisce un link in locale da accedere via browser (es. http://192.168.1.240), richiederà il login e necessita 2-5 minuti prima che tutto si avvii.
![png](/assets/images/OpenProject_1.png){ width=50% }
1. Da browser, accedi con Nome utente e password forniti dalla macchina virtuale.
1. Per cambiare password
```console
~$ clear
~$ ls
~$ cat bitnami_credentials
~$ cd apps/openproject/htdocs/
~$ RAILS_ENV=production bundle exec rails c
user = User.find_by(login: 'user')
user.password = 'PASSWORD10'
user.password_confirmation = 'PASSWORD10'
user.save!
```


**Resources**  
1. [Canale youtube OpenProject](https://www.youtube.com/c/OpenProjectCommunity/videos)
1. [Video guida installazione OpenProject con Bitnami di VFX Pipeline](https://www.youtube.com/playlist?list=PLYf4Vz9V1ESpffmoVHt1SmAaY1XpdKCv1)


















...
