module SeoHelper
  def self.format_current_page(title, page_number)
    self.configuration.pagination_formatter.call(title, page_number)
  end

  def self.format_site_name(text, site_name)
    self.configuration.site_name_formatter.call(text, site_name)
  end
end