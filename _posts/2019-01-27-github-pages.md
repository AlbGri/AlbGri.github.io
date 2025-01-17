---
title: "GitHub pages"
excerpt: "how to"
date: 2020-10-29
tags: [github, pages, ubuntu, utils]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*  

Installa GitHub Desktop per [Linux](https://aur.archlinux.org/packages/github-desktop-bin/)  
è sufficiente scaricare il .deb ed installarlo.

## GitHub
Trova il repository per la web page che ti [interessa](https://github.com/mmistakes/minimal-mistakes)  
**Fork!** In alto a destra, il comando Fork ne farà una copia nel tuo profilo GitHub  
Nota: il fork te lo porti a vita, quindi forse meglio clonare il repository, almeno nella condivisone social non ti appare la preview di minimal mistakes invece del proprio sito (e che cazz).  
Clonare un Git da Ubuntu 18.04:  
1. Crea il repo da github (es clone.git)
2. Scarica il repo che ti interessa
```console
cd Downloads
git clone --bare https://github.com/AlbGri/AlbGri.github.io.git
```
3. Terminale nella cartella del repo e mirror it
```console
cd AlbGri.github.io.git
git push --mirror https://github.com/AlbGri/clone.git
```
4. Rimuovi la cartella del vecchio .git

Imposta il repo come la tua page  
<span style="font-size: 3mm">
Settings →  Repository name → "AlbGri.github.io"  
</span>

## Configurare il dominio (google domain)
1. Google Domain, compro il dominio, 12 euro all'anno. [Questo mi piace](https://support.google.com/domains/answer/3251242?hl=en).
2. da GitHub repository  
<span style="font-size: 3mm">
Settings → GitHub Pages → Custom domain → "www.[nomedacomprare].com"  
</span>
3. da Google Domain  
<span style="font-size: 3mm">
DNS → Custom resource records → [][A][][185.199.***.153] [Link per gli IP](https://help.github.com/articles/setting-up-an-apex-domain/#configuring-a-records-with-your-dns-provider)  
</span>
4. da Google Domain  
<span style="font-size: 3mm">
DNS → Custom resource records → [www][CNAME][][AlbGri.github.io]  
</span>
5. da GitHub repository  
<span style="font-size: 3mm">
Settings → GitHub Pages → Custom domain → Enforce HTTPS  
</span>
6. Verifica se sito e DNS sono up  
```console
dig albgri.com +noall +answer
dig www.albgri.com +nostats +nocomments +nocmd
ping albgri.com
```

## Note Pages
Jakyll e Minimal Mistakes  
1. [Cambiare le dimensioni del testo](https://github.com/mmistakes/minimal-mistakes/issues/1043)  

1. [Aggiugnere data agli articoli](https://github.com/dvhart/dvhart.github.io/blob/master/_includes/archive-single.html)  

1. Math $$\LaTeX$$  
dentro *"_includes\script.html"* aggiungere questo script alla fine. Nei post in cui si vogliono includere le formule, nell'header va aggiunto *mathjax: "true"*  
```html
{% raw %}{% if page.mathjax %}{% endraw %}
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    TeX: {
      equationNumbers: { autoNumber: "AMS" },
      tagSide: "right"
    },
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
      processEscapes: true
    }
  });
  MathJax.Hub.Register.StartupHook("TeX AMSmath Ready", function () {
    MathJax.InputJax.TeX.Stack.Item.AMSarray.Augment({
      clearTag() {
        if (!this.global.notags) {
          this.super(arguments).clearTag.call(this);
        }
      }
    });
  });
</script>
<script type="text/javascript" charset="utf-8"
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
{% raw %}{% endif %}{% endraw %}
```

1. Aggiungere la favicon  
Incolli "favicon.png" nella root del repository, poi in *_includes/head.html* aggiungi la stringa [linkata](https://stackoverflow.com/a/34348243).  
Non ho potuto fare l'highlight html block perché è buggato con l'inizio di quella stringa :(  


1. Personalizzare il Markdown flavour  
Definita una skin nel *'_config.yml'* (es. minimal_mistakes_skin: "contrast" )  
andiamo a personalizzare il file *'_sass/minimal-mistakes/skin/_contrast.scss'* le cui variabili influenzeranno i parametri di *'_sass/minimal-mistakes/_variables.scss'*  
```scss
/* contrast syntax highlighting (base16) */
$base00: #101218 !default;  // background
$base01: #1f222d !default;
$base02: #252936 !default;
$base03: #7780a1 !default;
$base04: #33bf2e !default;  // commenti
$base05: #ffffff !default;  // testo, punteggiatura
$base06: #C9CCDB !default;
$base07: #ffffff !default;
$base08: #ee829f !default;  // error
$base09: #f99170 !default;
$base0a: #ffefcc !default;
$base0b: #a5ffe1 !default;
$base0c: #97e0ff !default;
$base0d: #97bbf7 !default;
$base0e: #c0b7f9 !default;
$base0f: #fcc09e !default;
```

1. Abilitare il numero riga  
[Line number con rouge, minimal mistakes, jakyll](https://github.com/jekyll/jekyll/issues/4619#issuecomment-191267346)  

1. Markdown Link  
*(BUG/Feature)* Se non si specifica 'https://' il link indirizza in un sotto percorso del sito. [Esempio](www.google.com)

1. Aggiungere icona spotify (o altro) alla home  
* */_includes/author-profile.html*  
```html
{% raw %}{% if author.spotify %}{% endraw %}
        <li>
          <a href="https://open.spotify.com/user/{{ author.spotify }}" itemprop="sameAs" rel="nofollow noopener noreferrer">
            <i class="fab fa-fw fa-spotify" aria-hidden="true"></i><span class="label">Spotify</span>
          </a>
        </li>
{% raw %}{% endif %}{% endraw %}
```
* */_sass/minimal-mistakes/_variables.scss*  
```scss
$spotify-color: #00d867 !default;
```
* */_sass/minimal-mistakes/_utilities.scss*  
```scss
  .fa-spotify,
  .fa-spotify-square {
    color: $xing-color;
  }
```
* */_config.yml*  
```xml
# Site Author3
      label: "Spotify"
      icon: "fab fa-fw fa-spotify"
      url: "https://open.spotify.com/user/albgri"
```
1. Evitare il doppio slash nell'url del post  
nel *_config.yml* nella voce url c'era il proprio sito con slash "/" finale. Va rimosso!

1. Se si aggiorna il repo da una fonte diversa, ricordarsi da GitHub Desktop di cliccare su Fetch origin prima di lavorare, così da sincronizzare il repo localmente

1. Popup nascosto (text expand markdown jekyll)  
per generare [questo](https://chrisphillips-cminion.github.io/jekyll/2019/07/12/CollapseInJekyll.html) tipo di spoiler popup.  
    - Ho inserito il codice di quell'articolo nel file  
    _/_includes/Collapse.html_
    - Aggiunto `{% raw %}{% include Collapse.html %}{% endraw %}` prima dell'ultimo `body` in  
    _/_layouts/default.html_
    - Per rendere chiuso di default il popup, ho inserito dentro la skin  
    _/_sass/minimal-mistakes/skins/_nomeskin.scss_  
    che utilizzo (quella che in _/_config.yml_ è presente alla voce `minimal_mistakes_skin`) il seguente codice (preso spunto da [qui](https://www.nuomiphp.com/eplan/en/214045.html))  
    ```scss
    .content {
      padding: 0 18px;
      display: none;
      overflow: hidden;
    }
    ```
    - Purtroppo il risultato non segue l'highlight dei codici.

1. Titoli colorati  
in _/_sass/minimal-mistakes/_base.css_ posso configurare i colori dei titoli impostando il parametro color nel blocco codice relativo a h1, h2, etc.


## Google Setup
1. Search Engine Google: utilizzo google search nel search bar del sito  
* Crea il tuo [Search Engine Google](https://programmablesearchengine.google.com/cse/all)  
* Ottieni il tuo cx  
```xml
000000000000000000000:xxxxxxxxxxx
```
* Modifica il *_config.yml* sostituendo  
```xml
search_provider        : google
search_engine_id       : 000000000000000000000:xxxxxxxxxxx
```
1. Configura proprietario sito  
[Search Console Google](https://search.google.com/search-console/about)  
Nel caso non riconosce in automatico che si è proprietari, prova [questa](https://victor2code.github.io/blog/2019/07/04/jekyll-github-pages-appear-on-Google.html) guida  
1. Rimuovere pagine rotte nella cache di google
[Removal](https://www.google.com/webmasters/tools/removals) [Google](https://search.google.com/search-console/remove-outdated-content)  
Cerca su google "site:*tuodominio*" per trovare le pagine scadute indicizzate e richiederne la rimozione  




...















