---
layout: default
title: Bt-docs
lead: "Write beautiful and concise document in a easy way."
---

#What is it?
---

* Bootstrap document style
* Very easy to use
* Write in `markdown`
* Multiple languages

#How to use
---

<h2 id="download">Download</h2>
<p class='lead'>You can fork the github repository, or download zip package.</p>

<div class="row">
    <div class="col-sm-6">
        <h3>Github</h3>
        <p>Fork it in Github, use the souce code in your project.</p>
        <pre><code>git clone {{ site.download.rep }}</code></pre>
        <a href="{{ site.download.rep }}" class="btn btn-lg btn-outline" role="button" >View on Github</a>
    </div>
    <div class="col-sm-6">
        <h3 id="download-zip">Zip</h3>
        <p>If you dont use git, you can download the zip package.</p>
        <a href="{{ site.download.dist }}" class="btn btn-lg btn-outline" role="button" >Download zip</a>
    </div>
</div>
###dirctory structure
```bash
bt-docs/
 ├── assets         # js / css / image
 ├── CNAME          # host name to github pages
 ├── conf           # configure files for develop
 ├── _config.yml    # configure for jekyll
 ├── dist           # js / css of bootstrap
 ├── _includes      # templete parts
 ├── lang           # the content in multiple languages
 ├── _layouts
 ├── _plugins
 ├── README.md
 ├── _site
 └── tools   
```


##Configure
```yaml
# site information
info:
  site_name:    Bt-docs

meta:
  description:  Write beautiful bootstrap style document in a easy way.
  keywords:     bootstrap documentation template, beautiful documentation, easy documentation
  author:       liaohuqiu@gmail.com

#multiple language
languages:      ["en", "cn"]

navigation:
  en:
    title:    Bt-docs
    items1:
      - path:     /imageloader
        title:    Image Loader
      - path:     /request
        title:    Network Request
  cn:
    title:    Cube
    items1:
      - path:     /imageloader
        title:    图片加载组件
      - path:     /request
        title:    网络请求

right_nav:
  - title:    English Version
    url:      /
  - title:    中文版文档
    url:      /cn
  - title:    Fork on Github
    url:     https://github.com/liaohuqiu/bt-docs

# analytics account info
analytics:
  google:
    account:    UA-43024238-3

```
##

