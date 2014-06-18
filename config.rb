require 'tilt'
require 'RedCloth'

set :markdown_engine, :RedCloth
set :markdown,
      :smartypants => true,
      :prettify => true

activate :syntax, :line_numbers => true, :inline_theme => nil

activate :directory_indexes

set :css_dir, 'assets/stylesheets'

set :js_dir, 'assets/javascripts'

set :images_dir, 'assets/images'

Time.zone = "US/Pacific"

activate :blog do |blog|
  blog.name = "blog"
  blog.prefix = "blog"
  blog.permalink = ":year/:month/:day/:title.html"
  blog.sources = ":year-:month-:day-:title.html"
  #blog.sources = ":year-:month-:day-:title"
  blog.taglink = "tags/:tag.html"
  blog.layout = "post"
  blog.summary_separator = /(READMORE)/
  blog.summary_length = 250
  blog.year_link = ":year.html"
  blog.default_extension = ".textile"
  blog.tag_template = "blog/tag.html"
  blog.calendar_template = "blog/calendar.html"
  blog.paginate = true
  blog.per_page = 2
  blog.page_link = "page/:num"
end

page "/feed.xml", layout: false

configure :build do
  activate :directory_indexes

  activate :minify_css

  activate :minify_javascript

  activate :google_analytics do |ga|
    ga.tracking_id = 'XX-XXXXXXXX-X'
  end

end

helpers do
  def dt(datetime)
    datetime = Date.parse(datetime) if datetime.is_a? String
    "<span class=\"datetime\" title=>#{datetime.strftime("%b %d, '%y")}</span>"
  end

  def tag_list(array, prefix="/blog")
    array ||= []
    array = [*array.split(/\s+,\s+/)].compact unless array.is_a? Array
    array.map{|tag| link_to tag, "#{prefix}/tags/#{tag}/" }.join ", "
  end

  def nav_link(name, url, options={})
    options = {
      class: "",
      active_if: url,
      page: current_page.url,
    }.update options
    active_url = options.delete(:active_if)
    active = Regexp === active_url ? current_page.url =~ active_url : current_page.url == active_url
    options[:class] += " active" if active

    link_to name, url, options
  end

  def blog_link(article)
    if article.data.link
      "#{link_to article.title, article.data.link} <span class=\"external-link\">&raquo;</span>"
    else
      link_to article.title, article
    end
  end

  def get_page_title
    yield_content(:title) || current_page.data.title
  end

  def get_article_icon
    current_page.data.icon
  end
end