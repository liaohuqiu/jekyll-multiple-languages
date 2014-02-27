---
layout: default
title: I18N for Jekyll
lead: "Jekyll Multiple Languages Plugin"
---

#What is it?
---

1.  If we write mainly in English, and sometimes in Chinese:

    Config in `_config.yml`.

    ```yaml
    # Multiple languages, cn for Chinese
    languages:          ['en', 'cn']
    
    # If not config, the first item will be the default
    language_default:   'en'
    ```

2.  If we have two pages in English: `index.html`, `about.html`, and meanwhile we have those pages in Chinese, we can name those two Chinese page like this:

*   `index.html` => `cn.index.html` or `index.cn.html`
*   `about.html` => `cn.about.html` or `about.cn.html`

    `cn` is short for Chinese.
    
    In the directory `_posts`, we have a post named `2014-02-26-hi.md`, and the page in Chinese, we can name it:

*   `2014-02-26.hi.md` => `cn.2014-02-26.hi.md` or `2014-02-26.cn.md`
    
    Then, the directory will look like:

    ```bash
    path-of-docs/
     │
     ├── index.html                     # write in English
     ├── about.html                     # write in English
     │
     ├── cn.index.html / index.cn.html  # write in Chinese
     ├── cn.about.html / about.cn.html  # write in Chinese
     │
     ├── _posts/                        # destiantion for Jekyll
     │    │    
     │    ├── 2014-02-26-hi.md
     │    └── cn.2014-02-26.md / 2014-02-26.cn.md
     │       
     ├── _site/                         # destiantion for Jekyll

    ```



#How to use
---

<h2 id="download">Download</h2>
<p class='lead'>You can fork the github repository, or download zip package.</p>

<div class="row">
    <div class="col-sm-6">
        <h3>Github</h3>
        <p>Fork it in Github, use the souce code in your project.</p>
        <a href="{{ site.download.rep }}" class="btn btn-lg btn-outline" role="button" >View on Github</a>
    </div>
    <div class="col-sm-6">
        <h3 id="download-zip">Zip</h3>
        <p>If you dont use git, you can download the zip package.</p>
        <a href="{{ site.download.dist }}" class="btn btn-lg btn-outline" role="button" >Download zip</a>
    </div>
</div>

###Dirctory structure of master branch
```bash
jekyll-multiple-languages/
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

# Multiple languages
languages:          ['en', 'cn']

# If not config, the first of languages will be the default
language_default:   'en'

# If a post of default language not set `no_fill_default_content` to true
# Its content will use to replace if the corresponding content of other languages is not exist.
# 
fill_default_content: true
```
