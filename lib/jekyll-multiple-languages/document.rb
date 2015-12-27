# encoding: UTF-8
module Jekyll
  class Document
    include MultiLang

    attr_accessor :next_in_language, :previous_in_language

    alias :initialize_org :initialize
    def initialize(path, relations)
      detect_language(relations[:site], path)
      initialize_org(path, relations)
    end

    # remove `.$lang` from slug
    alias :post_read_org :post_read
    def post_read
      post_read_org
      if not @is_default_language and data and data['slug']
        data['slug'] ['.' + @language] = ''
      end
    end

    # remove `.$lang` from basename_without_ext
    def basename_without_ext
      if not @basename_without_ext
        @basename_without_ext = File.basename(path, '.*')
        if not @is_default_language
          @basename_without_ext ['.' + @language] = ''
        end
      end
      @basename_without_ext
    end

    # append `/$lang/ before path for non-default language document
    alias :url_org :url
    def url
      rewrite_url(url_org)
    end

    def next_in_language
      posts = site.posts_by_language[@language].values
      pos = posts.index { |post| post.equal?(self) }
      if pos && pos < posts.length - 1
        posts[pos + 1]
      else
        nil
      end
    end

    def previous_in_language
      posts = site.posts_by_language[@language].values
      pos = posts.index { |post| post.equal?(self) }
      if pos && pos > 0
        posts[pos - 1]
      else
        nil
      end
    end

    def inspect
      "<Post: id: #{self.id} url: #{self.url} language: #{self.language}>"
    end

    def language_attributes_for_liquid
      %w[previous_in_language next_in_language]
    end

    alias :to_liquid_org :to_liquid
    def to_liquid()
      data = to_liquid_org
      append_data_for_liquid(data)
    end
  end
end
