# SeoHelper

SeoHelper is a set of helpers for rendering page-specific `<title>` tag, common `<meta />` tags and `<link rel='image_src' />` tag.

It contains not only a set of `tag()` helper wrappers, but can also help you doing things like

* specifying **title**, **description** and **image_url** for the current page, and render them with `<title>` and corresponding `meta`-tags or `link`-tags
* automatically append **page number** and **site name** into the title (both formats are customizable)

Pull requests are welcome.

# Usage

Add this to your Gemfile:

    gem 'seo_helper', '~> 1.0'

If you want to use the edge version on Github, specify the `:git` option.

    gem 'seo_helper', '~> 1.0', :git => 'git://github.com/techbang/seo_helper.git'

And run

    bundle install

to install this plug-in.

After installation, add `config/initializers/seo_helper.rb` into your Rails application, specifying the basic configuration like this:

```ruby
SeoHelper.configure do |config|
  config.site_name = "My Awesome Web Application"
end
```

Please specify at least the `site_name`, or SeoHelper will take the class name of your Rails application as default.

Don't forget to restart your Rails application.

# Page Title Rendering

It's always been a complex job to render a pretty title and put it in both the `<title>` tag and the title `meta` tag.  With SeoHelper, you can easily set and render the title text.

## Rendering the Default Title in Layout

First, put this in your layout file, between `<head>` and `</head>`:

```ruby
<%= render_page_title_tag %>
```

You can replace the hard-coded `<title>` tag with this helper.

Now visit any page of your application, you'll see that the browser's title will be the `site_name` that you specified (or the application's class name if not specified).

## Specifying the Title

To specify the title of current page in an controller action, for example, in the `Articles#show` action, use `set_page_title`

```ruby
def show
  # ...
  set_page_title @article.title
end
```

Now visit any article, you'll see the title becomes

    Article Title | My Awesome Web Application

The `site_name` is still a part of the title text.

If `params[:page]` exists it'll automatically be appended to the title.  For example, in `Articles#index`, when you visit the 2nd page, you'll see the title becomes

    Article Index - Page 2 | My Awesome Web Application

# Rendering SEO-oriented Tags

For SEO, you may want to put some `<meta>` tags and `<link rel="image-src" />` tag in your webpage.  With SeoHelper, you can easily do these things.

## Rendering Meta Tags for Title, Description and Keywords

First, put this in your layout file, between `<head>` and `</head>`:

```erb
<%= render_page_title_meta_tag %><%# This might be unnecessary %>
<%= render_page_description_meta_tag %>
<%= render_page_keywords_meta_tag %>
```

You can replace the hard-coded `<meta>` tags with these helpers.

To specify the description and keywords of current page in an controller action, for example, in the `Articles#show` action, use `set_page_description`

```ruby
def show
  # ...
  set_page_title       @article.title   # same as <title> tag
  set_page_description @article.excerpt # or @article.content.truncate(100)
  set_page_keywords    @article.tags    # or @article.keywords
end
```

Now visit any article, and open it's source, you'll see these meta tags:

```html
<meta name="title" content="Article Title | My Awesome Web Application" />
<meta name="description" content="Lorem ipsum dolor sit amet, ..." />
<meta name="keywords" content="faketext,lorem,ipsum" />
```

If `set_pages_keywords` receives an array, it'll convert the array to a string joined with a single comma (`','`).

## Rendering `<link rel="image_src" />` tag

This tag tells search engine what the related image of this page is.  To render this tag, put `render_page_image_link_tag` in your layout file, between `<head>` and `</head>`:

```ruby
<%= render_page_image_link_tag %>
```

You can replace the hard-coded `<link rel="image_src" />` tag with this helper.

To specify the title of current page in an controller action, for example, in the `Articles#show` action, use `set_page_image`

```ruby
def show
  # ...
  set_page_image @article.excerpt_image_url
end
```

Now visit any article, and open it's source, you'll see this link tag:

```html
<link href="http://www.example.com/articles/123/the-excerpt-image.jpg" rel="image_src" />
```

## Re-use Page-Specific SEO Data in View

Sometimes you may want to use the page title, description, keywords and the image url.  Say you're working with [OpenGraph Meta tags](http://developers.facebook.com/docs/opengraph/), you may re-use them in your view:

```erb
<meta property="og:title"       content="<%= page_title %>"/>
<meta property="og:description" content="<%= page_description %>"/>
<meta property="og:image"       content="<%= page_image %>"/>
```

You may also want to use our [OpenGraphHelper](https://github.com/techbang/open_graph_helper), too.

## Blank Tags: Skipping Them or Not

Sometimes you just want to skip SEO tags when their contents are empty.  This is the default behavior of SeoHelper, that is, if you've never `set_page_description` to something in a request flow, the meta description tag will not be rendered.

If you want to force SeoHelper to render a default description meta tag, keywords meta tag, or image_src link tag, you can explicitly tell SeoHelper with configure block, in the initializer:

```ruby
SeoHelper.configure do |config|
  # ...
  config.skip_blank               = false
  config.default_page_description = "This is a really really awesome website"
  config.default_page_keywords    = "hello,world,yay"
  config.default_page_image       = "http://www.example.com/title.png"
end
```

Then, when page description, keywords or image was not specified, SeoHelper will fallback to default text.

## Rendering SEO-oriented Tags Directly

While SeoHelper provides `set_page_XXX` and `render_page_XXX_meta_tag` helper pairs, it is still possible to render these meta tags directly, with the corresponding `XXX_meta_tag` helpers, the `title_tag` helper and the `image_src_link_tag` helper.

For example,

```erb
<%= title_tag("Hello! World") %>
<%= description_meta_tag("Lorem ipsum dolor sit amet!") %>
<%= image_src_link_tag("http://www.example.com/title.png") %>
```

yields

```html
<title>Hello! World</title>
<meta name="description" content="Lorem ipsum dolor sit amet!" />
<link rel="image_src" href="http://www.example.com/title.png" />
```

You can also add Site Name to the customized title, just put `true` as the second argument. For example, if you set `site_name` to `My Awesome Web Application`, then

```erb
<%= title_tag("Hello! World", true) %>
```

yields

```html
<title>Hello! World | My Awesome Web Application</title>
```

which applies the default format of site name in page title, and thus customizable (see below).

# Customizing Page Title Format

The page number format and site name format in a page title are customizable, via the configure block.  They're basically lambda blocks, and invoked dynamically during runtime.

## Customizing Format of Page Number in Title

The default format of Page Number in Title is:

    Title - Page X | My Awesome Web Application

Changing the page number format by specifying a new lambda block:

```ruby
SeoHelper.configure do |config|
  config.pagination_formatter = lambda { |title, page_number| "#{title} - Page No.#{page_number}" }
end
```

Now you'll get

    Title - Page No.X | My Awesome Web Application

as your page title.

## Customizing Format of Site Name in TItle

The default format of Site Name in Title is:

    Title | My Awesome Web Application

Changing the site name format by specifying a new lambda block:

```ruby
SeoHelper.configure do |config|
  config.site_name_formatter  = lambda { |title, site_name|   "#{title} &laquo; #{site_name}" }
end
```

Now you'll get

    Title &laquo; My Awesome Web Application

as your page title.

# License

This software is released under the MIT License.

Copyright (c) 2011- Techbang

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

