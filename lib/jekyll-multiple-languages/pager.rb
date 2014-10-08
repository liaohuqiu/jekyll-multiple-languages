module Jekyll
  module Paginate
    class Pager

      # Static: Return the pagination path of the page
      #
      # site     - the Jekyll::Site object
      # the_template_page - template page
      # num_page - the pagination page number
      #
      # Returns the pagination path as a string
      def self.calc_paginate_path(site, the_template_page, num_page)
        return nil if num_page.nil?
        return the_template_page.url if num_page <= 1
        format = site.config['paginate_path']
        format = format.sub(':num', num_page.to_s)
        path = ensure_leading_slash(format)
        path
      end

      def self.calc_paginate_path_with_lang(site, the_template_page, num_page)
        path = self.calc_paginate_path(site, the_template_page, num_page)
        return nil if path.nil?
        lang_prefix = '/' + the_template_page.language
        if !the_template_page.is_default_language && (path && path.index(lang_prefix) != 0)
          path = '/' + the_template_page.language + path
        end
        path
      end

      def self.pagination_candidate?(config, page)
        page_dir = File.dirname(File.expand_path(remove_leading_slash(page.path), config['source']))
        paginate_path = remove_leading_slash(config['paginate_path'])
        paginate_path = File.expand_path(paginate_path, config['source'])
        page.basename == 'index' &&
          in_hierarchy(config['source'], page_dir, File.dirname(paginate_path))
      end

      def initialize(site, the_template_page, page, all_posts, num_pages = nil)
        @page = page
        @per_page = site.config['paginate'].to_i
        @total_pages = num_pages || Pager.calculate_pages(all_posts, @per_page)

        if @page > @total_pages
          raise RuntimeError, "page number can't be greater than total pages: #{@page} > #{@total_pages}"
        end

        init = (@page - 1) * @per_page
        offset = (init + @per_page - 1) >= all_posts.size ? all_posts.size : (init + @per_page - 1)

        @total_posts = all_posts.size
        @posts = all_posts[init..offset]
        @previous_page = @page != 1 ? @page - 1 : nil
        @previous_page_path = Pager.calc_paginate_path_with_lang(site, the_template_page, @previous_page)
        @next_page = @page != @total_pages ? @page + 1 : nil
        @next_page_path = Pager.calc_paginate_path_with_lang(site, the_template_page, @next_page)
      end

    end
  end
end
