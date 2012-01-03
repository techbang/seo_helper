require "seo_helper/helper"

module SeoHelper
  class Railtie < Rails::Railtie
    initializer "seo_helper.view_helpers" do
      ActionView::Base.send :include, SeoHelper::Helper
    end

    initializer "seo_helper.controller_helpers" do
      ActionController::Base.send :include, SeoHelper::ControllerHelper
    end

    initializer "seo_helper.default_site_name" do
      # Set default SITE_NAME according to the Rails application class name
      SITE_NAME = Rails.application.class.to_s.split("::").first if not defined? SITE_NAME
    end
  end
end