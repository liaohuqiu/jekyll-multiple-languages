# encoding: UTF-8
module Jekyll
  module MultiLang
    attr_accessor :language, :is_default_language

    def detect_language(site, name)
      name_no_language = name.dup

      # detect language
      # xxx.$lang.md / $lang.xxx.md
      lang = nil
      site.config['languages'].each{ |item|

        if name.start_with? (item + '.') or name.include? ('/' + item + '.')
          raise RuntimeError, "This kind of name is not supported any longer: '#{name}', which starts with '$lang'"
        end

        lang_str = '.' + item + '.'
        if name_no_language.include? lang_str
          lang = item
          name_no_language.slice! lang + '.'
        end
      }

      lang ||= site.config['language_default']

      @language = lang
      @name_no_language = name_no_language
      @is_default_language = lang == site.config['language_default']
    end

    def url_no_language
      if not @url_no_language
        url
      end
      @url_no_language
    end


    # rewrite url
    def rewrite_url(url)
      @url_no_language = url
      if not @is_default_language
        url = '/' + language + url
      end
      url
    end

    def append_data_for_liquid(data_for_liquid)
      attrs_for_lang = self.language_attributes_for_liquid || []
      attrs_for_lang.concat(%w[language is_default_language])
      further_data = Hash[attrs_for_lang.map { |attribute|
        [attribute, send(attribute)]
      }]
      data_for_liquid = Utils.deep_merge_hashes(data_for_liquid, further_data)
    end

  end
end
