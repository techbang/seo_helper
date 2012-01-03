module SeoHelper
  class Configuration
    attr_accessor :site_name

    attr_accessor :default_page_description
    attr_accessor :default_page_keywords
    attr_accessor :default_page_image

    attr_accessor :skip_blank

    attr_accessor :pagination_formatter
    attr_accessor :site_name_formatter

    def initialize
      # Set default site_name according to the Rails application class name
      self.site_name    = ::Rails.application.class.to_s.split("::").first
      self.skip_blank   = true

      self.default_page_description = ""
      self.default_page_keywords    = ""
      self.default_page_image       = ""

      self.pagination_formatter = lambda {|title, page_number| "#{title} - Page #{page_number}" }
      self.site_name_formatter  = lambda {|text, site_name|    "#{text} | #{site_name}"}
    end

  end
end