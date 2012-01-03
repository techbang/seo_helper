module SeoHelper
  module Helper

    # <title>...</title>
    def title_tag(title, with_site_name=false)
      title <<= " | #{SeoHelper.configuration.site_name}" if with_site_name == true
      content_tag(:title, title, nil, false)  # option=nil, escape=false
    end

    # <meta name="title" content="..." />
    def title_meta_tag(title, with_site_name=false)
      title <<= " | #{SeoHelper.configuration.site_name}" if with_site_name == true
      tag(:meta, {:name => "title", :content => title})
    end

    # <meta name="description" content="..." />
    def description_meta_tag(content, with_site_name=false)
      content <<= "| #{SeoHelper.configuration.site_name}" if with_site_name == true
      tag(:meta, { :name => "description", :content => strip_tags(content) })
    end

    # <meta name="keywords" content="..." />
    def keywords_meta_tag(keywords)
      keywords = keywords.join(',') if keywords.is_a? Array
      tag(:meta, {:name => "keywords", :content => keywords})
    end

    # <link rel="image_src" content="..." />
    def image_src_link_tag(image_url)
      tag(:link, { :rel => "image_src", :href => image_url })
    end

    # <meta name="robots" content="INDEX,FOLLOW" />
    def robots_meta_tag(content = "INDEX,FOLLOW")
      tag(:meta, { :name => "robots", :content => content })
    end

    attr_reader :page_title, :page_description, :page_keywords, :page_image

    def render_page_title_tag
      # fallback to site_name if @page_title has never been set
      title_tag(page_title || SeoHelper.configuration.site_name)
    end

    def render_page_title_meta_tag
      title_meta_tag(page_title || SeoHelper.configuration.site_name)
    end

    def render_page_description_meta_tag
      description_meta_tag(page_description)
    end

    def render_page_keywords_meta_tag
      keywords_meta_tag(page_keywords)
    end

    def render_page_image_link_tag
      image_src_link_tag(page_image)
    end
  end

  module ControllerHelper

    # will also append current page number and the site name
    def set_page_title(title)
      pagination  = " -  Page #{params[:page]}" if params[:page]
      @page_title = "#{title}#{pagination} | #{SeoHelper.configuration.site_name}"
    end

    def set_page_description(description)
      @page_description = description
    end

    def set_page_keywords(keywords)
      @page_keywords = keywords
    end

    def set_page_image(image_src)
      @page_image = image_src
    end
  end
end
