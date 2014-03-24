module SiteHelpers

#Set default title
  def page_title
    #Append frontmatter title to default
    title = "JXF"
    if data.page.title
      title << " | " + data.page.title
    end
    title
  end

#Set default description
  def page_description
    if data.page.description
      description = data.page.description
    else
      #If no description in frontmatter use default
      description = "TODO"
    end
    description
  end

end

#Allow partials to work with haml
module Haml
  module Helpers
    def partial(template, *args)
      template_array = template.to_s.split('/')
      template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
      options = args.last.is_a?(Hash) ? args.pop : {}
      options.merge!(:layout => false)
      if collection = options.delete(:collection) then
        collection.inject([]) do |buffer, member|
          buffer << haml(:"#{template}", options.merge(:layout =>
          false, :locals => {template_array[-1].to_sym => member}))
        end.join("\n")
      else
        haml(:"#{template}", options)
      end
    end
  end
end