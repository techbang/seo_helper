module SeoHelper
  class Configuration
    attr_accessor :site_name
    attr_accessor :description
    attr_accessor :keywords

    attr_accessor :skip_blank

    def initialize
      # Set default site_name according to the Rails application class name
      self.site_name    = ::Rails.application.class.to_s.split("::").first
      self.skip_blank   = true
    end

  end
end