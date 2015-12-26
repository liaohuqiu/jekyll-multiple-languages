# encoding: UTF-8
module Jekyll
  # Rewrite Jekyll.site
  #
  class Site
    attr_accessor :language_default, :languages, :posts_by_language, :pages_by_language, :fill_default_content

    alias :process_org :process
    def process
      self.begin_inject
      process_org
    rescue Exception => e
      print e.message, "\n"
      print e.backtrace.join("\n")
    end

    alias :read_org :read
    def read
      read_org
      group_posts_and_pages
    end

    # Group the post by the language
    #
    def group_posts_and_pages
      lang_default = self.language_default
      langs_remain = self.languages.dup
      langs_remain.delete(lang_default)

      @posts_by_language = {}
      @pages_by_language = {}

      self.languages.dup.each { |lang|
        @posts_by_language[lang] ||= {}
        @pages_by_language[lang] ||= {}
      }

      self.posts.docs.each {|post|
        @posts_by_language[post.language][post.url_no_language] = post
      }
      self.pages.each {|page|
        # @pages_by_language[page.language][page.url_no_language] = page
      }

      if (@fill_default_content)
        self.fill_default_content(@posts, @posts_by_language, lang_default, langs_remain, Post)
        self.fill_default_content(@pages, @pages_by_language, lang_default, langs_remain, Page)
      end
    end

    def fill_default_content(contents, grouped_contents, default, targets, kclass)
      grouped_contents[default].select{|k,v| !v.data['no_fill_default_content']}.each{ |k, content|
        targets.each{|lang|
          if !grouped_contents[lang][k]
            c = kclass.new(self, @source, content.dir_source, content.name)
            c.language = lang
            c.is_default_language = false
            grouped_contents[lang][k] = c
            contents << c
          end
        }
      }
    end

    # Only when site is initialized, this plugin will be loaded
    def begin_inject
      self.update_config(self.config)
    end

    # Update config, process languages and language_default options.
    #
    def update_config(config)

      config['languages'] ||= []
      config['language_default'] ||= config['languages'].first;

      # set the default value of `i18ndir` to `_i18n`
      config['i18ndir'] ||= "_i18n";

      %w[languages language_default fill_default_content].each do |opt|
        self.send("#{opt}=", config[opt])
      end
    end

    # add `posts_by_language` and `pages_by_language`
    alias :site_payload_org :site_payload
    def site_payload
      original = site_payload_org
      payload = original['site']
      payload = payload.merge({
        'posts_by_language' => self.posts_by_language,
        'pages_by_language' => self.pages_by_language
      })
      original['site'] = payload
      original
    end

  end
end
