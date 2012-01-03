module SeoHelper
  module Helper

    def meta_title(title, with_site_name=true)
      if title.present?
        title <<= " | #{SITE_NAME resuce "SITE_NAME"}" if with_site_name == true
        tag(:meta, {:name => "title", :content => title})
      end
    end

    def meta_description(content, with_site_name=false)
      if content.present?
        content <<= "| #{SITENAME rescue "SITE_NAME"}" if with_site_name == true
        tag(:meta, { :name => "description", :content => strip_tags(content) }, true)
      end
    end

    def meta_keywords(keywords)
      if keywords.present?
        keywords = keywords.join(',') if keywords.is_a? Array
        tag(:meta, {:name => "keywords", :content => keywords})
      end
    end

    def link_image(image_url)
      if image_url.present?
        tag(:link, { :rel => "image_src", :href => image_url }, true)
      end
    end

    def link_favicon(ico_url = "/favicon.ico")
      tag(:link, { :rel => "shortcut icon", :href => ico_url }, true)
    end


    def meta_robots(content = "INDEX,FOLLOW")
      tag(:meta, { :name => "robots", :content => content }, true)
    end
  end

end
