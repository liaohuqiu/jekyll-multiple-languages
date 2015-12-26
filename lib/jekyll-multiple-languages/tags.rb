# encoding: UTF-8
module Jekyll
  @translations={}
  def self.translations
    @translations
  end

  class LocalizeTag < Liquid::Tag

    def initialize(tag_name, key, tokens)
      super
      @key = key.strip
    end

    def render(context)
      if "#{context[@key]}" != "" #Check for page variable
        key = "#{context[@key]}"
      else
        key = @key
      end
      lang = context.registers[:page]['language']
      unless Jekyll.translations.has_key?(lang)
        translationfile="#{context.registers[:site].source}/#{context.registers[:site].config['i18ndir']}/#{lang}.yml"
        puts "Loading translation from file #{translationfile}"
        Jekyll.translations[lang] = YAML.load_file(translationfile)
      end
      translation = Jekyll.translations[lang].access(key) if key.is_a?(String)
      if translation.nil? or translation.empty?
        translation = Jekyll.translations[context.registers[:site].config['language_default']].access(key)
        puts "Missing i18n key: #{lang}:#{key}"
        puts "Using translation '%s' from default language: %s" %[translation, context.registers[:site].config['language_default']]
      end
      translation
    end
  end
end

unless Hash.method_defined? :access
  class Hash
    def access(path)
      ret = self
      path.split('.').each do |p|
        if p.to_i.to_s == p
          ret = ret[p.to_i]
        else
          ret = ret[p.to_s] || ret[p.to_sym]
        end
        break unless ret
      end
      ret
    end
  end
end

Liquid::Template.register_tag('t', Jekyll::LocalizeTag)
Liquid::Template.register_tag('translate', Jekyll::LocalizeTag)
