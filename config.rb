###
# Blog settings
###

Time.zone = "UTC"

activate :blog do |blog|
  blog.sources = "/posts/:year-:month-:day-:title.html"
  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"
  blog.summary_separator = /READMORE/
end

activate :relative_assets
set :relative_links, true

activate :directory_indexes
activate :syntax

page "/posts/*", layout: :post_layout
page "/feed.xml", layout: false

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css
end
