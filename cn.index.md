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

*   例子中我们有两种语言，英语和中文。英语为网站默认语言。

    中文用缩写`cn`来代表。

    ```yaml
    language_default: 'en'
    languages:        ['en', 'cn']
    ```

*   然后，在`_config.yml`中`permalink`设置成`pretty`:

    ```yaml
    # Permalinks, default is pretty
    permalink:        pretty
    ```

#### 原始文档内容

如果我们有两个英文页面: `index.md`, `about.md`，同时，有两个对应的中文页面，我们可以这样命名，用`cn`来代替中文:

*   `index.md` => `cn.index.md` 或者 `index.cn.md`

*   `about.md` => `cn.about.md` 或者 `about.cn.md`
    
在文章目录`_posts`下，有一个英文的文章 `2014-02-26-one.md`，对应的中文文章，可以这样：

* `2014-02-26.one.md` => `cn.2014-02-26.one.md` or `2014-02-26.one.cn.md`.
    
另外再有两篇文章:

* `cn.2014-02-26-two.md`

* `2014-02-26-three.md`

#### 生成的结果

用jekyll生成内容：

```bash
$ jekyll build
$ cd ./_site
$ find . -type f
```

列出`_site/`目录下的所有文件：

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

整个项目的目录结构：

```bash
path-of-docs/
 │
 ├── index.md                       # 英文
 ├── about.md                       # 中文
 │
 ├── cn.index.md / index.cn.md      # index.md对应的中文
 ├── cn.about.md / about.cn.md      # about.md对应的中文
 │
 ├── _posts/                        # 文章目录
 │    │    
 │    ├── 2014-02-26-one.md
 │    ├── 2014-02-26.one.cn.md / cn.2014-02-26.one.md
 │    ├── cn.2014-02-26.two.md
 │    └── 2014-02-26-three.md
 │       
 └── _site/                         # 网站生成目录
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

#安装和使用
---

使用gem安装扩展

```bash
gem install jekyll-multiple-languages
```

# 配置
---

* ###  `_config.yml`

    * `gems`:   加入 `'Jekyll-multiple-languages'` 

    * `languages`: 所有的语言
    
    * `language_default`: 默认语言，如果没有指定，使用`languages`数组中的第一个语言。
    
    * `fill_default_content`:
    
        如果这个值设置成 `ture`，当一个默认语言页面对应的其他语言的页面不存在的时候，会用默认语言页面生成其他语言的页面。
    
        >   如果你不想某些默认语言的文章或者页面被生成其他语言，你可以在这些文章设置`no_fill_default_content`
    
    `_config.yml`示例
    
    ```yaml
    # 多语言配置
    gems:           ['jekyll-multiple-languages']

    languages:          ['en', 'cn']
    
    # 默认语言
    # 如果没有配置，languages中的第一项就是默认语言
    language_default:   'en'
    
    fill_default_content: true
    ```

* ### 普通页面或者文章配置

    * `no_fill_default_content`
    
        在默认语言文章或者普通页面，如果设置成`true`，当对应的其他语言的页不存在时，不会用于生存这些页面。

#变量
---

* `page.language`

    当前页面或者文章的语言。

* `page.is_default_language`

    当前页面或者文章的语言是否是默认语言。

* `page.url`

    如果是默认语言页面，这个值和没使用插件时没有任何区别。

    如果是其他语言，路径前缀是`page.language`，比如: `/cn/about/`;

*   `page.url_no_language`

    不含`site.language`的路径，和不使用本插件时的`page.url`值一样。
    
    在默认语言的页面或者文章中，这个值和`page.url`一样。
    
    同一页面所有语言的`page.url`都一样。

    ---

*   `site.pages`

    包括所有语言在内的所有页面。

*   `site.posts`

    包括所有语言在内的所有文章。

*   `site.pages_by_language`

    `site.pages` 根据语言分组。key是语言，value是该语言下的所有文章。

    各个语言对应的文章，以`page.url_no_language`索引。

*   `site.posts_by_language`

    `site.posts` 根据语言分组。

#分页
---

####分页模板

*   形如 `index.*` 都可以做为默认语言的分页模板。并不局限于 `index.html`。

    比如: `index.md`, `index.html`.

*   其他语言的分页模板文件命名格式为: `index.$lang.$ext` 或者 `$lang.index.$ext`。

    比如: `index.cn.md`, `cn.index.md`.

####分页的变量

*   `paginator.posts`

    当前语言的所有文章。

#Github Pages
---

**Github Pages 运行在safe模式，在这个模式下，暂时无法使用插件。**

如果你网站要放到Github上，这里有一个解决方案：: **[托管在Github上的网站如何使用插件](http://www.liaohuqiu.net/cn/posts/jekyll-plugins-on-github-pages/)**
