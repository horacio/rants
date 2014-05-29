###
# Blog settings
###

Time.zone = "UTC"

activate :blog do |blog|
  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"
  blog.summary_separator = /READMORE/
end

activate :directory_indexes

page "/feed.xml", layout: false

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :build_dir, 'tmp'

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css
end
