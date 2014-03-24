set :markdown_engine, :RedCloth

activate :directory_indexes

set :css_dir, 'assets/stylesheets'

set :js_dir, 'assets/javascripts'

set :images_dir, 'assets/images'

# Build-specific configuration
configure :build do
  activate :directory_indexes

  activate :minify_css

  activate :minify_javascript
end