It can work with octopress now.
Happy coding.

### Quick start

install
```bash
gem install jekyll-multiple-languages
```

Gemfile
```ruby
gem 'jekyll-multiple-languages', '~> 1.0.7'
```

add config to your `_config.yml`

```
gems:           ['jekyll-multiple-languages']

# Multiple languages
languages:          ['en', 'cn']

# If not config, the first of languages will be the default
language_default:   'en'

# If a post of default language not set `no_fill_default_content` to true
# Its content will use to replace if the corresponding content of other languages is not exist.
# fill_default_content: true
```

### Contributors

    [cbergmann](https://github.com/cbergmann)

### Thanks

`t tag`: https://github.com/screeninteraction/jekyll-multiple-languages-plugin

### Doc

Multiple Languages Plugin for Jekyll

[Visit Project Page for more information](http://jekyll-langs.liaohuqiu.net/)

[中文文档](http://jekyll-langs.liaohuqiu.net/cn)
