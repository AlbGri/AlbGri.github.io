---
title: "Browser configuration"
excerpt: "Must have extensions and utilities"
date: 2020-09-20
tags: [ubuntu, windows, utils]
mathjax: "true"
---


## Firefox
**Estensioni must have**  
1. [uBlock Origin](https://addons.mozilla.org/it/firefox/addon/ublock-origin/): efficiente, efficace, opensource e aggiornato blocker per la pubblicità, tracker e siti malevoli. Abbandonate Adblock.. ora! (qualche messaggio più in basso spiego perché rimuovere Adblock)
1. [ClearURLs](https://addons.mozilla.org/it/firefox/addon/clearurls/): rimuove il redirect di Google e altri siti. Richiede diversi permessi ma è tutto [giustificato](https://gitlab.com/KevinRoebert/ClearUrls/-/issues/159). Il redirect consiste in una estensione automatica dei link (ad esempio una ricerca su Google) in modo tale da tracciare chi usa quel collegamento. Questo significa che oltre a regalare i dati di dove navighi, rallenti la tua connessione perché prima di raggiungere il sito d'interesse passi dall'intermediario che ti sta tracciando con il link "sporco". Hai mai notato che ogni tanto se copi un collegamento risultante dalla ricerca su Google, questo è molto più lungo e contorto di quello che ti aspettavi?
1. [Privacy Badger](https://addons.mozilla.org/it/firefox/addon/privacy-badger17/): blocca trackers
1. [HTTPS Everywhere](https://addons.mozilla.org/it/firefox/addon/https-everywhere/): il protocollo HTTP manca dei meccanismi di sicurezza, questa estensione forza il sito alla versione HTTPS se presente ma non è il default
1. [Swift Selection Search](https://addons.mozilla.org/en-US/firefox/addon/swift-selection-search/): evidenzia una parola con doppio click, si aprirà un popup che ti da delle opzioni configurabili, come cerca su Google, traduci etc. Qui la mia semplice configurazione, ho modificato solo "Translate to IT" sostituendo la parte finale *en&text={searchTerms}*" in "*it&text={searchTerms}*", così da poter tradurre la parola evidenziata in italiano. Si può aggiungere facilmente anche Context Reverso con la stringa "*https://context.reverso.net/traduzione/inglese-italiano/{searchTerms}*". Personalmente preferisco attivare l'opzione 
<span style="font-size: 3mm">
Popup/icons behaviour → Left mouse button click → Open in new tab (next to current)   
</span>
così si apre in una nuova finestra.
![png](/assets/images/swift_selection_search.png)
1. (Avanzato) [NoScript](https://addons.mozilla.org/it/firefox/addon/noscript/): ogni volta che si naviga un sito si sceglie se considerarlo come TRUSTED oppure si concedono solo alcune caratteristiche. Al primo utilizzo ho configurato tutti i siti pre-impostati TRUSTED in Default e in Appereance ho attivato High contrast per rendere più fruibile il popup. NB: se non si abilita come TRUSTED Google, ClearURLS non funge da clear link (immagino valga anche per Facebook e altri trash-redirect-linkers).

**Estensioni secondarie**  
1. [Gesturefy](https://addons.mozilla.org/it/firefox/addon/gesturefy): permette d'impostare alcuni comandi via mouse, e.g. click dx + click sx torna indietro o click sx + click dx vai avanti etc.
1. [Hard Refresh Button](https://addons.mozilla.org/it/firefox/addon/hard-refresh-button/): refresh della pagina senza uso cache
1. [Facebook Container](https://addons.mozilla.org/it/firefox/addon/facebook-container/): non necessario per me perché uso un browser a parte per usare solo facebook, ma è essenziale per chi usa un solo browser per limitare che facebook tracci la tua attività web.
1. [KeePass](https://addons.mozilla.org/firefox/addon/keefox/): ottimo gestore di password opensource. Non è semplicemente un'estensione ma si incronizza con il programma in locale. Su Ubuntu 18.04 l'installazione è un po' più complessa se si vuole usare [Google Drive](https://www.albgri.com/ubuntu-software/#keepass-2x) per mantenere il database di password online. Su [Windows](https://www.albgri.com/windows10-software/#keepass-2x) c'è una procedura analoga se lo si vuole sincronizzare con Google Drive.
1. [Search by Image](https://addons.mozilla.org/it/firefox/addon/search_by_image/) ricerca l'immagine su Google immagini ed altri simili. Fa risparmiare tempo!

**Estensioni abbandonate**
1. [Ghostery](https://addons.mozilla.org/it/firefox/addon/ghostery/): blocca trackers e velocizza la navigazione, ma a quanto pare è opensource solo dal 2018 e raccoglieva un bel po' di dati. uBlock dicono sia sufficiente, ma Privacy Badger è una buona alternativa, è più sicuro e non va in conflitto con uBlock.
1. [Adblock](https://addons.mozilla.org/it/firefox/addon/adblock-plus/): per una serie di motivi, quali la cattiva gestione della RAM, il parziale blocco delle pubblicità, il fatto che non sia opensource e l'assenza di molteplici security features che ha uBlock, sono motivi sufficienti per rimuoverlo. [Qui](https://www.reddit.com/r/privacy/comments/9a6v0c/why_is_ublock_origin_better_than_adblock/) qualche spunto. Rimuovete Adblock! Amen!


**about:config**
1. Stop autoplay video (must have!)
```raw
media.autoplay.default	5	
media.autoplay.blocking_policy 2
```


## Chrome
1. [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
1. [ClearURLs](https://chrome.google.com/webstore/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk)
1. [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)
1. [HTTPS Everywhere](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp)
1. [Selection Search](https://chrome.google.com/webstore/detail/selection-search/gipnlpdeieaidmmeaichnddnmjmcakoe) alternativa valida a "Swift Selection Search" di Firefox, [qui](https://github.com/CanisLupus/swift-selection-search/issues/148#issuecomment-517942416) il suo creatore spiega perché non ha fatto una versione per Chrome. In alternativa a "Selection Search" ci sono "Trufflepiggy" ma lo eviterei dato che non è opensource e "Simple = Select + Search" però mi sembra troppo rudimentale. Per inserire la funzione di ricerca di Google Translate in "Selection Search", bisogna aggiungere nelle opzioni dell'estensione l'url "https://translate.google.com/#view=home&op=translate&sl=auto&tl=it&text=%s".
1. (Avanzato) [NoScript](https://chrome.google.com/webstore/detail/noscript/doojmbjmlfjjnbmnoijecmcbfeoakpjm)










...
