require 'seo_helper/configuration'
require 'seo_helper/format'

module SeoHelper
  class << self
    attr_accessor :configuration
  end

  module Rails
    case ::Rails.version.to_s
    when /^4/, /^5/, /^6/
      require "seo_helper/engine"
    when /^3\.[12]/
      require "seo_helper/engine3"
    when /^3\.[0]/
      require "seo_helper/railtie"
    end

  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
