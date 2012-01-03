module SeoHelper
  module Helper

    # <meta name="title" content="..." />
    def title_meta_tag(title, with_site_name=false)
      title <<= " | #{SITE_NAME}" if with_site_name == true
      tag(:meta, {:name => "title", :content => title}, true)
    end

    # <meta name="description" content="..." />
    def description_meta_tag(content, with_site_name=false)
      content <<= "| #{SITE_NAME}" if with_site_name == true
      tag(:meta, { :name => "description", :content => strip_tags(content) }, true)
    end

    # <meta name="keywords" content="..." />
    def keywords_meta_tag(keywords)
      keywords = keywords.join(',') if keywords.is_a? Array
      tag(:meta, {:name => "keywords", :content => keywords}, true)
    end

    # <link rel="image_src" content="..." />
    def image_src_link_tag(image_url)
      tag(:link, { :rel => "image_src", :href => image_url }, true)
    end

    def link_favicon(ico_url = "/favicon.ico")
      tag(:link, { :rel => "shortcut icon", :href => ico_url }, true)
    end

    # <meta name="robots" content="INDEX,FOLLOW" />
    def robots_meta_tag(content = "INDEX,FOLLOW")
      tag(:meta, { :name => "robots", :content => content }, true)
    end
  end

end
