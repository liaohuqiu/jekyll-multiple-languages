---
layout: default
title: Jekyll 多语言插件
description:    "Jekyll 多语言插件"
keywords:       "Jekyll 多语言插件"
lead: ""
---

# 主要功能
---

`Jekyll` 是一个非常强大的建站工具，用来写博客或者项目文档非常方便。

在一些场景下，比如在写产品文档， 我们可能需要需要写成多种语言。

本插件提供了多语言了支持，使用非常简单，并且各个语言原始文档管理非常方便。

### 文件命名方式

默认语言：

* 普通页面: `$page_name.$ext`. 比如:  `index.md`, `about.md`.

* 文章页面: `_posts/$dir_pre/$date-$post_name.$ext`. 比如: `_posts/blog/2014-02-26-hi.md`.

其他的语言(`$lang`): , 在 `$page_name` 之后，加上 `$lang.`，注意 `$lang` 后有一个 `.`。

* 普通页面:  `page_name.$lang.$ext`, 比如:

    `index.md` => `index.cn.md`

* 文章页面: `_posts/$dir_pre/$date-$post_name.$ext`

    `2014-02-26.hi.md` => `2014-02-26-hi.cn.md`

### 生成的结果

* 默认语言生成的结果和没用本插件一样，如果没有在`_config.yml`指定目标目录，那么目标目录就是在：`_site` 目录下。

* 其他的语言(`$lang`), 生成到目标目录下的 `/$lang` 下，比如：`_site/$lang`。当 `$lang` 为 `cn` 时，就是 `_site/cn`。


# 安装和使用

---

### 安装

* 使用 gem 安装扩展

    ```bash
    gem install jekyll-multiple-languages
    ```

* 如果需要分页，还需要安装 `jekyll-paginate`

    ```bash
    gem install jekyll-paginate
    ```

### 配置

* ####  `_config.yml`

    ```yaml
    # 多语言配置
    gems:           ['jekyll-multiple-languages']
    # 如果需要分页, 请加入 jekyll-paginate 并放于 jekyll-multiple-languages 之前
    # gems:           ['jekyll-paginate', 'jekyll-multiple-languages']

    # 所有的语言
    languages:          ['en', 'cn']
    
    # 默认语言
    # 如果没有配置，languages 中的第一项就是默认语言
    language_default:   'en'
    ```

# 示例

---

* 这是一份极其详细的示例项目

    [查看示例代码](https://github.com/liaohuqiu/jekyll-multiple-languages-sample/tree/master)

* 这是示例代码对应的在线的网站

    [示例代码生成的网站](http://jekyll-langs-sample.liaohuqiu.net)


# 变量

---

### 普通页面和文章页面通用变量

*   `page.language`

    当前页面或者文章的语言。

*   `page.is_default_language`

    当前页面或者文章的语言是否是默认语言。

### 文章页面独有的变量

*   `page.next_in_language`

    当前语言的下一个文章

*   `page.previous_in_language`

    当前语言的上一个文章

### site 变量

*   `site.pages_by_language`

    `site.pages` key-value 键对。根据语言分组。key 是语言，value 是该语言下的所有页面。

*   `site.posts_by_language`

    `site.posts` 根据语言分组。

### 变量示例

>  http://jekyll-langs-sample.test.srain.in/cn/

# 数据文件

* 我们可以在 `_data` 目录下创建一个数据文件，存放多语言相关的变量，比如 `i18n.yml`：

    ```yaml
    en:
        previous_page: Previous
        next_page:    Next
    
    cn:
        previous_page: 上一页
        next_page:    下一页
    ```

* 然后我们在 `pagination.html` 使用

    ```html
    <li>
    <a href="{{ "{{ paginator.previous_page_path " }}}}" aria-label="Previous">
        <span>{{ "{{ site.data.i18n[page.language].previous_page " }}}}</span>
    </a>
    </li>
    ```

# 分页

---

**本插件扩展了 `jekyll-paginate` 使之支持多语言，并且可使用任意后缀文件。**

### 分页模板

*   形如 `index.*` 都可以做为默认语言的分页模板。并不局限于 `index.html`。

    比如: `index.md`, `index.html`.

*   其他语言的分页模板文件命名格式为: `index.$lang.$ext`

    比如: `index.cn.md`

### 分页的变量

*   同 [jekyll-paginate](http://jekyllrb.com/docs/pagination/)

### 分页示例

>  http://jekyll-langs-sample.test.srain.in/cn/

# Github Pages
---

**Github Pages 运行在 safe 模式，在这个模式下，暂时无法使用插件。**

**如果你网站要放到 Github 上，这里有一个解决方案**

* [托管在Github上的网站如何使用插件](http://www.liaohuqiu.net/cn/posts/jekyll-plugins-on-github-pages/)
