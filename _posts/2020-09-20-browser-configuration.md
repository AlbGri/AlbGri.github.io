---
title: "Browser configuration"
excerpt: "Must have extensions and utilities"
date: 2020-10-31
tags: [ubuntu, windows, utils]
mathjax: "true"
---


## Firefox
**Estensioni must have**  
1. [uBlock Origin](https://addons.mozilla.org/it/firefox/addon/ublock-origin/): efficiente, efficace, opensource e aggiornato blocker per la pubblicità, tracker e siti malevoli. Abbandonate Adblock.. ora! (qualche messaggio più in basso spiego perché rimuovere Adblock)
1. [ClearURLs](https://addons.mozilla.org/it/firefox/addon/clearurls/): rimuove il redirect di Google e altri siti. Richiede diversi permessi ma è tutto [giustificato](https://gitlab.com/KevinRoebert/ClearUrls/-/issues/159). Il redirect consiste in una estensione automatica dei link (ad esempio una ricerca su Google) in modo tale da tracciare chi usa quel collegamento. Questo significa che oltre a regalare i dati di dove navighi, rallenti la tua connessione perché prima di raggiungere il sito d'interesse passi dall'intermediario che ti sta tracciando con il link "sporco". Hai mai notato che ogni tanto se copi un collegamento risultante dalla ricerca su Google, questo è molto più lungo e contorto di quello che ti aspettavi? Un'alternativa valida (un po' meno perché non è monitorata attivamente da Mozilla) è [Neat URL](https://addons.mozilla.org/it/firefox/addon/neat-url).
1. [Privacy Badger](https://addons.mozilla.org/it/firefox/addon/privacy-badger17/): blocca trackers
1. [HTTPS Everywhere](https://addons.mozilla.org/it/firefox/addon/https-everywhere/): il protocollo HTTP manca dei meccanismi di sicurezza, questa estensione forza il sito alla versione HTTPS se presente ma non è il default
1. [Swift Selection Search](https://addons.mozilla.org/en-US/firefox/addon/swift-selection-search/): evidenzia una parola con doppio click, si aprirà un popup che ti da delle opzioni configurabili, come cerca su Google, traduci etc. Qui la mia semplice configurazione, ho modificato Google Translate sostituendo la parte finale del default 
<span style="font-size: 3mm">en&text={searchTerms}</span> 
in 
<span style="font-size: 3mm">it&text={searchTerms}</span>
, così da poter tradurre la parola evidenziata in italiano. Si può aggiungere facilmente anche Context Reverso con la stringa 
<span style="font-size: 3mm">https://context.reverso.net/traduzione/inglese-italiano/{searchTerms}</span>
. Personalmente preferisco attivare la seguente opzione per aprire il risultato della ricerca in una nuova finestra: 
<span style="font-size: 3mm">
Popup/icons behaviour → Left mouse button click → Open in new tab (next to current) 
</span>
![png](/assets/images/swift_selection_search.png)
1. [Drag-Select Link Text](https://addons.mozilla.org/it/firefox/addon/drag-select-link-text): permette di selezionare agevolmente gli hyperlink senza aprirli. Nella gif si può notare anche il popup di "Swift Selection Search"
![gif](/assets/images/browser-configuration_DragSelectLinkText.gif)
1. (Avanzato) [NoScript](https://addons.mozilla.org/it/firefox/addon/noscript/): ogni volta che si naviga un sito si sceglie se considerarlo come TRUSTED oppure si concedono solo alcune caratteristiche. Al primo utilizzo ho configurato tutti i siti pre-impostati TRUSTED in Default e in Appereance ho attivato High contrast per rendere più fruibile il popup.  
NB1: se non si abilita come TRUSTED Google, ClearURLS non funge da clear link (immagino valga anche per Facebook e altri track-redirect-linkers).  
NB2: alcuni siti (tipo uno di un famoso italiano che crea guide, o di un famoso portale italiano di matematica) si appoggiano ad aziende come _iubenda_ che consentono tramite un javascript di ottenere informazioni sulle tue estensioni, ad esempio se usi un adblocker, e bloccano la pagina fintanto che non disattivi tale adblocker. Quindi, rimossi eventuali cookie, l'utilizzo di ublock più il blocco dello script di iubenda consente la visione di tali siti in modo agevole.

**Estensioni secondarie**  
1. [Load timer](https://addons.mozilla.org/it/firefox/addon/load-timer): mostra in modo dettagliato i secondi necessari per accedere ad una pagina web. Molto minimale. [Qui](https://github.com/alex-vv/page-load-time) il repository del suo creatore.
1. [Gesturefy](https://addons.mozilla.org/it/firefox/addon/gesturefy): permette d'impostare alcuni comandi via mouse (es. tasto destro su per andare top page) e di abilitare le Rocker gesture (click dx + click sx torna indietro o click sx + click dx vai avanti), purtroppo alcune pagine tipo la home di Firefox, o la pagina delle estensioni sono [bloccate](https://www.reddit.com/r/firefox/comments/erharo/is_there_a_way_to_remove_extension_blocks_from/).  
Nota: queste caratteristiche sono native in Opera da 15 anni.. /sob
1. [Hard Refresh Button](https://addons.mozilla.org/it/firefox/addon/hard-refresh-button/): refresh della pagina senza uso cache
1. [Facebook Container](https://addons.mozilla.org/it/firefox/addon/facebook-container/): non necessario per me perché uso un browser a parte per usare solo facebook, ma è essenziale per chi usa un solo browser per limitare che facebook tracci la tua attività web.
1. [KeePass](https://addons.mozilla.org/firefox/addon/keefox/): ottimo gestore di password opensource. Non è semplicemente un'estensione ma si sincronizza con il programma in locale. Su Ubuntu 18.04 l'installazione è un po' più complessa se si vuole usare [Google Drive](https://www.albgri.com/ubuntu-software/#keepass-2x) per mantenere il database di password online. Su [Windows](https://www.albgri.com/windows10-software/#keepass-2x) c'è una procedura analoga se lo si vuole sincronizzare con Google Drive.
1. [Search by Image](https://addons.mozilla.org/it/firefox/addon/search_by_image/) ricerca l'immagine su Google Immagini ed altri simili. Fa risparmiare tempo! Sapete cosa è il [Reverse image search](https://en.wikipedia.org/wiki/Reverse_image_search)?

**Estensioni abbandonate**
1. [Ghostery](https://addons.mozilla.org/it/firefox/addon/ghostery/): blocca trackers e velocizza la navigazione, ma a quanto pare è opensource solo dal 2018 e raccoglieva un bel po' di dati. uBlock dicono sia sufficiente, ma Privacy Badger è una buona alternativa, è più sicuro e non va in conflitto con uBlock.
1. [Adblock](https://addons.mozilla.org/it/firefox/addon/adblock-plus/): per una serie di motivi, quali la cattiva gestione della RAM, il parziale blocco delle pubblicità, il fatto che non sia opensource e l'assenza di molteplici security features che ha uBlock, sono motivi sufficienti per rimuoverlo. [Qui](https://www.reddit.com/r/privacy/comments/9a6v0c/why_is_ublock_origin_better_than_adblock/) qualche spunto. Rimuovete Adblock! Amen!


**about:config**
1. Stop autoplay video (must have!!)
```raw
media.autoplay.default	5	
media.autoplay.blocking_policy 2
```

1. Fingerprinting
```raw
privacy.resist	true
```

### Utili
1. Se Whatsapp Web non permette di inviare immagini, neanche copiando e incollando, il risultato è un'immagine oscurata/blurred/white noise.  
Per risolvere è sufficiente consentire l'accesso a HTML5 canvas.
![png](/assets/images/Firefox_Whatsapp_1.png)  
![png](/assets/images/Firefox_Whatsapp_2.png)


## Chrome
nb. ho riportato solo alcune delle estensioni Firefox che utilizzo.
1. [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
1. [ClearURLs](https://chrome.google.com/webstore/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk)
1. [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)
1. [HTTPS Everywhere](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp)
1. [Selection Search](https://chrome.google.com/webstore/detail/selection-search/gipnlpdeieaidmmeaichnddnmjmcakoe) alternativa valida a "Swift Selection Search" di Firefox, [qui](https://github.com/CanisLupus/swift-selection-search/issues/148#issuecomment-517942416) il suo creatore spiega perché non ha fatto una versione per Chrome. In alternativa a "Selection Search" ci sono "Trufflepiggy" ma lo eviterei dato che non è opensource e "Simple = Select + Search" però mi sembra troppo rudimentale. Per inserire la funzione di ricerca di Google Translate in "Selection Search", bisogna aggiungere nelle opzioni dell'estensione l'url 
<span style="font-size: 3mm">https://translate.google.com/#view=home&op=translate&sl=auto&tl=it&text=%s</span>
.
1. (Avanzato) [NoScript](https://chrome.google.com/webstore/detail/noscript/doojmbjmlfjjnbmnoijecmcbfeoakpjm)


**Google ha rimosso da Chrome la possibilità di interrompere l'autoplay dei video e occorre installare una [estensione](https://chrome.google.com/webstore/detail/autoplaystopper/ejddcgojdblidajhngkogefpkknnebdh) di dubbia provenienza e di dubbia efficacia! Disinstallate Chrome!**


## Incognito
Per creare un collegamento che apra direttamente il browser in modalità anonima, prima bisogna copiare il collegamento del browser d'interesse e modificarne le *Proprietà → Destinazione*  
```raw
Firefox: "path\firefox.exe" -private-window
Chrome: "path\chrome.exe" -incognito
Edge: "path\msedge.exe" -inprivate
Opera: "path\Opera\launcher.exe" -private
Explorer: "path\iexplore.exe" -private
```



...
