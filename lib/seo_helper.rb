require "seo_helper/version"
require 'seo_helper/railtie' if defined?(Rails)
module SeoHelper
  
  def meta_title(title)
    return nil if title.blank?
    title = title + " | " + (SITE_NAME rescue "SITE_NAME")
    tag(:meta, {:name => "title", :content => title})
  end
  
  def meta_description(content, site_name = false)
    return nil if content.blank?
    content = content + " | " + (SITE_NAME rescue "SITE_NAME") if site_name
    tag(:meta, { :name => "description", :content => strip_tags(content) }, true)
  end
  
  def meta_keywords(word)
    return nil if word.blank?
    # word = word + (SITE_NAME rescue "SITE_NAME")
    tag(:meta, {:name => "keywords", :content => word})
  end

  def render_rel_image(image_url)
    return nil if image_url.blank?
    tag(:link, {:rel => "image_src", :href => image_url})
  end

  def link_image(image_url)
    return nil if image_url.blank?
    tag(:link, { :rel => "image_src", :href => image_url }, true)
  end

  def link_favicon(ico_url = "/favicon.ico")
    tag(:link, { :rel => "shortcut icon", :href => ico_url }, true)
  end

  
  def meta_robots(content = "INDEX,FOLLOW")
    tag(:meta, { :name => "robots", :content => content }, true)
  end
  
end
