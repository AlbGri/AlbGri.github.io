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
Sperimento una versione modificata della Mi Fit.  
Quest'app consente anche di ottenere la Auth Key su smartphone che non hanno i privilegi [Root](https://it.wikipedia.org/wiki/Root_(utente)). Gadgetbridge non suggerisce questa come strada per ottenere l'Auth Key, ma ne propone [altre](https://codeberg.org/Freeyourgadget/Gadgetbridge/wiki/Huami-Server-Pairing#user-content-on-non-rooted-phones).  

Nel sito di [Modified Mi Fit 4.7.0 - All in One](https://geekdoing.com/threads/modified-mi-fit-4-7-0-all-in-one.2528/) descrivono le caratteristiche dell'app (la più comoda è che le notifiche si raggruppano e non rimangono singole).  
[Qui](https://mega.nz/file/A5FUmRKI#pqlbzV4llH9OEVRHS7ZFPqBsiT7vcHQ63p4wI7-8CCs) il link diretto all'apk (per Android 11 c'è un [link](https://mega.nz/file/otUWkRaC#X00jT-GkfhmVWQUfvYhIoy-5rJQPyAUlcnGG5TaGCBA) specifico).  
Dopo qualche settimana di utilizzo ho iniziato a ricevere richieste di amiciza *spam*. Non ho trovato un modo per bloccarle quindi ho disinstallato l'app e sto provando Gadgetbridge.

### Gadgetbridge
[Gadgetbridge](https://gadgetbridge.org/) consente di usare alcuni Smartband senza trasmettere dati alle aziende produttici.  
L'app è un po' più complessa della Mi Fit ma sembra essere completa

#### Setup
1. Scarico [Mi Fit](https://play.google.com/store/apps/details?id=com.xiaomi.hm.health) e effettuo la registrazione e il pairing con il dispositivo
1. Disinstallo Mi Fit
1. Scarico [Modified Mi Fit](https://www.albgri.com/wearables/#modified-mi-fit-app) ed effettuo login con l'account Mi Fit
	* "Profile" → *Smartband/Smartwatch name* → "Settings".
	* "Save" in "Auth Key".
	* Apri il file explorer, nella cartella "Mi Fit" ci sarà "Inforrmation.txt" con l'authkey
1. Disinstallo Modified Mi Fit
1. Dalla sezione [download](https://f-droid.org/packages/nodomain.freeyourgadget.gadgetbridge/), posso scaricare il client [F-Droid](https://f-droid.org/F-Droid.apk) così aggiorna l'app Gadgetbridge automaticamente quando necessario, oppure scarico direttamente l'[apk](https://f-droid.org/repo/nodomain.freeyourgadget.gadgetbridge_182.apk) (occhio a scaricare l'ultima che il link che ho messo potrebbe essere di una vecchia versione) di Gadgetbridge 
1. Da Gadgetbridge aggiungo l'Auth Key precedentemente esportato (senza le virgolette)
0x'incolloilcodice'
1. Ci ha messo qualche minuto, qualche riavvio app/bluetooth e si è sincronizzato.
1. *In impostazioni app android concedo tutti i permessi all'app Gadgetbridge*

#### Weather Notification
Per aggiungere il meteo bisogna seguire [questa](https://codeberg.org/Freeyourgadget/Gadgetbridge/wiki/Weather) guida.
1. Come Gadgetbridge dalla sezione [download](https://f-droid.org/en/packages/ru.gelin.android.weather.notification/), posso scaricare il client F-Droid o l'[apk](https://f-droid.org/repo/ru.gelin.android.weather.notification_60.apk) di Weather Notification (occhio a scaricare l'ultima che il link che ho messo potrebbe essere di una vecchia versione)
2. Il sito di [OpenWeather](https://openweathermap.org/) è incredibilmente ben fatto, e mi devo registrare per ottenere le API da utilizzare sull'app che poi si sincronizza con Gadgetbridge. Quindi mi [iscrivo](https://home.openweathermap.org/users/sign_up).
3. [Genero una API](https://home.openweathermap.org/api_keys) con nome Android (non è obbligatorio ma preferisco non usare quella di default). Dalla mail ricevuta in fase di iscrizione, le API si attivano in un paio di ore. L'aggiungo nella sezione 'API key' dell'app.
4. Dall'app Weather Notification/Notifiche meteo, attivo le notifiche e la Skin Gadgetbridge




...
