---
title: "github pages"
excerpt: "how to"
date: 2019-01-27
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
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
{% raw %}{% endif %}{% endraw %}
```

1. Aggiungere la favicon  
Incolli "favicon.png" nella root del repository, poi in *_includes/head.html* aggiungi la stringa [linkata](https://stackoverflow.com/a/30552322).  
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
{% raw %}# Site Author2{% endraw %}
    - label: "Spotify"
      icon: "fab fa-fw fa-spotify"
      url: "https://open.spotify.com/user/albgri"
```


```xml
# Site Author3
    - label: "Spotify"
      icon: "fab fa-fw fa-spotify"
      url: "https://open.spotify.com/user/albgri"
```


```python
# Site Author4
    - label: "Spotify"
      icon: "fab fa-fw fa-spotify"
      url: "https://open.spotify.com/user/albgri"
```




...















