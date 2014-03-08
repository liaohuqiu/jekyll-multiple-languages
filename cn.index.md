---
layout: default
title: Jekyll 多语言插件
description:    "Jekyll多语言插件"
keywords:       "Jekyll 多语言插件"
lead: ""
---

#主要功能
---

`Jekyll` 是一个非常强大的建站工具，用来写博客或者项目文档非常方便。

在一些场景下，比如在写产品文档， 我们可能需要需要写成多种语言。

这个插件提供了多语言了支持，使用非常简单，并且各个语言原始文档管理非常方便。

###文件命名方式

默认语言：

* 普通页面: `$page_name.$ext`. For example:  `index.md`, `about.md`.

* 文章页面: `_posts/$dir_pre/$date-$post_name.$ext`. For example: `_posts/blog/2014-02-26-hi.md`.

其他的语言(`$lang`): , 在`$page_name`之前或者之后，加上`$lang.`，注意`$lang`后有一个 `.`。

* 普通页面:  `$lang.page_name.$ext` 或者 `page_name.$lang.$ext`, 比如:

    `index.md` => `index.cn.md`, `cn.index.md`

* 文章页面: `_posts/$dir_pre/$lang.$date-$post_name.$ext` 或者 `_posts/$dir_pre/$date-$post_name.$ext`

    `2014-02-26.hi.md` => `$lang.2014-02-26.hi.md` or `2014-02-26-hi.cn.md`

###生成的结果

* 默认语言生成的结果和没用本插件一样，如果没有在`_config.yml`指定目标目录，那么目标目录就是在：`_site` 目录下。

* 其他的语言(`$lang`), 生成到目标目录下的 `/$lang`下，比如：`_site/$lang`。当`$lang`为`cn`时，就是 `_site/cn`。

---

###示例

* [查看示例代码](https://github.com/liaohuqiu/jekyll-multiple-languages-sample/tree/master)

* [示例代码生成的网站](http://jekyll-langs-sample.liaohuqiu.net)

#### 示例相关的配置

First, the  `pygments` is set to `pretty` in `_config.yml`

* `_config.yml`:

    ```yaml
    # Permalinks, default is pretty
    permalink:        pretty
    ```

#### The content

If we have two pages in English: `index.md`, `about.md`, and meanwhile we have those pages in Chinese, we can name those two Chinese page like this, we use `cn` short for Chinese:

*   `index.md` => `cn.index.md` or `index.cn.md`

*   `about.md` => `cn.about.md` or `about.cn.md`
    
In the directory `_posts`, we have a post named `2014-02-26-one.md`, and the page in Chinese, we can name it:

* `2014-02-26.one.md` => `cn.2014-02-26.one.md` or `2014-02-26.one.cn.md`.
    
And another two more: 

* `cn.2014-02-26-two.md`

* `2014-02-26-three.md`

#### The build result:

Now, we build it:

```bash linenos
$ jekyll build
$ cd ./_site
$ find . -type f
```
The files in `_site/`:

```
./index.html
./cn/index.html
./about/index.html
./cn/about/index.html
./2014/02/26/one/index.html
./cn/2014/02/26/one/index.html
./cn/2014/02/26/two/index.html
./2014/02/26/three/index.html
```

The whole directory structure:

```bash
path-of-docs/
 │
 ├── index.md                       # write in English
 ├── about.md                       # write in English
 │
 ├── cn.index.md / index.cn.md      # write in Chinese
 ├── cn.about.md / about.cn.md      # write in Chinese
 │
 ├── _posts/                        # destiantion for Jekyll
 │    │    
 │    ├── 2014-02-26-one.md
 │    ├── 2014-02-26.one.cn.md / cn.2014-02-26.one.md
 │    ├── cn.2014-02-26.two.md
 │    └── 2014-02-26-three.md
 │       
 └── _site/                         # destiantion for Jekyll
      │
      ├── index.html
      ├── about/index.html
      ├── 2014/
      │   └── 02/
      │       └── 26/
      │           ├── one/index.html
      │           ├── two/index.html
      │           └── three/index.html
      └── cn/
          ├── index.html
          ├── about/index.html
          └── 2014/
              └── 02/
                  └── 26/
                      ├── one/index.html
                      └── two/index.html
```

#Installation
---

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

# Configure
---

* ### in `_config.yml`

    * `languages`: The all of the languages.
    
    * `language_default`: The default language, if not set the first item in `languages` will be used.
    
    * `fill_default_content`:
    
        If this value is set to `ture`, the page or post of default language will
        be used for generating if the corresponding page of
        the other page or post **is not exist**.
    
        >   You can configure in `Page` or `Post` of default language make them will not be used to generated for the other language.
    
    An example of configure in `_config.yml`:
    
    ```yaml
    # Multiple languages
    languages:          ['en', 'cn']
    
    # If not config, the first of languages will be the default
    language_default:   'en'
    
    fill_default_content: true
    ```

* ### Configure in Page or Post

    * `no_fill_default_content`
    
        If set this value to `ture` in a Page or Post of default language, its content will not be used to generate for the other languages.

#Variables
---

* `page.language`

    The language in this Page or Post.

* `page.is_default_language`

    If this Page or Post is in the default language, its value is `true`

* `page.url`

    If not the default language, will start with `page.language`: `/cn/about/`;

*   `page.url_no_language`

    The url without `site.language`. In the Page or Page in default language, this value is same with `page.url`.
    
    This value will be the same for all of the languages.

    ---

*   `site.pages`

    All the Pages, including all languages;

*   `site.post`

    All the Posts, including all languages;

*   `site.pages_by_language`

    It is all the `site.pages` grouped by languages. 
    
    It is a hash. The key is language and the value is all of the Pages in this kind of language.

    The value is also a hash, the key is the `page.url_no_language`.

*   `site.posts_by_language`

    It is similar to `site.pages_by_language`, it is all the `site.posts` grouped by languages.

#Paginate
---

####The template

* Page named `index.*` is the paginate template for default language.

    For example: `index.md`, `index.html`.

* Page `index.$lang.$ext` or `$lang.index.$ext` is the paginate template for the other languages(short for `$lang`).

    For example: `index.cn.md`, `cn.index.md`.

####The variables

*   `paginator.posts`

    It is all of the posts in this kind language.

#Github Pages
---

**Try to use Jekyll plugins on Github Pages is a little complicated.**

###[How to use Jekyll plugins on Github Pages](http://www.liaohuqiu.net/posts/jekyll-plugins-on-github-pages/)


