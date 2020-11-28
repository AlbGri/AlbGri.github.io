---
title: "Wereables"
excerpt: "Smartbands and Smartwatch"
date: 2020-11-27
tags: [gadget, utils]
---

## Xiaomi Band 5
Smartband economico del 2020

### Export dati via ufficiale da Mi Fit Huami
Da [qui](https://user.huami.com/hm_account/2.0.0/index.html?v=3.7.24&platform_app=com.xiaomi.hm.health#/chooseDestory) si possono scaricare tutti i dati registrati, basta loggare con l'account Mi Fit.

### Modified Mi Fit App
Sperimento una versione modificata della Mi Fit. Quest'app consente anche di ottenere la Auth Key su smartphone che non hanno i privilegi [root](https://it.wikipedia.org/wiki/Root_(utente). Gadgetbridge non suggerisce questa come strada per ottenere l'Auth Key, ma ne propone [altre](https://codeberg.org/Freeyourgadget/Gadgetbridge/wiki/Huami-Server-Pairing#user-content-on-non-rooted-phones).  

Nel sito di [Modified Mi Fit 4.7.0 - All in One](https://geekdoing.com/threads/modified-mi-fit-4-7-0-all-in-one.2528/) descrivono le caratteristiche dell'app.  
[Qui](https://mega.nz/file/A5FUmRKI#pqlbzV4llH9OEVRHS7ZFPqBsiT7vcHQ63p4wI7-8CCs) il link diretto all'apk (per Android 11 c'è un [link](https://mega.nz/file/otUWkRaC#X00jT-GkfhmVWQUfvYhIoy-5rJQPyAUlcnGG5TaGCBA) specifico).  
Dopo qualche settimana di utilizzo ho iniziato a ricevere richieste di amiciza *spam*. Non ho trovato un modo per bloccarle quindi ho disinstallato l'app e sto provando Gadgetbridge.

### Gadgetbridge
[Gadgetbridge](https://gadgetbridge.org/) consente di usare alcuni Smartband senza trasmettere dati alle aziende produttici.
1. Scarico Mi Fit e effettuo la registrazione e il pairing con il dispositivo
2. Disinstallo Mi Fit
3. Scarico 'Modified Mi Fit' ed effettuo login con l'account Mi Fit
	* "Profile" → *Smartband/Smartwatch name* → "Settings".
	* "Save" in "Auth Key".
	* Apri il file explorer, nella cartella "Mi Fit" ci sarà "Inforrmation.txt" con l'authkey
4. Dalla sezione [download](https://f-droid.org/packages/nodomain.freeyourgadget.gadgetbridge/), posso scaricare il client [F-Droid](https://f-droid.org/F-Droid.apk) così aggiorna l'apk automaticamente quando necessario, oppure scarico direttamente l'[apk](https://f-droid.org/repo/nodomain.freeyourgadget.gadgetbridge_182.apk) di Gadgetbridge 
5. Da Gadgetbridge aggiungo l'authkey (senza le virgolette)
0x'incolloilcodice'
6. Ci ha messo qualche minuto, qualche riavvio app/bluetooth e si è sincronizzato.

L'app mi sembra più limitata rispetto alla Mi Fit/Mi Fit Mod, ma non credo di avere alternative.




...
