module SeoHelper
  class Configuration
    attr_accessor :site_name
    attr_accessor :description
    attr_accessor :keywords

    def initialize
      # Set default site_name according to the Rails application class name
      self.site_name = ::Rails.application.class.to_s.split("::").first
    end

  end
end