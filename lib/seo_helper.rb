module SeoHelper
  module Rails
    if ::Rails.version < "3.1"
      require "seo_helper/railtie"
    else
      require "seo_helper/engine"
    end
  end
end
