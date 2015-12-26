module Jekyll
  module Paginate

    # index.$lang.html / index.html
    #
    # => /$lang/... /...
    # 
    class Pagination < Generator

      def generate(site)
        if Pager.pagination_enabled?(site)
          pages = find_template_pages(site)
          if pages && !pages.empty?
            pages.each {|page| paginate_for_language(site, page)}
          else
            Jekyll.logger.warn "Pagination:", "Pagination is enabled, but I couldn't find " +
              "an index.html page to use as the pagination template. Skipping pagination."
          end
        end
      end

      def paginate_for_language(site, the_template_page)
        lang = the_template_page.language
        all_posts = site.posts_by_language[lang] || {}
        all_posts = all_posts.values.sort { |a, b| b <=> a }
        pages = Pager.calculate_pages(all_posts, site.config['paginate'].to_i)
        (1..pages).each do |num_page|
          pager = Pager.new(site, the_template_page, num_page, all_posts, pages)
          if num_page > 1
            newpage = Page.new(site, site.source, the_template_page.dir_org, the_template_page.name)
            newpage.pager = pager
            newpage.dir = Pager.calc_paginate_path(site, the_template_page, num_page)
            site.pages << newpage
          else
            the_template_page.pager = pager
          end
        end
      end

      # Find all the cadidate pages
      #
      def find_template_pages(site)
        site.pages.dup.select do |page|
          Pager.pagination_candidate?(site.config, page)
        end.sort do |one, two|
          two.path.size <=> one.path.size
        end
      end

    end
  end
end
