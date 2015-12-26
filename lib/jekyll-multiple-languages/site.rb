# encoding: UTF-8
module Jekyll
  # Rewrite Jekyll.site
  #
  class Site
    attr_accessor :language_default, :languages, :posts_by_language, :pages_by_language

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
    end

    alias :generate_org :generate
    def generate
      group_posts
      generate_org
      group_pages
    end

    # Group the post by the language
    #
    def group_posts
      self.posts.docs.each {|post|
        @posts_by_language[post.language][post.url_no_language] = post
      }
    end

    # Group the pages by the language
    #
    def group_pages
      self.pages.each {|page|
        @pages_by_language[page.language][page.url_no_language] = page
      }
    end

    # Only when site is initialized, this plugin will be loaded
    def begin_inject

      self.update_config(self.config)

      # initialize
      @posts_by_language = {}
      @pages_by_language = {}

      self.languages.dup.each { |lang|
        @posts_by_language[lang] ||= {}
        @pages_by_language[lang] ||= {}
      }

    end

    # Update config, process languages and language_default options.
    #
    def update_config(config)

      config['languages'] ||= []
      config['language_default'] ||= config['languages'].first;

      # set the default value of `i18ndir` to `_i18n`
      config['i18ndir'] ||= "_i18n";

      %w[languages language_default].each do |opt|
        self.send("#{opt}=", config[opt])
      end
    end

    # add `posts_by_language` and `pages_by_language`
    alias :site_payload_org :site_payload
    def site_payload

      original = site_payload_org

      posts_by_language = {}
      pages_by_language = {}
      self.languages.dup.each { |lang|
        posts_by_language[lang] = @posts_by_language[lang].values.sort { |a, b| b <=> a }
        pages_by_language[lang] = @pages_by_language[lang].values
      }

      payload = original['site']
      payload = payload.merge({
        'posts_by_language' => posts_by_language,
        'pages_by_language' => pages_by_language
      })
      original['site'] = payload
      original
    end

  end
end
