---
title: "GitHub Pages"
excerpt: "How to"
date: 2019-01-27
tags: [github, pages, ubuntu]
mathjax: "true"
---

*funzionanti con Ubuntu 18-04*
Installa Git Desktop per [Linux](https://aur.archlinux.org/packages/github-desktop-bin/)  
è sufficiente scaricare il .deb ed installarlo.

### GitHub
Trova il repository per la web page che ti [interessa](https://github.com/mmistakes/minimal-mistakes)  
**Fork!** In alto a destra, il comando Fork ne farà una copia nel tuo profilo GitHub  
Da GitHub nelle impostazioni del repository:  
- Repository name : [Nome].github.io  
- In basso, GitHub Pages ->  Custom domain -> www.[nomedominio.com]

### Configurare il dominio (google domain)
1. Google Domain, compro il dominio, 12 euro all'anno. [Questo mi piace](https://support.google.com/domains/answer/3251242?hl=en).
2. da GitHub repository  
<span style="font-size: 3mm">
---> Settings ---> GitHub Pages ---> Custom domain ---> "www.[nomedacomprare].com"  
</span>
3. da Google Domain  
<span style="font-size: 3mm">
---> DNS ---> Custom resource records ---> [][A][][185.199.***.153] [Link per gli IP](https://help.github.com/articles/setting-up-an-apex-domain/#configuring-a-records-with-your-dns-provider)  
</span>
4. da Google Domain  
<span style="font-size: 3mm">
---> DNS ---> Custom resource records ---> [www][CNAME][][AlbGri.github.io]  
</span>
5. da GitHub repository  
<span style="font-size: 3mm">
---> Settings ---> GitHub Pages ---> Custom domain ---> Enforce HTTPS  
</span>

N.B. _Enforce HTTPS_ si sblocca dopo qualche minuto (e refresh), segue qualche comando per vedere se il sito e DNS sono up  
````console
dig albgri.com +noall +answer  
dig www.albgri.com +nostats +nocomments +nocmd  
ping albgri.com  
````

### Pages
**Jakyll e Minimal Mistakes**  
Per cambiare le dimensioni del testo  
<span style="font-size: 3mm">
_sass ---> _reset.scss
</span>


