require 'seo_helper/configuration'
require 'seo_helper/format'

module SeoHelper
  class << self
    attr_accessor :configuration
  end

  module Rails
    if ::Rails.version < "3.1"
      require "seo_helper/railtie"
    else
      require "seo_helper/engine"
    end
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
