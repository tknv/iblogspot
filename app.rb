#! ruby -Ku

require 'rubygems'
require 'sinatra'
require 'lib/blog'

error do
	e = request.env['sinatra.error']
	puts e.to_s
	puts e.backtrace.join("\n")
	"Application error"
end

helpers do
  
  def is_iphone_request?
    request.user_agent =~ /(Mobile\/.+Safari)/
  end
  
  def button_link_to(name, options, html_options = nil)
    html_options[:class] = "button"
    link_to(name, options, html_options)
  end
    
  def iui_toolbar(initial_caption, search_url = nil)
    back_button = button_link_to("", "#", :id => "backButton")
    header = content_tag(:h1, initial_caption, :id => "pageTile")
    search_link = if search_url 
                  then button_link_to("Search", search_url, :id => "searchButton")
                  else ""
                  end 
    content = [back_button, header, search_link].join("\n")
    content_tag(:div, content, :class => "toolbar")
  end
  
=begin  # for get list,under construction
  def blog_titles(item)
    onclick_one = "$('header_text').innerHTML='#{@iblog.titles}';"
    onclick_two = "$('backbutton').addEventListener('click',
      function() {$('header_text').innerHTML=@iblog.title; }, false);"
    link = link_to(@iblog.titles, @iblog.titles.option_hash, 
          :onclick => "#{onclick_one} " + " #{onclick_two}")
    content_tag(:li, link)
  end

  def link_to_replace(name, options, html_options = {})
    html_options[:target] = "_replace"
    link_to(name, options, html_options)
  end

  def link_to_external(name, options, html_options = {})
    html_options[:target] = "_self"
    link_to(name, options, html_options)
  end

  def link_to_target(target, name, options, html_options = {})
    if target == :replace 
    link_to_replace(name, options, html_options)
    elsif target == :self or target == :external
    link_to_external(name, options, html_options)
    else
    link_to(name, options, html_options)
    end
  end
  
  def append_options(list_content, options = {})
    list_content = options[:top] + list_content if options[:top]
    list_content += list_element(options[:more], :replace) if options[:more]
    list_content += options[:bottom] if options[:bottom]
    list_content
  end

  def iui_list(items, options = {})
    list_content = items.map {|i| list_element(i)}.join("\n")
    list_content = append_options(list_content, options)
    if options[:as_replace] 
     list_content
    else
     content_tag(:ul, list_content, :selected => "true")
    end
  end
=end
end

before do
    if is_iphone_request?
      then @request_from = "iphone"
      else @request_from = "other"
    end
end

get '/' do
  @iblog = Blog.new
  if @request_from == "iphone"
    then haml :iphone
    else haml :other  #debug=>iphone, prod=>other
  end
end

#Error handling
not_found do
    '404 This is nowhere to be found'
end