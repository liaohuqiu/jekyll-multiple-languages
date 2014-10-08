require "jekyll-multiple-languages/pager"
require "jekyll-multiple-languages/pagination"
module Jekyll
  module MultiLang
    attr_accessor :language, :name_no_language, :is_default_language, :url_no_language, :dir_source

    def process_initialize(site, base, dir, name)
      name_no_language = name.dup

      lang = ''
      # xxx.$lang.md / $lang.xxx.md
      site.config['languages'].each{ |item|
        lang_str = item + '.'
        if name_no_language.include? lang_str
          lang = item
          name_no_language.slice! lang_str
        end
      }

      !lang || lang == '' && lang = site.config['language_default']
      @language = lang
      @dir_source = dir
      @name_no_language = name_no_language
      @is_default_language = lang == site.config['language_default']

      initialize_org(site, base, dir, name)
    end

    def url_no_language
      if !@url_no_language
        process_url
      end
      @url_no_language
    end

    def process_url
      if !@url
        url = self.url_org 
        @url_no_language = url
        lang_prefix = '/' + self.language
        if !self.is_default_language && (url && url.index(lang_prefix) != 0)
          url = lang_prefix + url
        end
        @url = url
      end
      @url
    end

    def process_to_liquid(attrs = nil)
      data_for_liquid = self.to_liquid_org(attrs)
      attrs_for_lang = self.language_attributes_for_liquid || []
      attrs_for_lang.concat(%w[language is_default_language url_no_language])
      further_data = Hash[attrs_for_lang.map { |attribute|
        [attribute, send(attribute)]
      }]
      data_for_liquid = Utils.deep_merge_hashes(data_for_liquid, further_data)
    end
  end

  # Rewrite Jekyll.site
  #
  class Site
    attr_accessor :language_default, :languages, :posts_by_language, :pages_by_language, :fill_default_content
    alias :process_org :process
    def process
      self.begin_inject
      process_org
    rescue Exception => e
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

      self.posts.each {|post|
        @posts_by_language[post.language][post.url_no_language] = post
      }
      self.pages.each {|page|
        @pages_by_language[page.language][page.url_no_language] = page
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

    # Public: Update site config, process languages and language_default options.
    #
    def update_config(config)
      !config['languages'] && config['languages'] = []
      !config['language_default'] && config['language_default'] = config['languages'].first;

      %w[languages language_default fill_default_content].each do |opt|
        self.send("#{opt}=", config[opt])
      end
      self.config = config
    end

    alias :site_payload_org :site_payload
    def site_payload
      payload = site_payload_org
      payload.merge({
        "posts_by_language" => self.posts_by_language,
        "pages_by_language" => self.pages_by_language,
      })
    end

  end

  class Page

    include MultiLang

    LANGUAGE_ATTRIBUTES_FOR_LIQUID = %w[]

    alias :initialize_org :initialize
    def initialize(site, base, dir, name)
      process_initialize(site, base, dir, name)
    end

    alias :url_org :url
    def url
      process_url
    end

    alias :process_org :process
    def process(name)
      process_org(@name_no_language)
    end

    alias :to_liquid_org :to_liquid
    def to_liquid(attrs = nil)
      process_to_liquid(attrs)
    end

    def language_attributes_for_liquid
      LANGUAGE_ATTRIBUTES_FOR_LIQUID
    end

    def inspect
      "#<Jekyll:Page @name=#{self.name.inspect} @url=#{self.url.inspect}>"
    end

  end

  class Post
    include MultiLang

    MATCHER_WITH_LANG = /^(.+\/)*(?:.+\.)*(\d+-\d+-\d+)-(.*)(\.[^.]+)$/

      alias :initialize_org :initialize
    def initialize(site, source, dir, name)
      process_initialize(site, source, dir, name)
    end

    alias :url_org :url
    def url
      process_url
    end

    alias :process_org :process
    def process(name)
      process_org(@name_no_language)
    end

    def inspect
      "<Post: id: #{self.id} url: #{self.url} language: #{self.language}>"
    end

    # For match /blog/$lang.2014-02-14-the-blog-name.md 
    # or /blog/2014-02-14-the-blog-name.$lang.md
    #
    def self.valid?(name)
      name =~ MATCHER_WITH_LANG
    end

    def language_attributes_for_liquid

    end

    alias :to_liquid_org :to_liquid
    def to_liquid(attrs = nil)
      process_to_liquid(attrs)
    end

  end

end
