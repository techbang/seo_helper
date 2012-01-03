require "seo_helper/helper"

module SeoHelper
  class Engine < ::Rails::Engine
    initializer "seo_helper.view_helpers" do
      ActionView::Base.send :include, SeoHelper::Helper
    end
  end
end