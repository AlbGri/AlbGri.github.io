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

### GitHub
Trova il repository per la web page che ti [interessa](https://github.com/mmistakes/minimal-mistakes)  
**Fork!** In alto a destra, il comando Fork ne farà una copia nel tuo profilo GitHub  
Imposta il repo come la tua page  
<span style="font-size: 3mm">
Settings →  Repository name → "AlbGri.github.io"  
</span>

### Configurare il dominio (google domain)
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

### Note Pages
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
Incolli "favicon.png" nella root del repository, poi in *_includes/head.html* aggiungi la seguente riga1  
```console
<link rel="shortcut icon" type="imagepng" href="favicon.png">
```

```html
<link rel='shortcut icon' href='favicon.ico'>
<link rel='icon' sizes='16x16' type='image/png' href='/jekyll-favicon-example/assets/images/favicon-16x16.png'>
<link rel='icon' sizes='32x32' type='image/png' href='/jekyll-favicon-example/assets/images/favicon-32x32.png'>
<link rel='icon' sizes='64x64' type='image/png' href='/jekyll-favicon-example/assets/images/favicon-64x64.png'>
<meta name='msapplication-config' content='/jekyll-favicon-example/browserconfig.xml'>
<link rel='manifest' href='/jekyll-favicon-example/manifest.webmanifest'>
```




...















