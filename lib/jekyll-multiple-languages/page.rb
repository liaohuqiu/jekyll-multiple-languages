# encoding: UTF-8
module Jekyll
  class Page
    include MultiLang

    attr_accessor :dir_org

    alias :initialize_org :initialize
    def initialize(site, base, dir, name)
      detect_language(site, name)
      @dir_org = dir
      initialize_org(site, base, dir, name)
    end

    # remove `.$lang` for basename
    alias :process_org :process
    def process(name)
      @ext = File.extname(name)
      @basename = name[0 .. -ext.length - 1]
      if not @is_default_language
        @basename ['.' + @language] = ''
      end
    end

    # append `/$lang/ before path for non-default language document
    alias :url_org :url
    def url
      rewrite_url(url_org)
    end

    def language_attributes_for_liquid 
    end

    alias :to_liquid_org :to_liquid
    def to_liquid()
      data = to_liquid_org
      append_data_for_liquid(data)
    end
  end
end
