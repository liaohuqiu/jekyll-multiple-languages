It can work with Jekyll 3 now. Happy coding!

### install

```bash
gem install jekyll-multiple-languages
```

Gemfile
```ruby
gem 'jekyll-multiple-languages', '~> 2.0.1'
```

### config

add config to your `_config.yml`

```
gems:           ['jekyll-multiple-languages']

# Multiple languages
languages:          ['en', 'cn']

# If not config, the first of languages will be the default
language_default:   'en'

```

### Pagination

If you want pagination, make sure `jekyll-paginate` is in front of `jekyll-multiple-languages`:

```
gems:           ['jekyll-paginate', 'jekyll-multiple-languages']
```

### Contributors

[cbergmann](https://github.com/cbergmann)
[kuka](https://github.com/kuka)

### Thanks

`t tag`: https://github.com/screeninteraction/jekyll-multiple-languages-plugin

### Doc

Multiple Languages Plugin for Jekyll

[Visit Project Page for more information](http://jekyll-langs.liaohuqiu.net/)

[中文文档](http://jekyll-langs.liaohuqiu.net/cn)
